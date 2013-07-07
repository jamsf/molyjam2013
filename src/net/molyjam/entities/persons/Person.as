package net.molyjam.entities.persons
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.molyjam.entities.weapons.Weapon;
	
	import net.molyjam.entities.IsoEntity;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Person extends IsoEntity 
	{
		/* Life Variables */
		protected var _health	: int;
		
		/* Movement Variables */
		/** @protected */ protected var _xVel		:Number;
		/** @protected */ protected var _yVel		:Number;
		/** @protected */ protected var _xMaxVel	:Number;
		/** @protected */ protected var _yMaxVel	:Number;
		/** @protected */ protected var _accel		:Number;
		/** @protected */ protected var _decel		:Number;
		/** @protected */ protected var _focus		:Point;
		
		/** @protected */ protected var _spriteMap	:Spritemap;
		
		/** @protected */ protected var _weapon 	: Weapon;
		
		public function Person() 
		{
			super();
			collidable = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_health < 1)
			{
				FP.world.remove(this);
				return;
			}
			this.moveBy(_xVel, _yVel, _solidWith, false);
			updateAnimation();
		}
		
		override public function added():void 
		{
			super.added();
			
			width = 64;
			height = 128;
			
			_health = 100;
			_xVel = 0;
			_yVel = 0;
			_solidWith = new Array("Structure", "Wall", "NPC");
			setHitbox(width, height * 0.25, x, y + height * 0.75);
			width = 64;
			height = 128;
		}
		
		protected function updateAnimation():void
		{
			
		}
		
		public function damage(amount:int) : void
		{
			_health -= amount;
		}
		
		public function heal(amount:int) : void
		{
			_health = Math.min(100, _health + amount);
		}
		
		public function focus() : Point { return _focus; }
	}
}