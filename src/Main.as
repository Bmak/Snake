package 
{
	import control.AppControl;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * Main
	 * @author ProBigi
	 */
	public class Main extends Sprite 
	{
		
		private var _appControl:AppControl;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_appControl = new AppControl(this);
		}
		
	}
	
}