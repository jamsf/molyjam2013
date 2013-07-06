package net.molyjam.worlds 
{
	import net.molyjam.entities.persons.Player;
	/**
	 * ...
	 * @author Jams
	 */
	public class Land extends IsoWorld
	{
		
		public function Land() 
		{
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			add(new Player());
		}
		
		override public function update():void 
		{
			super.update();
			
		}
	}

}