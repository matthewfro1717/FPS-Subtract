package title;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

using StringTools;

class TitleVideo extends FlxState {
	var titleState:TitleScreen = new TitleScreen();

	override public function create():Void {
		super.create();

		if (!Main.novid) {
			#if hxCodec
			var video = new hxcodec.flixel.FlxVideoSprite();
			video.play(Paths.video('klaskiiTitle'));
			video.bitmap.onEndReached.add(next);
			add(video);
			#else
			next();
			#end
		}
		else
			next();
	}

	function next():Void {
		FlxG.camera.flash(FlxColor.WHITE, 60);
		FlxG.sound.playMusic(Paths.music(TitleScreen.titleMusic), 1);
		Conductor.changeBPM(158);
		FlxG.switchState(titleState);
	}
}
