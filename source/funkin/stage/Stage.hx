package funkin.stage;

import flixel.FlxSprite;
import funkin.stage.StageBuilder;

/**
	Week 1: Tutorial, Bopeebo, Fresh, Dadbattle
**/
class Stage extends StageBuilder
{
	public function new():Void
	{
		super("stage", 0.0);

		var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image("week1/stageback"));
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image("week1/stagefront"));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		add(stageFront);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image("week1/stagecurtains"));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;
		add(stageCurtains);
	}
}
