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
		}
		
		public function fire() : void
		{
			if (ammunition > 0)
			{
				if (automatic && fireTimer != 0)
				{
					--fireTimer;
					return;
				}
				else if (!automatic && !triggerDown) 
				{
					return;
				}
				else
				{
					// TODO - create bullet
					fireTimer = fireRate;
					triggerDown = true;
				}
			}
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