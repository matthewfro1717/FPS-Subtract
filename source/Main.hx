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

		#if sys
		novid = Sys.args().contains("-novid");
		flippymode = Sys.args().contains("-flippymode");
		#end

		addChild(new FlxGame(1280, 720, Startup, 144, 144, true));

		fpsCounter = new FPS();
		addChild(fpsCounter);

		trace("-=Args=-");
		trace("novid: " + novid);
		trace("flippymode: " + flippymode);
	}
}
