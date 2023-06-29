package funkin.stage;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;

/**
	Week 3: Pico, Philly Nice, Blammed
**/
class PhillyCity extends StageBuilder
{
	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	public function new():Void
	{
		super("philly");

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('week3/philly/sky'));
		bg.scrollFactor.set(0.1, 0.1);
		add(bg);

		var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('week3/philly/city'));
		city.scrollFactor.set(0.3, 0.3);
		city.setGraphicSize(Std.int(city.width * 0.85));
		city.updateHitbox();
		add(city);

		phillyCityLights = new FlxTypedGroup<FlxSprite>();
		add(phillyCityLights);

		for (i in 0...5)
		{
			var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('week3/philly/win' + i));
			light.scrollFactor.set(0.3, 0.3);
			light.visible = false;
			light.setGraphicSize(Std.int(light.width * 0.85));
			light.updateHitbox();
			phillyCityLights.add(light);
		}

		var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('week3/philly/behindTrain'));
		add(streetBehind);

		phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('week3/philly/train'));
		add(phillyTrain);

		trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
		FlxG.sound.list.add(trainSound);

		var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('week3/philly/street'));
		add(street);
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (trainMoving)
		{
			trainFrameTiming += elapsed;

			if (trainFrameTiming >= 1 / 24)
			{
				updateTrainPos();
				trainFrameTiming = 0;
			}
		}
		// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
	}

	var curLight:Int = 0;

	public override function beatHit():Void
	{
		if (!trainMoving)
			trainCooldown += 1;

		if (totalBeats % 4 == 0)
		{
			phillyCityLights.forEach(function(light:FlxSprite) light.visible = false);
			curLight = FlxG.random.int(0, phillyCityLights.length - 1);
			phillyCityLights.members[curLight].visible = true;
		}

		if (game.totalBeats % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
		{
			trainCooldown = FlxG.random.int(-4, 0);
			trainStart();
		}
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			game.gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		game.gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}
}
