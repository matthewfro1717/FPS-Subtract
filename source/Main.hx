package;

import flixel.system.scaleModes.RatioScaleMode;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite {
	#if !mobile
	public static var overlay:backend.overlay.Overlay;
	#end

	public static var novid:Bool = false;
	public static var flippymode:Bool = false;

	public function new() {
		super();

		#if sys
		novid = Sys.args().contains("-novid");
		flippymode = Sys.args().contains("-flippymode");
		#end

		addChild(new FlxGame(0, 0, Startup, 144, 144, true));

		#if !mobile
		overlay = new backend.overlay.Overlay();
		addChild(overlay);
		#end

		// On web builds, video tends to lag quite a bit, so this just helps it run a bit faster.
		#if web
		VideoHandler.MAX_FPS = 30;
		#end

		trace("-=Args=-");
		trace("novid: " + novid);
		trace("flippymode: " + flippymode);
	}
}
