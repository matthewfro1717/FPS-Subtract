package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxGraphicAsset;

using StringTools;

class Paths
{
	inline static public function file(key:String, location:String):String
	{
		return 'assets/$location/$key';
	}

	inline static public function xml(key:String, ?location:String = "data"):String
	{
		return file('$key.xml', location);
	}

	inline static public function text(key:String, ?location:String = "data"):String
	{
		return file('$key.txt', location);
	}

	inline static public function json(key:String, ?location:String = "data"):String
	{
		return file('$key.json', location);
	}

	inline static public function image(key:String):Dynamic
	{
		var path:String = file('$key.png', "images");

		if (ImageCache.exists(path))
			return ImageCache.get(path);

		return path;
	}

	inline static public function sound(key:String):String
	{
		return file('$key.ogg', "sounds");
	}

	inline static public function music(key:String):String
	{
		return file('$key.ogg', "music");
	}

	inline static public function voices(key:String):String
	{
		return file('$key/Voices.ogg', "songs");
	}

	inline static public function inst(key:String):String
	{
		return file('$key/Inst.ogg', "songs");
	}

	inline static public function video(key:String):String
	{
		return file('$key.mp4', "videos");
	}

	inline static public function font(key:String):String
	{
		var hasDot:Bool = key.charCodeAt(key.lastIndexOf(".")) != null;
		var realKey:String = file(key, "fonts");
		if (!hasDot)
		{
			if (CoolUtil.exists(realKey + ".ttf"))
				realKey = realKey + ".ttf";
			else if (CoolUtil.exists(realKey + ".otf"))
				realKey = realKey + ".otf";
		}
		return realKey;
	}

	inline static public function getSparrowAtlas(key:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(image(key), xml(key, "images"));
	}

	inline static public function getPackerAtlas(key:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), text(key, "images"));
	}
}
