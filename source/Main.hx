package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite {
	public static var novid:Bool = false;
	public static var flippymode:Bool = false;
	public static var fpsCounter:FPS;

	public function new() {
		super();

		FlxG.signals.preStateCreate.add(function(state:FlxState)
		{
			// Clear the loaded graphics if they are no longer in flixel cache...
			for (key => value in Assets.cache.bitmapData)
				if (!FlxG.bitmap.checkCache(key))
					Assets.cache.removeBitmapData(key);

			// Clear the loaded songs as they use the most memory...
			Assets.cache.clear('assets/songs');

			// Run the garbage colector...
			System.gc();
		});
		FlxG.signals.postStateCreate.add(System.gc);

		addChild(new FlxGame(1280, 720, Startup, 144, 144, true));

		fpsCounter = new FPS();
		addChild(fpsCounter);
	}
}
