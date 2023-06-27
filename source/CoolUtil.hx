package;

import flixel.FlxG;
import flixel.math.FlxMath;
import openfl.utils.Assets;
import sys.FileSystem;
import sys.io.File;

using StringTools;

@:keep class CoolUtil
{
	public static inline function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = getText(path).trim().split('\n');
		return [for (i in 0...daList.length) daList[i].trim()];
	}

	public static inline function numberArray(max:Int, ?min = 0):Array<Int>
	{
		return [for (i in min...max) i];
	}

	/**
		Lerps camera, but accountsfor framerate shit?
		Right now it's simply for use to change the followLerp variable of a camera during update
		TODO LATER MAYBE:
			Actually make and modify the scroll and lerp shit in it's own function
			instead of solely relying on changing the lerp on the fly
	 */
	public static inline function fpsAdjust(value:Float, ?referenceFps:Float = 60):Float
	{
		return value * (FlxG.elapsed / (1 / referenceFps));
	}

	/*
	 * just lerp that does camLerpShit for u so u dont have to do it every time
	 */
	public static inline function fpsAdjsutedLerp(a:Float, b:Float, ratio:Float):Float
	{
		return FlxMath.lerp(a, b, fpsAdjust(ratio));
	}

	/*
	 * Uses FileSystem.exists for desktop and Assets.exists for non-desktop builds.
	 * This is because Assets.exists just checks the manifest and can't find files that weren't compiled with the game.
	 * This also means that if you delete a file, it will return true because it's still in the manifest.
	 * FileSystem only works on certain build types though (namely, not web).
	 */
	public static inline function exists(path:String):Bool
	{
		#if desktop
		return FileSystem.exists(path);
		#else
		return Assets.exists(path);
		#end
	}

	// Same as above but for getting text from a file.
	public static inline function getText(path:String):String
	{
		return #if sys File.getContent(path) #else Assets.getText(path) #end;
	}

	public static inline function inRange(a:Float, b:Float, tolerance:Float)
	{
		return (a <= b + tolerance && a >= b - tolerance);
	}

	public static inline function boundInt(Value:Int, ?Min:Int, ?Max:Int):Int
	{
		var lowerBound:Int = (Min != null && Value < Min) ? Min : Value;
		return (Max != null && lowerBound > Max) ? Max : lowerBound;
	}

	public static inline function truncateFloat(number:Float, precision:Int):Float
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round(num) / Math.pow(10, precision);
		return num;
	}
}
