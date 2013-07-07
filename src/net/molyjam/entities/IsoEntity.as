package net.molyjam.entities 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Jams
	 */
	public class IsoEntity extends Entity
	{
		
		/** @protected */ protected var _solidWith	:Array;
		
		public function IsoEntity() 
		{
			
		}
		
		override public function update():void 
		{
			super.update();
			
			layer = -y - height;
		}
	}

}