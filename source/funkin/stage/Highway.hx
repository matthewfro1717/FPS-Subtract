package funkin.stage;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import funkin.stage.objs.BackgroundDancer;

/**
	Week 4: Satin Panties, High, M.I.L.F
**/
class Highway extends StageBuilder
{
	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;

	public function new():Void
	{
		super('limo', 0.90);

		playerOffset.x += 260;
		playerOffset.y -= 220;

		var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image("week4/limo/limoSunset"));
		skyBG.scrollFactor.set(0.1, 0.1);
		add(skyBG);

		var bgLimo:FlxSprite = new FlxSprite(-200, 480);
		bgLimo.frames = Paths.getSparrowAtlas("week4/limo/bgLimo");
		bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
		bgLimo.animation.play('drive');
		bgLimo.scrollFactor.set(0.4, 0.4);
		add(bgLimo);

		grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
		add(grpLimoDancers);

		for (i in 0...5)
		{
			var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
			dancer.scrollFactor.set(0.4, 0.4);
			grpLimoDancers.add(dancer);
		}

		// overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.images("limo/limoOverlay"));
		// overlayShit.alpha = 0.5;
		// add(overlayShit);

		// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

		// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

		// overlayShit.shader = shaderBullshit;

		limo = new FlxSprite(-120, 550);
		limo.frames = Paths.getSparrowAtlas("week4/limo/limoDrive");
		limo.animation.addByPrefix('drive', "Limo stage", 24);
		limo.animation.play('drive');
		limo.antialiasing = true;
		above.add(limo);

		fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image("week4/limo/fastCarLol"));
		resetFastCar();
		foreground.add(fastCar);
	}

	public override function beatHit():Void
	{
		grpLimoDancers.forEach(function(dancer:BackgroundDancer)
		{
			dancer.dance();
		});

		if (FlxG.random.bool(10) && fastCarCanDrive)
			fastCarDrive();
	}

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.sound('carPass' + FlxG.random.int(0, 1)), 0.7);
		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new flixel.util.FlxTimer().start(2, function(tmr) resetFastCar());
	}
}
