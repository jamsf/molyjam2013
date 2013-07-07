package net.molyjam
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.molyjam.worlds.Land;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Main extends Engine 
	{
		private var consoleOn : Boolean = true;
		
		public function Main():void 
		{
			super(800, 600, 60, false);

			// Create initial world
			FP.world = new Land();
			FP.console.enable();
		}

		override public function init():void
		{
			trace("THIS IS WORKING PROPERLY");
		}

		override public function update():void 
		{
			super.update();

			if (Input.check(Key.DELETE))
				if (consoleOn) FP.console.visible = true; else FP.console.visible = false;
				
			Input.mouseCursor = "hide";
		}
	}
	
}