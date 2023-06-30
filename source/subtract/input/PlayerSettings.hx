package subtract.input;

import flixel.FlxG;
import flixel.util.FlxSignal;
import subtract.input.Controls;

class PlayerSettings
{
	public static var numPlayers(default, null) = 0;
	public static var numAvatars(default, null) = 0;
	public static var player1(default, null):PlayerSettings;
	public static var player2(default, null):PlayerSettings;

	public static final onAvatarAdd = new FlxTypedSignal<PlayerSettings->Void>();
	public static final onAvatarRemove = new FlxTypedSignal<PlayerSettings->Void>();

	public var id(default, null):Int;

	public final controls:Controls;

	public function new(id, scheme)
	{
		this.id = id;
		this.controls = new Controls('player$id', scheme);
	}

	public function setKeyboardScheme(scheme)
	{
		controls.setKeyboardScheme(scheme);
	}

	public static function init():Void
	{
		if (player1 == null)
		{
			player1 = new PlayerSettings(0, Solo);
			++numPlayers;
		}

		var numGamepads = FlxG.gamepads.numActiveGamepads;
		if (numGamepads > 0)
		{
			var gamepad = FlxG.gamepads.getByID(0);
			if (gamepad == null)
				throw 'Unexpected null gamepad. id:0';

			player1.controls.addDefaultGamepad(0);
		}

		menuControls();
	}

	public static function menuControls()
	{
		var numGamepads = FlxG.gamepads.numActiveGamepads;
		if (numGamepads > 0)
		{
			var gamepad = FlxG.gamepads.getByID(0);
			if (gamepad == null)
				throw 'Unexpected null gamepad. id:0';

			player1.controls.setMenuControls(0);
		}
	}

	public static function gameControls()
	{
		var numGamepads = FlxG.gamepads.numActiveGamepads;
		if (numGamepads > 0)
		{
			var gamepad = FlxG.gamepads.getByID(0);
			if (gamepad == null)
				throw 'Unexpected null gamepad. id:0';

			player1.controls.setGameControls(0);
		}
	}

	public static function reset()
	{
		player1 = null;
		player2 = null;
		numPlayers = 0;
	}
}
