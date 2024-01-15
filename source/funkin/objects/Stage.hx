package funkin.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import funkin.objects.background.*;
import funkin.states.PlayState;
import funkin.states.debug.ChartingState;
import subtract.ui.DeltaTrail;

/**
	Helper class to build stages
	currently very crowded but works
**/
class Stage extends FlxGroup
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

	// <----------- STAGE OBJECTS ----------->
	// WEEK 2
	var halloweenBG:FlxSprite;

	// WEEK 3
	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	// WEEK 4
	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;

	// WEEK 5
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	// WEEK 6
	var bgGirls:BackgroundGirls;

	// WEEK 7
	var tankmanRun:FlxTypedGroup<TankmenUnit>;
	var tankWatchtower:BGSprite;
	var tankGround:BGSprite;

	// OTHER
	var chartBlackBG:FlxSprite;

	public function new(name:String = 'stage'):Void
	{
		super();

		this.name = name;

		above = new FlxTypedGroup();
		foreground = new FlxTypedGroup();

		switch (name)
		{
			case 'stage': // Week 1: Tutorial, Bopeebo, Fresh, Dadbattle
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

			case "spooky": // Week 2: Spookeez, South, Monster
				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = Paths.getSparrowAtlas("week2/halloween_bg");
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);

			case "philly": // Week 3: Pico, Philly Nice, Blammed
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

			case "limo": // Week 4: Satin Panties, High, M.I.L.F
				playerOffset.x += 260;
				playerOffset.y -= 220;

				cameraZoom = 0.90;

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

				limo = new FlxSprite(-120, 550);
				limo.frames = Paths.getSparrowAtlas("week4/limo/limoDrive");
				limo.animation.addByPrefix('drive', "Limo stage", 24);
				limo.animation.play('drive');
				limo.antialiasing = true;
				above.add(limo);

				fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image("week4/limo/fastCarLol"));
				resetFastCar();
				foreground.add(fastCar);

			case "mall": // Week 5: Cocoa, Eggnog
				playerOffset.x += 200;

				cameraZoom = 0.80;

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

			case "mallEvil": // Week 5: Winter Horrorland
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

			case "school": // Week 6: Senpai, Roses
				playerOffset.x += 200;
				playerOffset.y += 220;
				spectatorOffset.x += 180;
				spectatorOffset.y += 300;

				var bgSky = new FlxSprite().loadGraphic(Paths.image('week6/weeb/weebSky'));
				bgSky.scrollFactor.set(0.1, 0.1);
				add(bgSky);

				var bgSchool:FlxSprite = new FlxSprite(-200, 0).loadGraphic(Paths.image('week6/weeb/weebSchool'));
				bgSchool.scrollFactor.set(0.6, 0.90);
				add(bgSchool);

				var bgStreet:FlxSprite = new FlxSprite(-200).loadGraphic(Paths.image('week6/weeb/weebStreet'));
				bgStreet.scrollFactor.set(0.95, 0.95);
				add(bgStreet);

				var fgTrees:FlxSprite = new FlxSprite(-30, 130).loadGraphic(Paths.image('week6/weeb/weebTreesBack'));
				fgTrees.scrollFactor.set(0.9, 0.9);
				add(fgTrees);

				var bgTrees:FlxSprite = new FlxSprite(-580, -800);
				bgTrees.frames = Paths.getPackerAtlas("week6/weeb/weebTrees");
				bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
				bgTrees.animation.play('treeLoop');
				bgTrees.scrollFactor.set(0.85, 0.85);
				add(bgTrees);

				var treeLeaves:FlxSprite = new FlxSprite(-200, -40);
				treeLeaves.frames = Paths.getSparrowAtlas("week6/weeb/petals");
				treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
				treeLeaves.animation.play('leaves');
				treeLeaves.scrollFactor.set(0.85, 0.85);
				add(treeLeaves);

				var widShit = Std.int(bgSky.width * 6);

				bgSky.setGraphicSize(widShit);
				bgSchool.setGraphicSize(widShit);
				bgStreet.setGraphicSize(widShit);
				bgTrees.setGraphicSize(Std.int(widShit * 1.4));
				fgTrees.setGraphicSize(Std.int(widShit * 0.8));
				treeLeaves.setGraphicSize(widShit);

				fgTrees.updateHitbox();
				bgSky.updateHitbox();
				bgSchool.updateHitbox();
				bgStreet.updateHitbox();
				bgTrees.updateHitbox();
				treeLeaves.updateHitbox();

				bgGirls = new BackgroundGirls(-100, 190);
				bgGirls.scrollFactor.set(0.9, 0.9);

				if (currentSong.toLowerCase() == "roses")
					bgGirls.getScared();

				bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
				bgGirls.updateHitbox();
				add(bgGirls);

			case "schoolEvil": // Week 6: Thorns
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

				add(new DeltaTrail(game.dad, null, 10, 3 / 60, 0.4));

			case "tank":
				spectatorOffset.y += 10;
				spectatorOffset.x -= 30;
				playerOffset.x += 40;
				playerOffset.y += 0;
				opponentOffset.y += 60;
				opponentOffset.x -= 80;

				cameraZoom = 0.90;

				if (game.gf.curCharacter != 'pico-speaker')
				{
					spectatorOffset.x -= 170;
					spectatorOffset.y -= 75;
				}
				else
				{
					spectatorOffset.x -= 50;
					spectatorOffset.y -= 200;
				}

				var bg:BGSprite = new BGSprite('week7/stage/tankSky', -400, -400, 0, 0);
				add(bg);

				var tankSky:BGSprite = new BGSprite('week7/stage/tankClouds', FlxG.random.int(-700, -100), FlxG.random.int(-20, 20), 0.1, 0.1);
				tankSky.active = true;
				tankSky.velocity.x = FlxG.random.float(5, 15);
				add(tankSky);

				var tankMountains:BGSprite = new BGSprite('week7/stage/tankMountains', -300, -20, 0.2, 0.2);
				tankMountains.setGraphicSize(Std.int(tankMountains.width * 1.2));
				tankMountains.updateHitbox();
				add(tankMountains);

				var tankBuildings:BGSprite = new BGSprite('week7/stage/tankBuildings', -200, 0, 0.30, 0.30);
				tankBuildings.setGraphicSize(Std.int(tankBuildings.width * 1.1));
				tankBuildings.updateHitbox();
				add(tankBuildings);

				var tankRuins:BGSprite = new BGSprite('week7/stage/tankRuins', -200, 0, 0.35, 0.35);
				tankRuins.setGraphicSize(Std.int(tankRuins.width * 1.1));
				tankRuins.updateHitbox();
				add(tankRuins);

				add(new BGSprite('week7/stage/smokeLeft', -200, -100, 0.4, 0.4, ['SmokeBlurLeft'], true));
				add(new BGSprite('week7/stage/smokeRight', 1100, -100, 0.4, 0.4, ['SmokeRight'], true));

				// tankGround.

				tankWatchtower = new BGSprite('week7/stage/tankWatchtower', 100, 50, 0.5, 0.5, ['watchtower gradient color']);
				add(tankWatchtower);

				tankGround = new BGSprite('week7/stage/tankRolling', 300, 300, 0.5, 0.5, ['BG tank w lighting'], true);
				add(tankGround);
				// tankGround.active = false;

				tankmanRun = new FlxTypedGroup<TankmenUnit>();
				add(tankmanRun);

				var tankGround:BGSprite = new BGSprite('week7/stage/tankGround', -420, -150);
				tankGround.setGraphicSize(Std.int(tankGround.width * 1.15));
				tankGround.updateHitbox();
				add(tankGround);

				moveTank();

				foreground.add(new BGSprite('week7/stage/tank0', -500, 650, 1.7, 1.5, ['fg']));
				foreground.add(new BGSprite('week7/stage/tank1', -300, 750, 2, 0.2, ['fg']));
				foreground.add(new BGSprite('week7/stage/tank2', 450, 940, 1.5, 1.5, ['foreground']));
				foreground.add(new BGSprite('week7/stage/tank4', 1300, 900, 1.5, 1.5, ['fg']));
				foreground.add(new BGSprite('week7/stage/tank5', 1620, 700, 1.5, 1.5, ['fg']));
				foreground.add(new BGSprite('week7/stage/tank3', 1300, 1200, 3.5, 2.5, ['fg']));

				if (game.gf.curCharacter == "pico-speaker" && currentSong.toLowerCase() == "stress")
				{
					TankmenUnit.loadMappedAnims("picospeaker", "stress");

					var tempTankman:TankmenUnit = new TankmenUnit(20, 500, true);
					tempTankman.strumTime = 10;
					tempTankman.resetShit(20, 600, true);
					tankmanRun.add(tempTankman);

					for (i in 0...TankmenUnit.animationNotes.length)
					{
						if (FlxG.random.bool(16))
						{
							var tankman:TankmenUnit = tankmanRun.recycle(TankmenUnit);
							tankman.strumTime = TankmenUnit.animationNotes[i][0];
							tankman.resetShit(500, 200 + FlxG.random.int(50, 100), TankmenUnit.animationNotes[i][1] < 2);
							tankmanRun.add(tankman);
						}
					}
				}

                        case 'minecraft':

			cameraZoom = 0.9;
			curStage = 'minecraft';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("flatland"));
			// bg.setGraphicSize(Std.int(bg.width * 2.5));
			// bg.updateHitbox();
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			bg.screenCenter(XY);
			add(bg);

                        case 'checker':

			cameraZoom = 0.66;
			curStage = 'checker';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("redfloor"));
			// bg.setGraphicSize(Std.int(bg.width * 2.5));
			// bg.updateHitbox();
			bg.antialiasing = true;
			// bg.scrollFactor.set(0.66, 0.66);
			bg.active = false;
			bg.screenCenter(XY);
			add(bg);

                        case 'crashStage':

			cameraZoom = 0.8;
			curStage = 'crashStage';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("rockslide"));
			bg.antialiasing = true;
			bg.active = false;
			bg.screenCenter(XY);
			add(bg);

                        case 'fnafStage':

			cameraZoom = 0.85;
			curStage = 'fnafStage';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("bedroom"));
			bg.antialiasing = true;
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.9));
			bg.updateHitbox();
			bg.screenCenter(XY);
			add(bg);

                        case 'skeletonStage':
				
			cameraZoom = 0.8;
			curStage = 'skeletonStage';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("darkness"));
			bg.antialiasing = true;
			bg.active = false;
			bg.screenCenter(XY);
			add(bg);
                        
			case 'minecraft':
				
			cameraZoom = 0.8;
			curStage = 'skeletonStage';
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("darkness"));
			bg.antialiasing = true;
			bg.active = false;
			bg.screenCenter(XY);
			add(bg);

			case "chart":
				if (PlayState.fromChartEditor)
				{
					var chartBg = new FlxSprite().loadGraphic(ChartingState.screenshotBitmap.bitmapData);
					chartBg.antialiasing = true;
					add(chartBg);

					chartBlackBG = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
					chartBlackBG.alpha = 0;
					add(chartBlackBG);
				}

				add(new FlxSprite(32, 432).makeGraphic(280, 256, 0xFF000000));
				add(new FlxSprite(32, 432).loadGraphic(Paths.image("chartEditor/lilStage")));

				showGirlfriend = false;
				playerOffset.set(32, 432);
				opponentOffset.set(32, 432);

				@:privateAccess
				game.autoCam = false;

				if (PlayState.fromChartEditor)
					cameraInit.set(FlxG.width, FlxG.height + 350);
				else
					cameraInit.set(155, -600);

			default:
				// load a file and then create objects with it.
		}
	}

	public override function update(elapsed:Float):Void
	{
		switch (name)
		{
			case "philly":
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
			case "tank":
				moveTank();
		}
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

	public function beatHit():Void
	{
		switch (name)
		{
			case "spooky":
				if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
					lightningStrikeShit();

			case "philly":
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

			case "limo":
				grpLimoDancers.forEach(function(dancer:BackgroundDancer) dancer.dance());
				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();

			case "mall":
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);

			case "school":
				bgGirls.dance();

			case "tank":
				foreground.forEach(function(spr:BGSprite) spr.dance());
		}
	}

	// WEEK 2 VARIABLES
	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.sound('thunder_' + FlxG.random.int(1, 2)));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);
		game.boyfriend.playAnim('scared', true);
		game.gf.playAnim('scared', true);
	}

	// PHILLY STUFF
	var curLight:Int = 0;
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

	// MOMMY STUFF
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

	// TANKMAN STUFF
	var tankResetShit:Bool = false;
	var tankMoving:Bool = false;
	var tankAngle:Float = FlxG.random.int(-90, 45);
	var tankSpeed:Float = FlxG.random.float(5, 7);
	var tankX:Float = 400;

	function moveTank():Void
	{
		@:privateAccess
		if (game.inCutscene)
			return;

		var daAngleOffset:Float = 1;
		tankAngle += FlxG.elapsed * tankSpeed;
		tankGround.angle = tankAngle - 90 + 15;

		tankGround.x = tankX + Math.cos(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1500;
		tankGround.y = 1300 + Math.sin(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1100;
	}

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
