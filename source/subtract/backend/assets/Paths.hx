package subtract.backend.assets;

import flixel.graphics.frames.FlxAtlasFrames;

using haxe.io.Path;

@:keep
class Paths
{
	public static inline function file(key:String, location:String):String
	{
		return 'assets/$location/$key';
	}

	public static inline function xml(key:String, ?location:String = "data"):String
	{
		return file('$key.xml', location);
	}

	public static inline function text(key:String, ?location:String = "data"):String
	{
		return file('$key.txt', location);
	}

	public static inline function json(key:String, ?location:String = "data"):String
	{
		return file('$key.json', location);
	}

	public static inline function image(key:String):Dynamic
	{
		var path:String = file('$key.png', "images");

		if (ImageCache.exists(path))
			return ImageCache.get(path);

		return path;
	}

	public static inline function sound(key:String):String
	{
		return file('$key.ogg', "sounds");
	}

	public static inline function music(key:String):String
	{
		return file('$key.ogg', "music");
	}

	public static inline function voices(key:String):String
	{
		return file('$key/Voices.ogg', "songs");
	}

	public static inline function inst(key:String):String
	{
		return file('$key/Inst.ogg', "songs");
	}

	public static inline function video(key:String):String
	{
		return file('$key.mp4', "videos");
	}

	public static inline function font(key:String):String
	{
		var path:String = file(key, "fonts");

		if (path.extension() == '')
		{
			if (CoolUtil.exists(path + ".ttf"))
				path = path + ".ttf";
			else if (CoolUtil.exists(path + ".otf"))
				path = path + ".otf";
		}

		return path;
	}

	public static inline function getSparrowAtlas(key:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(image(key), xml(key, "images"));
	}

	public static inline function getPackerAtlas(key:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), text(key, "images"));
	}
}
