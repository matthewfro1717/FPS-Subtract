package title;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

using StringTools;

class TitleVideo extends FlxState
{
	var titleState:TitleScreen = new TitleScreen();

	#if VIDEOS
	var video:hxcodec.flixel.FlxVideoSprite;
	#end

	override public function create():Void
	{
		super.create();

		#if VIDEOS
		video = new hxcodec.flixel.FlxVideoSprite();
		video.play(Paths.video('klaskiiTitle'));
		video.bitmap.onEndReached.add(next);
		add(video);
		#else
		next();
		#end
	}

	#if VIDEOS
	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE)
		{
			video.stop();
			video.destroy();
			remove(video);
			next();
		}
	}
	#end

	function next():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, 60);
		FlxG.sound.playMusic(Paths.music(TitleScreen.titleMusic), 1);
		Conductor.changeBPM(158);
		FlxG.switchState(titleState);
	}
}
