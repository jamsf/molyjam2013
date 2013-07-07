package net.molyjam.entities.weapons 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.molyjam.entities.IsoEntity;
	
	import net.molyjam.entities.persons.Player;
	import net.molyjam.entities.persons.Person;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Weapon extends IsoEntity 
	{
		/** @protected */ protected var _holding	: Person;
		/** @protected */ protected var _spriteMap	: Spritemap;
		
		public function Weapon(person:Person=null) 
		{
			super();
			_holding = person;
			this.type = "Weapon";
			collidable = true;
		}
		
		override public function update():void 
		{
			super.update();
			updateAnimation();
		}
		
		protected function updateAnimation():void
		{
			/*
			if (_holding == null)
				_spriteMap.play("notHolding")
			else
			{
				var mouseX : int = _holding.focus().x;
				var mouseY : int = _holding.focus().y;
				var angle:Number = FP.angle(_holding.middleX, _holding.middleY, Input.mouseX, Input.mouseY);
				
				if (_holding is Player)
				{
					if (mouseX > _holding.x + _holding.width * 0.5)
						_spriteMap.play("rightSide");
					else
						_spriteMap.play("leftSide");
					
					// Move gun around according to angle and position of mouse
					if (FP.distance(mouseX, mouseY, _holding.middleX - width*0.5, _holding.middleY - height*0.5 - 16 ) < 50)
					{
						x = mouseX;
						y = mouseY;
					}
					else
					{
						FP.angleXY(this, angle, 50, _holding.middleX, _holding.middleY - 16);
					}
					
					// Rotate gun
					_spriteMap.angle = angle;
				}
			}
			*/
		}
		
		public function fire(angle:Number) : void 
		{ 
			
		}
		
		public function canFire() : Boolean
		{
			return true;
		}
		
		public function getHolding():Person { return _holding; }
		public function setHolding(person:Person):void
		{
			_holding = person;
		}
		
		public function setSpriteMap(map:Spritemap) : void { _spriteMap = map }
		public function getSpriteMap() : Spritemap { return _spriteMap; }
	}
}