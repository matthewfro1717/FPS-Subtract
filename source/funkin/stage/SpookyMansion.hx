package funkin.stage;

import flixel.FlxG;
import flixel.FlxSprite;

/**
	Week 2: Spookeez, South, Monster
**/
class SpookyMansion extends StageBuilder
{
	public var halloweenBG:FlxSprite;

	public function new():Void
	{
		super("spooky");

		halloweenBG = new FlxSprite(-200, -100);
		halloweenBG.frames = Paths.getSparrowAtlas("week2/halloween_bg");
		halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
		halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
		halloweenBG.animation.play('idle');
		halloweenBG.antialiasing = true;
		add(halloweenBG);
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	public override function beatHit():Void
	{
		if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.sound('thunder_' + FlxG.random.int(1, 2)));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);
		game.boyfriend.playAnim('scared', true);
		game.gf.playAnim('scared', true);
	}
}
