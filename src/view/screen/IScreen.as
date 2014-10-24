package view.screen 
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	public interface IScreen extends IEventDispatcher
	{
		function init():void;
		function getView():Sprite;
		function destroy():void;
	}
	
}