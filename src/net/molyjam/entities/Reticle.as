package net.molyjam.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author jams
	 */
	public class Reticle extends Entity
	{
		[Embed(source = '/../assets/graphics/spr_reticle.png')] private const RETICLE:Class;
		
		public function Reticle() 
		{
			graphic = new Image(RETICLE);
		}
		
		override public function update():void 
		{
			super.update();
			
			x = Input.mouseFlashX;
			y = Input.mouseFlashY;
		}
	}
}