package;

import haxe.Json;
import openfl.utils.Assets;

using StringTools;

typedef SwagSection =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var mustHitSection:Bool;
	var bpm:Float;
	var changeBPM:Bool;
	var altAnim:Bool;
}

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var stage:String;
	var gf:String;
	var validScore:Bool;
}

typedef SwagEvents =
{
	var events:Array<Dynamic>;
}

class Song
{
	public static function loadJson(jsonInput:String, ?folder:String):SwagSong
	{
		return parseSong(CoolUtil.getText(Paths.json(folder + '/' + jsonInput).toLowerCase()).trim());
	}

	public static function parseSong(rawJson:String):SwagSong
	{
		return cast(Json.parse(rawJson).song, SwagSong);
	}

	public static function parseEvents(rawJson:String):SwagEvents
	{
		return cast(Json.parse(rawJson).events, SwagEvents);
	}
}
