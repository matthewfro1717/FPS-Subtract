package funkin.states.title;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import funkin.backend.Conductor;
#if VIDEOS
import hxcodec.flixel.FlxVideo;
#end

using StringTools;

class TitleVideo extends FlxState
{
	#if VIDEOS
	var video:FlxVideo;
	#end

	override public function create():Void
	{
		super.create();

		#if VIDEOS
		video = new FlxVideo();
		video.onEndReached.add(function()
		{
			video.dispose();
			next();
		});
		video.play(Paths.video('klaskiiTitle'));
		#else
		next();
		#end
	}

	#if VIDEOS
	override function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE)
			video.onEndReached.dispatch();

		super.update(elapsed);
	}
	#end

	function next():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, 60);

		Conductor.bpm = 158;
		FlxG.sound.playMusic(Paths.music(Main.menuMusic), 1);
		FlxG.switchState(new TitleScreen());
	}
}
