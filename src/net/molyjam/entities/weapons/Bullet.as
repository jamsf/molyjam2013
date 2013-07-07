package net.molyjam.entities.weapons 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.molyjam.entities.persons.Person;
	
	/**
	 * ...
	 * @author James Farmer
	 */
	public class Bullet extends Entity 
	{
		private const VELOCITY : int = 40;
		private const COLLIDABLE : Array = new Array("Structure", "Person");
		
		private var _angle : Number;
		
		public function Bullet(angle:Number) 
		{
			
		}
		
		override public function update():void 
		{
			super.update();
			
			x += VELOCITY * cos(angle);
			y += VELOCITY * sin(angle);
			
			var obj : Object = null;
			collideTypesInto(COLLIDABLE, x, y, obj);
			if (obj != null)
			{
				// Deal Damage to whatever it hits
				for( var o in obj)
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