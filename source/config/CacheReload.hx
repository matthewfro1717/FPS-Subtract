package config;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.utils.Assets;
import subtract.backend.assets.ImageCache;

using StringTools;

class CacheReload extends flixel.FlxState
{
    public static var doMusic = true;
    public static var doGraphics = true;

    var nextState:flixel.FlxState = new ConfigMenu();

    var splash:FlxSprite;
    var loadingText:FlxText;

    var songsCached:Bool;
                                
    var charactersCached:Bool;
    var startCachingCharacters:Bool = false;
    var charI:Int = 0;

    var graphicsCached:Bool;
    var startCachingGraphics:Bool = false;
    var gfxI:Int = 0;

    var cacheStart:Bool = false;

	override function create()
	{
        songsCached = !FlxG.save.data.musicPreload2;
        charactersCached = !FlxG.save.data.charPreload2;
        graphicsCached = !FlxG.save.data.graphicsPreload2;

        if (doGraphics)
            ImageCache.cache.clear();
        else {
            charactersCached = true;
            graphicsCached = true;
        }

        if (doMusic)
            Assets.cache.clear("music");
        else
            songsCached = true;

        var text = new FlxText(0, 0, 1280, "LOADING ASSETS...", 64);
	    text.scrollFactor.set(0, 0);
	    text.setFormat(Paths.font("vcr"), 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.borderSize = 3;
	    text.borderQuality = 1;
        text.screenCenter(XY);
        add(text);

        preload();
        cacheStart = true;

        super.create();
    }

    override function update(elapsed) 
    {
        if (songsCached && charactersCached && graphicsCached)
            FlxG.switchState(nextState);

        if (startCachingCharacters)
        {
            if (charI >= Startup.characters.length)
            {
                startCachingCharacters = false;
                charactersCached = true;
            }
            else
            {
                ImageCache.add(Paths.file(Startup.characters[charI] + ".png", "images"));
                charI++;
            }
        }

        if (startCachingGraphics)
        {
            if (gfxI >= Startup.graphics.length)
            {
                startCachingGraphics = false;
                graphicsCached = true;
            }
            else
            {
                ImageCache.add(Paths.file(Startup.graphics[gfxI] + ".png", "images"));
                gfxI++;
            }
        }
        
        super.update(elapsed);

    }

    function preload()
    {
        if (!songsCached){ 
            #if sys
            sys.thread.Thread.create(preloadMusic);
            #else
            preloadMusic();
            #end
        }

        if (!charactersCached) startCachingCharacters = true;
        if (!graphicsCached) startCachingGraphics = true;
    }

    function preloadMusic(){
        for (x in Startup.songs)
        {
            if (CoolUtil.exists(Paths.inst(x)))
                FlxG.sound.cache(Paths.inst(x));
            else
                FlxG.sound.cache(Paths.music(x));
        }

        songsCached = true;
    }
}
