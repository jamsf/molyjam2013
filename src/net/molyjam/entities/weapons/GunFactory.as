package net.molyjam.entities.weapons 
{
	import net.flashpunk.graphics.Spritemap;
	import net.molyjam.entities.persons.Person;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author James Farmer
	 */
	public class GunFactory 
	{
		[Embed(source = '/../assets/graphics/spr_pistol.png')] public static const PISTOL:Class;
		[Embed(source = '/../assets/graphics/spr_uzi.png')] public static const UZI:Class;
		
		public function GunFactory() 
		{
			
		}
		
		public static function createPistol(person:Person=null, x:int = 0, y:int = 0 ):Gun
		{	
			var pistol : Gun = new Gun();
			pistol.ammunition = 9;
			pistol.automatic = false;
			pistol.setHolding(person);
			if (person == null)
			{
				pistol.x = x;
				pistol.y = y;
			}
			var spriteMap:Spritemap = new Spritemap(PISTOL, 36, 36);
			spriteMap.add("notHolding", [0]);
			spriteMap.add("leftSide", [1]);
			spriteMap.add("rightSide", [2]);
			spriteMap.centerOO();
			
			pistol.setSpriteMap(spriteMap);
			pistol.graphic = spriteMap;
			pistol.width = 36;
			pistol.height = 36;
			
			FP.world.add(pistol);
			return pistol;
		}
		
		public static function createUzi(person:Person=null, x:int = 0, y:int = 0 ):Gun
		{
			var uzi : Gun = new Gun();
			uzi.ammunition = 30;
			uzi.automatic = true;
			uzi.fireRate = 5;
			if (person == null)
			{
				uzi.x = x;
				uzi.y = y;
			}
			var spriteMap:Spritemap = new Spritemap(UZI, 63, 54);
			spriteMap.add("notHolding", [0]);
			spriteMap.add("leftSide", [1]);
			spriteMap.add("rightSide", [2]);
			spriteMap.topCenterOrigin();
			
			uzi.setSpriteMap(spriteMap);
			uzi.graphic = spriteMap;
			uzi.setHolding(person);
			uzi.width = 63;
			uzi.height = 54;
			
			FP.world.add(uzi);
			return uzi;
		}
	}
}