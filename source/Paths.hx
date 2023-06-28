package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Paths
{
	inline static public function file(key:String, location:String, extension:String):String
	{
		return 'assets/$location/$key.$extension';
	}

	inline static public function xml(key:String, ?location:String = "data"):String
	{
		return file(key, location, "xml");
	}

	inline static public function text(key:String, ?location:String = "data"):String
	{
		return file(key, location, "txt");
	}

	inline static public function json(key:String, ?location:String = "data"):String
	{
		return file(key, location, "json");
	}

	inline static public function image(key:String):FlxGraphicAsset
	{
		var path:String = file(key, "images", "png");

		if (ImageCache.exists(path))
			return ImageCache.get(path);

		return path;
	}

	inline static public function sound(key:String):String
	{
		return file(key, "sounds", "ogg");
	}

	inline static public function music(key:String):String
	{
		return file(key, "music", "ogg");
	}

	inline static public function voices(key:String):String
	{
		return file('$key/Voices', "songs", "ogg");
	}

	inline static public function inst(key:String):String
	{
		return file('$key/Inst', "songs", "ogg");
	}

	inline static public function video(key:String):String
	{
		return file(key, "videos", "mp4");
	}

	inline static public function font(key:String, ?extension:String = "ttf"):String
	{
		return file(key, "fonts", extension);
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
