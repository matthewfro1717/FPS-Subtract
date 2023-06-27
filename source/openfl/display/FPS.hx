package openfl.display;

import flixel.util.FlxStringUtil;
import openfl.Lib;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int = 0;

	/**
		Whether to show the ram usage or not.
	**/
	public var showRAM:Bool = true;

	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;

		autoSize = LEFT;
		selectable = mouseEnabled = false;

		defaultTextFormat = new TextFormat('_sans',
			#if mobile Std.int(14 * Math.min(Lib.current.stage.stageWidth / FlxG.width, Lib.current.stage.stageHeight / FlxG.height)) #else 14 #end, color);

		currentTime = 0;
		times = [];

		addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var time:Int = Lib.getTimer();
			onEnterFrame(time - currentTime);
		});

		#if mobile
		addEventListener(Event.RESIZE, function(e:Event)
		{
			final daSize:Int = Std.int(14 * Math.min(Lib.current.stage.stageWidth / FlxG.width, Lib.current.stage.stageHeight / FlxG.height));
			if (defaultTextFormat.size != daSize)
				defaultTextFormat.size = daSize;
		});
		#end
	}

	private function onEnterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;

		times.push(currentTime);

		while (times[0] < currentTime - 1000)
			times.shift();

		var currentFrames:Int = times.length;
		if (currentFrames > Std.int(Lib.current.stage.frameRate))
			currentFPS = Std.int(Lib.current.stage.frameRate);
		else
			currentFPS = currentFrames;

		final stats:Array<String> = [];
		stats.push('FPS: ${currentFPS}');

		if (showRAM)
			stats.push('RAM: ${FlxStringUtil.formatBytes(System.totalMemory)}');

		stats.push(''); // adding this to not hide the last line.
		text = stats.join('\n');
	}
}
