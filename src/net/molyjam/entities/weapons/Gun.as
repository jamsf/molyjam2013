package net.molyjam.entities.weapons 
{
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author James Farmer
	 */
	public class Gun extends Weapon 
	{
		public var ammunition : int;
		public var triggerDown : Boolean;
		
		public var automatic : Boolean;
		public var fireRate : int;
		public var fireTimer : int;
		
		public function Gun()
		{
			super();
			triggerDown = false;
		}
		
		override public function update():void 
		{
			super.update();
			fireTimer = Math.max(0, fireTimer - 1);
		}
		
		override public function fire(angle:Number) : void
		{
			FP.world.add(new Bullet(x, y + 12, angle));
			fireTimer = fireRate;
			triggerDown = true;
			FP.console.log("BULLET ADDED");
		}
		
		override public function canFire():Boolean 
		{
			if (ammunition < 0)
				return false;
			else if (automatic && fireTimer != 0)
				return false;
			else if (!automatic && triggerDown) 
				return false;
			else
				return true;
		}
		
		public function releaseTrigger() : void
		{
			triggerDown = false;
		}
		
		public function setFireRate(rate:int) : void
		{
			fireRate = rate;
			fireTimer = 0;
		}
	}
}