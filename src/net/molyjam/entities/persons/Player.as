package net.molyjam.entities.persons 
{
	import flash.events.WeakFunctionClosure;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.molyjam.entities.weapons.Gun;
	import net.molyjam.entities.weapons.Weapon;
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.MathPlus;
	import net.flashpunk.FP;
	
	import net.molyjam.entities.Reticle;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Player extends Person 
	{
		[Embed(source = '/../assets/graphics/map_player.png')] private const PLAYER_SPRITEMAP:Class;
		
		/* Variables */
		/** @private */ private var _reticle	:Reticle;
		
		public function Player() 
		{
			_xMaxVel = 4;
			_yMaxVel = 3;
			_accel = 0.75;
			_decel = 2;
			
			_reticle = new Reticle();
			FP.world.add(_reticle);
			
			_spriteMap = new Spritemap(PLAYER_SPRITEMAP, 64, 128);
			_spriteMap.add("leftStand", [0]);
			_spriteMap.add("rightStand", [1]);
			
			_spriteMap.add("rightForWalk", [4, 5, 6, 7], 5, true);
			_spriteMap.add("leftForWalk", [8, 9, 10, 11], 5, true);
			_spriteMap.add("rightBackWalk", [7, 6, 5, 4], 5, true);
			_spriteMap.add("leftBackWalk", [11, 10, 9, 8], 5, true);
			
			_spriteMap.add("rightForRun", [12, 13, 14, 15], 8, true);
			_spriteMap.add("leftForRun", [16, 17, 18, 19], 8, true);
			_spriteMap.add("rightBackRun", [15, 14, 13, 12], 8, true);
			_spriteMap.add("leftBackRun", [19, 18, 17, 16], 8, true);
			
			graphic = _spriteMap;
			_focus = new Point();
		}
		
		override public function update():void 
		{
			updateMovement();
			updateWeaponControl();
			super.update();
		}
		
		private function updateMovement():void
		{
			// Check for sprinting
			if (Input.check(Key.SHIFT)) { _xMaxVel = 6; _yMaxVel = 4; }
			else { _xMaxVel = 4; _yMaxVel = 3; }
			
			// Y axis movement
			if (Input.check(Key.S))
			{
				if (_yVel < 0)
					_yVel += _decel;
				else
				{
					if (_yVel < _yMaxVel)
						_yVel += _accel;
					else
						_yVel = _yMaxVel;
				}
			}
			else if (Input.check(Key.W))
			{
				if (_yVel > 0)
					_yVel -= _decel;
				else
				{
					if (_yVel > -_yMaxVel)
						_yVel -= _accel;
					else
						_yVel = -_yMaxVel;
				}
			}
			else
			{
				// FRICTION
				_yVel = _yVel - Math.min(Math.abs(_yVel), _accel) * MathPlus.sgn(_yVel);
			}
			
			// X axis movement
			if (Input.check(Key.D))
			{
				if (_xVel < 0)
					_xVel += _decel;
				else
				{
					if (_xVel < _xMaxVel)
						_xVel += _accel;
					else
						_xVel = _xMaxVel;
				}
			}
			else if (Input.check(Key.A))
			{
				if (_xVel > 0)
					_xVel -= _decel;
				else
				{
					if (_xVel > -_xMaxVel)
						_xVel -= _accel;
					else
						_xVel = -_xMaxVel;
				}
			}
			else
			{
				// FRICTION
				_xVel = _xVel - Math.min(Math.abs(_xVel), _accel) * MathPlus.sgn(_xVel);
			}
			
			// Update facing direction
			_focus.x = Input.mouseX;
			_focus.y = Input.mouseY;
		}
		
		protected function updateWeaponControl() : void
		{
			// Check if we're picking up or dropping a weapon
			if (Input.released(Key.E))
			{
				if (collide("Weapon", x, y))
					FP.console.log("You are colliding with a gun");
				else
					FP.console.log("You are NOT colliding with a gun");
				
				var weapon : Weapon = collide("Weapon", x, y + height) as Weapon;
				if (weapon === _weapon) weapon = null;
				
				dropWeapon();
				
				if (weapon)
				{
					_weapon = weapon;
				}
			}
			
			// Update Weapon Holding
			if (_weapon != null)
			{
				var angle:Number = FP.angle(middleX, middleY, Input.mouseX, Input.mouseY);
				
				if (Input.mouseX > x + width * 0.5)
				{
					_weapon.getSpriteMap().topCenterOrigin();
					_weapon.getSpriteMap().play("rightSide");
					_weapon.layer = layer - 2;
				}
				else
				{
					_weapon.getSpriteMap().bottomCenterOrigin();
					_weapon.getSpriteMap().play("leftSide");
					_weapon.layer = layer + 2;
				}
				
				// Move gun around according to angle and position of mouse
				if (FP.distance(Input.mouseX, Input.mouseY, middleX - _weapon.width*0.5, middleY - _weapon.height*0.5 - 16 ) < 60)
				{
					_weapon.x = Input.mouseX - _weapon.originX;
					_weapon.y = Input.mouseY - _weapon.originY;
				}
				else
				{
					FP.angleXY(_weapon, angle, 60, middleX, middleY - 16);
				}
				
				// Rotate gun
				_weapon.getSpriteMap().angle = angle;
				
				
				// Check if firing
				if (Input.mouseDown)
				{
					// Gun Recoil
					if (_weapon.canFire())
					{
						var kickback : Number = 55 - (Math.random() * 10);
						if (Math.random() > 0.5)
							FP.angleXY(_weapon, angle + (Math.random()*20), kickback, middleX, middleY - 16);
						else
							FP.angleXY(_weapon, angle - (Math.random()*20), kickback, middleX, middleY - 16);
						
						_weapon.fire(angle);
					}
				}
				else if (_weapon is Gun)
				{
					(_weapon as Gun).releaseTrigger();
				}
			}
		}
		
		override protected function updateAnimation():void 
		{
			super.updateAnimation();
			
			if (Input.check(Key.SHIFT))
			{
				if (Input.mouseX < x + this.width * 0.5)
				{
					if (_xVel > 0)
						_spriteMap.play("leftBackRun");
					else if (_xVel < 0 || _yVel != 0)
						_spriteMap.play("leftForRun");
					else
						_spriteMap.play("leftStand");
				}
				else
				{
					if (_xVel < 0)
						_spriteMap.play("rightBackRun");
					else if (_xVel > 0 || _yVel != 0)
						_spriteMap.play("rightForRun");
					else
						_spriteMap.play("rightStand");
				}
			}
			else
			{
				if (Input.mouseX < x + this.width * 0.5)
				{
					if (_xVel > 0)
						_spriteMap.play("leftBackWalk");
					else if (_xVel < 0 || _yVel != 0)
						_spriteMap.play("leftForWalk");
					else
						_spriteMap.play("leftStand");
				}
				else
				{
					if (_xVel < 0)
						_spriteMap.play("rightBackWalk");
					else if (_xVel > 0 || _yVel != 0)
						_spriteMap.play("rightForWalk");
					else
						_spriteMap.play("rightStand");
				}
			}
		}
		
		public function setWeapon(weapon:Weapon) : void { _weapon = weapon; }
		
		private function dropWeapon() : void
		{
			if (_weapon != null)
			{
				_weapon.getSpriteMap().play("notHolding");
				_weapon.y = y + height - (_weapon.height * 0.5);
				_weapon = null;
			}
		}
	}
}