package funkin.stage;

import funkin.stage.objs.BGSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import funkin.states.PlayState;

/**
	Helper class to build stages with classes
	extend this if you wanna create your own stage
**/
class StageBuilder extends FlxGroup
{
	/**
		Helper variable, references `PlayState`
	**/
	public var game(get, never):PlayState;

	/**
		Whether or not Girlfriend is present in this stage
	**/
	public var showGirlfriend:Bool = true;

	/**
		Layer that goes over dad and bf
	**/
	public var above:FlxTypedGroup<Dynamic>;

	/**
		Layer that goes over everything
	**/
	public var foreground:FlxTypedGroup<Dynamic>;

	/**
		The name of your stage
	**/
	public var name:String = "stage";

	/**
		The name of the current song
	**/
	public var currentSong(get, never):String;

	/**
		the Default Zoom of the Camera for this stage
	**/
	public var cameraZoom:Float = 1.05;

	/**
		What is the initial position for the camera?
	**/
	public var cameraInit(get, default):FlxPoint = null;

	/**
		What is the offset of the Boyfriend Character?
	**/
	public var playerOffset:FlxPoint = FlxPoint.get(770, 450);

	/**
		What is the offset of the Opponent Character?
	**/
	public var opponentOffset:FlxPoint = FlxPoint.get(100, 100);

	/**
		What is the offset of the Spectator Character?
	**/
	public var spectatorOffset:FlxPoint = FlxPoint.get(400, 130);

	public function new(name:String = "stage", zoom:Float = 1.05):Void
	{
		super();

		this.name = name;
		this.cameraZoom = zoom;

		above = new FlxTypedGroup();
		foreground = new FlxTypedGroup();
	}

	/**
		the Current Song Step
	**/
	public var curStep(get, never):Int;

	/**
		the Current Song Beat
	**/
	public var curBeat(get, never):Int;

	/**
		the Total Steps in a Song
	**/
	public var totalSteps(get, never):Int;

	/**
		the Total Beats in a Song
	**/
	public var totalBeats(get, never):Int;

	public function stepHit():Void {}

	public function beatHit():Void {}

	@:noCompletion @:noPrivateAccess
	function get_game():PlayState
		return PlayState.instance;

	@:noCompletion @:noPrivateAccess
	function get_currentSong():String
		return game != null ? PlayState.SONG.song : "test";

	@:noCompletion @:noPrivateAccess
	function get_curStep():Int
		return game != null ? game.curStep : 0;

	@:noCompletion @:noPrivateAccess
	function get_curBeat():Int
		return game != null ? game.curBeat : 0;

	@:noCompletion @:noPrivateAccess
	function get_totalBeats():Int
		return game != null ? game.totalBeats : 0;

	@:noCompletion @:noPrivateAccess
	function get_totalSteps():Int
		return game != null ? game.totalSteps : 0;

	@:noCompletion @:noPrivateAccess
	function get_cameraInit():FlxPoint
	{
		var ret:FlxPoint = cameraInit == null ? FlxPoint.get() : cameraInit;
		if (cameraInit == null && game != null)
		{
			// set default value if PlayState is active, the check itself is made to prevent crashes
			ret = FlxPoint.get(game.dad.getGraphicMidpoint().x, game.dad.getGraphicMidpoint().y - 100);
		}
		return ret;
	}
}
