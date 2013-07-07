package net.molyjam.entities.weapons 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	import net.molyjam.entities.persons.Person;
	
	/**
	 * ...
	 * @author James Farmer
	 */
	public class Bullet extends Entity 
	{
		
		[Embed(source = '/../assets/graphics/spr_bullet.png')] public static const BULLET:Class;
		
		private const VELOCITY : int = 40;
		private const COLLIDABLE : Array = new Array("Structure", "Person");
		
		private var _angle : Number;
		private var _rad : Number;
		
		public function Bullet(x:int, y:int, angle:Number) 
		{
			this.x = x;
			this.y = y;
			this.graphic = new Spritemap(BULLET, 4, 2);
			this._angle = angle;
			this._rad = angle * FP.RAD;
			// Randomize the rad
			
			trace("ANGLE: " + String(_angle));
		}
		
		override public function update():void 
		{
			super.update();
			x += VELOCITY * Math.cos(_rad);
			y += VELOCITY * Math.sin(_rad);
			
			var obj : Object = null;
			collideTypesInto(COLLIDABLE, x, y, obj);
			if (obj != null)
			{
				// Deal Damage to whatever it hits
				for(var o in obj)
				{
					if (o is Person)
					{
						(o as Person).damage(50);
					}
				}
				
				// Remove from world
				FP.world.remove(this);
				return;
			}
		}
		
	}
}