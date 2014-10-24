package view.screen 
{
	import control.AppControl;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class StartScreen extends EventDispatcher implements IScreen
	{
		
		private var _view:Sprite;
		private var _titleTF:TextField;
		private var _startBtn:Sprite;
		
		public function StartScreen() 
		{
			_view = new Sprite();
		}
		
		public function init():void {
			_titleTF = new TextField;
			var tf:TextFormat = new TextFormat;
			tf.size = 30;
			tf.align = TextFormatAlign.CENTER;
			_titleTF.defaultTextFormat = tf;
			_titleTF.autoSize = TextFieldAutoSize.CENTER;
			_titleTF.multiline = true;
			_titleTF.text = "This is simple flash game SNAKE\n\nuse arrows 'left' and 'right' for turn snake\n\nREADY TO START? press on the red square!";
			_titleTF.x = (AppControl.STAGE_W - _titleTF.textWidth) / 2;
			_titleTF.y = (AppControl.STAGE_H - _titleTF.textHeight) / 2;
			_view.addChild(_titleTF);
			
			_startBtn = new Sprite();
			_startBtn.buttonMode = true;
			_startBtn.graphics.beginFill(0xFF0000);
			_startBtn.graphics.drawRoundRect(0, 0, 100, 40, 10, 10);
			_startBtn.x = (AppControl.STAGE_W - _startBtn.width) / 2;
			_startBtn.y = AppControl.STAGE_H - 2*_startBtn.width
			_view.addChild(_startBtn);
			
			_startBtn.addEventListener(MouseEvent.CLICK, onStartGame);
		}
		
		public function getView():Sprite {
			return _view;
		}
		
		public function destroy():void 
		{
			while (_view.numChildren > 0) {
				_view.removeChildAt(0);
			}
			
			_startBtn.removeEventListener(MouseEvent.CLICK, onStartGame);
		}
		
		private function onStartGame(e:MouseEvent):void 
		{
			super.dispatchEvent(e);
		}
		
	}

}