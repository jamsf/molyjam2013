package net.molyjam.entities.structures 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	import net.molyjam.entities.structures.Wall;
	
	/**
	 * ...
	 * @author James Farmer
	 */
	public class StructureFactory 
	{
		
		[Embed(source = '/../assets/graphics/spr_backwall.png')] public const BACKWALL:Class;
		[Embed(source = '/../assets/graphics/spr_leftwall.png')] public const LEFTWALL:Class;
		[Embed(source = '/../assets/graphics/spr_rightwall.png')] public const RIGHTWALL:Class;
		[Embed(source = '/../assets/graphics/spr_forwall.png')] public const FORWALL:Class;
		
		public function StructureFactory() 
		{
			
		}
		
		public static function createBackWall(x:int, y:int)
		{
			var wall:Wall = new Wall();
			wall.x = x;
			wall.y = y;
			wall.graphic = new Image(BACKWALL);
			wall.setHitbox(width, height * 0.25, x, y + height * 0.75);
			FP.world.add(wall);
		}
		
		public static function createLeftWall(x:int, y:int)
		{
			var wall:Wall = new Wall();
			wall.x = x;
			wall.y = y;
			wall.graphic = new Image(LEFTWALL);
			wall.setHitbox(width, height * 0.25, x, y + height * 0.75);
			FP.world.add(wall);
		}
		
		public static function createRightWall(x:int, y:int)
		{
			var wall:Wall = new Wall();
			wall.x = x;
			wall.y = y;
			wall.graphic = new Image(RIGHTWALL);
			wall.setHitbox(width, height * 0.25, x, y + height * 0.75);
			FP.world.add(wall);
		}
		
		public static function createForWall(x:int, y:int)
		{
			var wall:Wall = new Wall();
			wall.x = x;
			wall.y = y;
			wall.graphic = new Image(FORWALL);
			wall.setHitbox(width, height * 0.25, x, y + height * 0.75);
			FP.world.add(wall);
		}
		
		public static function createLevel(level:String, startX:int = 0, startY:int = 0) : void
		{
			var x : int = startX - 32;
			var y : int = startY;
			for (var i:uint = 0; i < level.length; ++i)
			{
				x += 32;
				switch(level.charAt(i))
				{
					case "\n":
						y += 32;
						x = startX - 32;
						break;
					case "b":
						createBackWall(x, y);
						break;
					case "r":
						createRightWall(x, y);
						break;
					case "l":
						createLeftWall(x, y);
						break;
					case "f":
						createForWall(x, y);
						break;
				}
			}
		}
	}
}