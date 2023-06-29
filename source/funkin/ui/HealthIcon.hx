package funkin.ui;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var id:Int;

	public var defualtIconScale:Float = 1;
	public var iconScale:Float = 1;
	public var iconSize:Float;
	public var isPlayer:Bool = false;
	public var character:String = "face";

	private var tween:FlxTween;

	private static final pixelIcons:Array<String> = ["bf-pixel", "senpai", "senpai-angry", "spirit", "bf-lil", "guy-lil"];

	public function new(_character:String = 'face', _isPlayer:Bool = false, ?_id:Int = -1)
	{
		super();

		isPlayer = _isPlayer;

		if (CoolUtil.exists(Paths.file("ui/heathIcons/" + _character + ".png", "images")))
		{
			character = _character;
		}
		else
		{
			trace("No icon exists at ui/heathIcons/" + _character + ".png, defaulting to face.");
		}

		setIconCharacter(character);

		iconSize = width;

		id = _id;

		scrollFactor.set();

		tween = FlxTween.tween(this, {}, 0);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		setGraphicSize(Std.int(iconSize * iconScale));
		updateHitbox();

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function tweenToDefaultScale(_time:Float, _ease:Null<flixel.tweens.EaseFunction>)
	{
		tween.cancel();
		tween = FlxTween.tween(this, {iconScale: this.defualtIconScale}, _time, {ease: _ease});
	}

	public function setIconCharacter(character:String)
	{
		loadGraphic(Paths.image("ui/heathIcons/" + character), true, 150, 150);
		animation.add("icon", [for (i in 0...frames.frames.length) i], 0, false, isPlayer);
		animation.play("icon");

		antialiasing = !pixelIcons.contains(character);
	}

	public dynamic function updateFrame(health:Float):Void
	{
		// TODO: make this less stupid @BeastlyGabi
		if (health < 20)
			animation.curAnim.curFrame = 1;
		else if (health > 80)
			animation.curAnim.curFrame = 2;
		else
			animation.curAnim.curFrame = 0;
	}
}
