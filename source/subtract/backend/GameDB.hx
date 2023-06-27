package subtract.backend;

// kinda just here as a placeholder for now
// WIP

import flixel.util.FlxColor;
import flixel.util.typeLimit.OneOfThree;

typedef Color = OneOfThree<FlxColor, String, Array<Int>>;

typedef GameWeek =
{
	var songs:Array<ListSongFormat>;
	var characters:String; // separated by comma
	var difficulties:String; // separated by comma
}

typedef ListSongFormat =
{
	var name:String;
	var char:String;
	var color:Null<Color>;
}

typedef CharacterFormat =
{
	var healthIcon:String;
	var holdsLoopAnim:Bool;
	var idlePlaysAtEnd:Bool;
	var animations:Array<CharacterAnimation>;
	var deathCharacter:String;
	var characterColor:Null<Color>;
}

typedef CharacterAnimation =
{
	var name:String;
	var framerate:Int; // defaults to 24

	@:optional var prefix:String;
	@:optional var indices:Array<Int>;
	@:optional var frames:Array<Int>;
}
