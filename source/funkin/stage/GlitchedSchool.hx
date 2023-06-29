package funkin.stage;

import flixel.FlxSprite;
import subtract.ui.DeltaTrail;

/**
	Week 6: Thorns
**/
class GlitchedSchool extends StageBuilder
{
	public function new():Void
	{
		super('schoolEvil');

		playerOffset.x += 200;
		playerOffset.y += 220;
		spectatorOffset.x += 180;
		spectatorOffset.y += 300;

		var bg:FlxSprite = new FlxSprite(400, 200);
		bg.frames = Paths.getSparrowAtlas("week6/weeb/animatedEvilSchool");
		bg.animation.addByPrefix('idle', 'background 2', 24);
		bg.animation.play('idle');
		bg.scrollFactor.set(0.8, 0.9);
		bg.scale.set(6, 6);
		add(bg);

		var evilTrail = new DeltaTrail(game.dad, null, 10, 3 / 60, 0.4);
		// var evilTrail = new DeltaTrail(game.dad, null, 10, 24 / 60, 0.4, 0.005); //This is basically the default look of Spirit in base game.
		add(evilTrail);
	}
}
