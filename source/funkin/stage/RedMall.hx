package funkin.stage;

import flixel.FlxSprite;

/**
	Week 5: Winter Horrorland
**/
class RedMall extends StageBuilder
{
	public function new():Void
	{
		super('mallEvil');

		playerOffset.x += 320;
		opponentOffset.y -= 80;

		var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image("week5/christmas/evilBG"));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.2, 0.2);
		bg.active = false;
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		bg.updateHitbox();
		add(bg);

		var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('week5/christmas/evilTree'));
		evilTree.antialiasing = true;
		evilTree.scrollFactor.set(0.2, 0.2);
		add(evilTree);

		var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("week5/christmas/evilSnow"));
		evilSnow.antialiasing = true;
		add(evilSnow);
	}
}
