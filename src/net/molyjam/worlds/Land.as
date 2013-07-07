package net.molyjam.worlds 
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import net.molyjam.entities.persons.Player;
	import net.molyjam.entities.weapons.GunFactory;
	
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
			
			player = new Player();
			add(player);
			player.setWeapon(GunFactory.createPistol(player));
		}
		
		override public function update():void 
		{
			super.update();
			
			
		}
	}

}