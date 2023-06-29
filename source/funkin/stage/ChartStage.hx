package funkin.stage;

import flixel.FlxG;
import flixel.FlxSprite;
import funkin.states.PlayState;
import funkin.states.debug.ChartingState;

/**
	???: Lil Buddies
**/
class ChartStage extends StageBuilder
{
	var chartBlackBG:FlxSprite;

	public function new():Void
	{
		super('chart', PlayState.fromChartEditor ? 1 : 2.8);

		if (PlayState.fromChartEditor)
		{
			var chartBg = new FlxSprite().loadGraphic(ChartingState.screenshotBitmap.bitmapData);
			chartBg.antialiasing = true;
			add(chartBg);

			chartBlackBG = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
			chartBlackBG.alpha = 0;
			add(chartBlackBG);
		}

		var blackBGThing = new FlxSprite(32, 432).makeGraphic(280, 256, 0xFF000000);
		add(blackBGThing);

		var lilStage = new FlxSprite(32, 432).loadGraphic(Paths.image("chartEditor/lilStage"));
		add(lilStage);

		showGirlfriend = false;
		playerOffset.set(32, 432);
		opponentOffset.set(32, 432);

		@:privateAccess
		game.autoCam = false;

		if (PlayState.fromChartEditor)
			cameraInit.set(FlxG.width, FlxG.height + 350);
		else
			cameraInit.set(155, -600);
	}
}
