package funkin.stage;

import flixel.FlxSprite;

/**
	Week 5: Cocoa, Eggnog
**/
class ChristmasMall extends StageBuilder
{
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	public function new():Void
	{
		super('mall', 0.80);

		playerOffset.x += 200;

		var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('week5/christmas/bgWalls'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.2, 0.2);
		bg.active = false;
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		bg.updateHitbox();
		add(bg);

		upperBoppers = new FlxSprite(-240, -90);
		upperBoppers.frames = Paths.getSparrowAtlas("week5/christmas/upperBop");
		upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
		upperBoppers.antialiasing = true;
		upperBoppers.scrollFactor.set(0.33, 0.33);
		upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
		upperBoppers.updateHitbox();
		add(upperBoppers);

		var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image("week5/christmas/bgEscalator"));
		bgEscalator.antialiasing = true;
		bgEscalator.scrollFactor.set(0.3, 0.3);
		bgEscalator.active = false;
		bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
		bgEscalator.updateHitbox();
		add(bgEscalator);

		var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image("week5/christmas/christmasTree"));
		tree.antialiasing = true;
		tree.scrollFactor.set(0.40, 0.40);
		add(tree);

		bottomBoppers = new FlxSprite(-300, 140);
		bottomBoppers.frames = Paths.getSparrowAtlas("week5/christmas/bottomBop");
		bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		bottomBoppers.antialiasing = true;
		bottomBoppers.scrollFactor.set(0.9, 0.9);
		bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
		bottomBoppers.updateHitbox();
		add(bottomBoppers);

		var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image("week5/christmas/fgSnow"));
		fgSnow.active = false;
		fgSnow.antialiasing = true;
		add(fgSnow);

		santa = new FlxSprite(-840, 150);
		santa.frames = Paths.getSparrowAtlas("week5/christmas/santa");
		santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
		santa.antialiasing = true;
		add(santa);
	}

	public override function beatHit():Void
	{
		upperBoppers.animation.play('bop', true);
		bottomBoppers.animation.play('bop', true);
		santa.animation.play('idle', true);
	}
}
