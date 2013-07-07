package net.molyjam.worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	import net.molyjam.entities.persons.Player;
	
	/**
	 * ...
	 * @author Jams
	 */
	public class IsoWorld extends World
	{
		protected var player : Player;
		protected var guns : Array;
		protected var npcs	: Array;
		
		public function IsoWorld() 
		{
			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
		}
	}
}