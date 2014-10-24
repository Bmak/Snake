package view.screen 
{
	import control.AppControl;
	import event.GameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import view.game.World;
	
	public class GameScreen extends Sprite implements IScreen
	{
		
		private var _view:Sprite;
		
		private var _world:World;
		
		private var _oldTime:int;
		private var _delta:int;
		
		private var _result:Sprite;
		private var _resultTF:TextField;
		
		public function GameScreen() 
		{
			_view = new Sprite;
		}
		
		public function init():void {
			_world = new World;
			_view.addChild(_world);
			
			_delta = 0;
			_oldTime = getTimer();
			
			_view.stage.focus = _view;
			
			addListeners();
		}
		
		public function getView():Sprite {
			return _view;
		}
		
		private function addListeners():void {
			_world.addEventListener(GameEvent.GAME_OVER, onGameOver);
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			_view.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onGameOver(e:GameEvent):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, onUpdate);
			
			if (!_result) {
				_result = new Sprite;
				_result.graphics.beginFill(0xC0C0C0, 0.7);
				_result.graphics.drawRoundRect(0, 0, 400, 300, 10, 10);
				_result.x = (AppControl.STAGE_W - _result.width) / 2;
				_result.y = (AppControl.STAGE_H - _result.height) / 2;
			}
			_view.addChild(_result);
			
			if (!_resultTF) {
				_resultTF = new TextField;
				var tf:TextFormat = new TextFormat;
				tf.align = TextFormatAlign.CENTER;
				tf.size = 30;
				_resultTF.defaultTextFormat = tf;
				_resultTF.autoSize = TextFieldAutoSize.CENTER;
				_resultTF.multiline = true;
			}
			_resultTF.text = "GAME OVER\n\n" + "score: " + _world.score + "\n\npress 'space' to restart game";
			_resultTF.x = (_result.width - _resultTF.textWidth) / 2;
			_resultTF.y = (_result.height - _resultTF.textHeight) / 2;
			
			_result.addChild(_resultTF);
		}
		
		private function onUpdate(e:Event):void {
			_delta = getTimer() - _oldTime;
			_oldTime = getTimer();
			
			_world.update(_delta);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT) {
				_world.snake.turnLeft();
			} else if (e.keyCode == Keyboard.RIGHT) {
				_world.snake.turnRight();
			}
			
			if (_world.gameOver && e.keyCode == Keyboard.SPACE) {
				if (_result) {
					_result.removeChild(_resultTF);
					_view.removeChild(_result);
				}
				_world.initGame();
				this.addEventListener(Event.ENTER_FRAME, onUpdate);
			}
		}
		
		public function destroy():void 
		{
			//TODO update this if need to close game screen
		}
		
	}

}