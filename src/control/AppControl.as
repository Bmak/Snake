package control 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import view.screen.GameScreen;
	import view.screen.IScreen;
	import view.screen.StartScreen;
	/**
	 * Main App Control
	 * @author ProBigi
	 */
	public class AppControl 
	{
		public static var STAGE_W:int;
		public static var STAGE_H:int;
		
		private var _mainView:Sprite;
		
		public function AppControl(view:Sprite) 
		{
			_mainView = view;
			STAGE_W = view.stage.stageWidth;
			STAGE_H = view.stage.stageHeight;
			
			
			var startScr:IScreen = new StartScreen();
			startScr.addEventListener(MouseEvent.CLICK, onStartGame);
			
			setScreen(startScr);
		}
		
		private function onStartGame(e:MouseEvent):void 
		{
			setScreen(new GameScreen());
		}
		
		private function setScreen(screen:IScreen):void {
			while (_mainView.numChildren > 0) {
				_mainView.removeChildAt(0);
			}
			_mainView.addChild(screen.getView());
			screen.init();
		}
		
	}

}