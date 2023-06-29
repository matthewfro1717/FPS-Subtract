package funkin.stage;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxAngle;
import funkin.stage.objs.BGSprite;
import funkin.stage.objs.TankmenUnit;

/**
	Week 7: Ugh, Guns, Stress
**/
class Military extends StageBuilder
{
	var tankmanRun:FlxTypedGroup<TankmenUnit>;
	var tankWatchtower:BGSprite;
	var tankGround:BGSprite;

	var gfCutsceneLayer:FlxGroup;
	var bfTankCutsceneLayer:FlxGroup;

	public function new():Void
	{
		super('tank', 0.90);

		spectatorOffset.y += 10;
		spectatorOffset.x -= 30;
		playerOffset.x += 40;
		playerOffset.y += 0;
		opponentOffset.y += 60;
		opponentOffset.x -= 80;

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

		var smokeLeft:BGSprite = new BGSprite('week7/stage/smokeLeft', -200, -100, 0.4, 0.4, ['SmokeBlurLeft'], true);
		add(smokeLeft);

		var smokeRight:BGSprite = new BGSprite('week7/stage/smokeRight', 1100, -100, 0.4, 0.4, ['SmokeRight'], true);
		add(smokeRight);

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

		// smokeLeft.screenCenter();

		var fgTank0:BGSprite = new BGSprite('week7/stage/tank0', -500, 650, 1.7, 1.5, ['fg']);
		foreground.add(fgTank0);

		var fgTank1:BGSprite = new BGSprite('week7/stage/tank1', -300, 750, 2, 0.2, ['fg']);
		foreground.add(fgTank1);

		// just called 'foreground' just cuz small inconsistency no bbiggei
		var fgTank2:BGSprite = new BGSprite('week7/stage/tank2', 450, 940, 1.5, 1.5, ['foreground']);
		foreground.add(fgTank2);

		var fgTank4:BGSprite = new BGSprite('week7/stage/tank4', 1300, 900, 1.5, 1.5, ['fg']);
		foreground.add(fgTank4);

		var fgTank5:BGSprite = new BGSprite('week7/stage/tank5', 1620, 700, 1.5, 1.5, ['fg']);
		foreground.add(fgTank5);

		var fgTank3:BGSprite = new BGSprite('week7/stage/tank3', 1300, 1200, 3.5, 2.5, ['fg']);
		foreground.add(fgTank3);

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
					// new TankmenUnit(500, 200 + FlxG.random.int(50, 100), TankmenUnit.animationNotes[i][1] < 2);
					tankman.strumTime = TankmenUnit.animationNotes[i][0];
					tankman.resetShit(500, 200 + FlxG.random.int(50, 100), TankmenUnit.animationNotes[i][1] < 2);
					tankmanRun.add(tankman);
				}
			}
		}
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		moveTank();
	}

	public override function beatHit():Void
	{
		foreground.forEach(function(spr:BGSprite) spr.dance());
	}

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

	var tankResetShit:Bool = false;
	var tankMoving:Bool = false;
	var tankAngle:Float = FlxG.random.int(-90, 45);
	var tankSpeed:Float = FlxG.random.float(5, 7);
	var tankX:Float = 400;
}
