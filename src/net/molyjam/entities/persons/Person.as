package net.molyjam.entities.persons
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import net.molyjam.entities.IsoEntity;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Person extends IsoEntity 
	{
		
		
		/* Movement Variables */
		/** @protected */ protected var _xVel		:Number;
		/** @protected */ protected var _yVel		:Number;
		/** @protected */ protected var _xMaxVel	:Number;
		/** @protected */ protected var _yMaxVel	:Number;
		/** @protected */ protected var _accel		:Number;
		/** @protected */ protected var _decel		:Number;
		
		/** @protected */ protected var _spriteMap	:Spritemap;
		
		public function Person() 
		{
			_xVel = 0;
			_yVel = 0;
			_solidWith = new Array("Structure", "Wall", "NPC");
			
			setHitbox(width, height * 0.25, x, y + height * 0.75);
		}
		
		override public function update():void 
		{
			super.update();
			
			this.moveBy(_xVel, _yVel, _solidWith, false);
			updateAnimation();
		}
		
		protected function updateAnimation():void
		{
			
		}
	}
}