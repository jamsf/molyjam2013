package net.molyjam.entities.persons 
{
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
		}
		
		override public function update():void 
		{
			updateMovement();
			super.update();
		}
		
		private function updateMovement():void
		{
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
	}
}