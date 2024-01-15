package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.utils.Assets;

class Main extends Sprite
{
	public static final menuMusic:String = "klaskiiLoop";
	public static final frameRate:Int = #if desktop 144 #else 60 #end;

	public static var modelView:ModelView;

	public function new():Void
	{
		super();

		FlxG.signals.gameResized.add(onResizeGame);
		FlxG.signals.preStateCreate.add(onStateCreate);

		addChild(new FlxGame(1280, 720, Startup, frameRate, frameRate, true));
		addChild(new FPS(10, 10, 0xFFFFFFFF));
	}

	private function onResizeGame(width:Int, height:Int):Void
	{
		if (FlxG.cameras == null)
			return;

		for (cam in FlxG.cameras.list)
		{
			@:privateAccess
			if (cam != null && (cam._filters != null && cam._filters.length > 0))
			{
				var sprite:Sprite = cam.flashSprite; // Shout out to Ne_Eo for bringing this to my attention
				if (sprite != null)
				{
					sprite.__cacheBitmap = null;
					sprite.__cacheBitmapData = null;
					sprite.__cacheBitmapData2 = null;
					sprite.__cacheBitmapData3 = null;
					sprite.__cacheBitmapColorTransform = null;
				}
			}
		}
	}

	private function onStateCreate(state:FlxState):Void
	{
		// Clear the loaded graphics if they are no longer in flixel cache...
		for (key in Assets.cache.getBitmapKeys())
			if (!FlxG.bitmap.checkCache(key))
				Assets.cache.removeBitmapData(key);

		// Clear the loaded songs as they use the most memory...
		Assets.cache.clear('assets/songs');

		// Run the garbage colector...
		openfl.system.System.gc();
	}
}
