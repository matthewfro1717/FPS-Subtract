package funkin.substates;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import funkin.backend.Conductor;
import funkin.objects.Character;
import funkin.states.PlayState;

class GameOverSubState extends funkin.backend.MusicBeat.MusicBeatSubState
{
	var bf:Character;
	var camFollow:FlxObject;

	var stageSuffix:String = '';

	public function new(x:Float, y:Float, camX:Float, camY:Float, character:String)
	{
		var daStage = PlayState.curStage;
		var daBf:String = character;
		switch (daBf)
		{
			case 'bf-pixel-dead':
				stageSuffix = '-pixel';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Character(x, y, daBf, true);
		add(bf);

		camFollow = new FlxObject(camX, camY, 1, 1);
		add(camFollow);
		FlxTween.tween(camFollow, {x: bf.getGraphicMidpoint().x, y: bf.getGraphicMidpoint().y}, 3, {ease: FlxEase.quintOut, startDelay: 0.5});

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.bpm = 100;

		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.camera.follow(camFollow, LOCKON);
		if (controls.ACCEPT && !isEnding)
			endBullshit();

		if (controls.BACK && !isEnding)
		{
			FlxG.sound.music.stop();
			isEnding = true;
			FlxG.sound.play(Paths.sound('cancelMenu'));

			if (PlayState.isStoryMode)
				PlayState.instance.switchState(new funkin.states.menus.StoryMenu());
			else
				PlayState.instance.switchState(new funkin.states.menus.FreeplayMenu());

			FlxG.camera.fade(FlxColor.BLACK, 0.1, false);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			switch (PlayState.SONG.player2)
			{
				case "tankman":
					bf.playAnim('deathLoop');
					FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix), 0.2);
					FlxG.sound.play(Paths.sound('week7/jeffGameover/jeffGameover-' + FlxG.random.int(1, 25)), 1, false, null, true, function()
					{
						if (!isEnding)
							FlxG.sound.music.fadeIn(2.5, 0.2, 1);
					});

				default:
					bf.playAnim('deathLoop');
					FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			}
		}

		if (FlxG.sound.music.playing)
			Conductor.songPosition = FlxG.sound.music.time;
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		isEnding = true;
		bf.playAnim('deathConfirm', true);
		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
		new FlxTimer().start(0.4, function(tmr:FlxTimer)
		{
			FlxG.camera.fade(FlxColor.BLACK, 1.2, false, function()
			{
				PlayState.instance.switchState(new PlayState());
			});
		});
	}
}
