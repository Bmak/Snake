package view.game 
{
	import flash.display.Sprite;
	
	public class SnakePart extends Sprite
	{
		
		private var _posX:int;
		private var _posY:int;
		private var _view:Sprite;
		private var _type:int;
		
		public function SnakePart(type:int) 
		{
			_type = type;
			if (_type == 0) {
				_view = new SnakeHead();
			} else {
				_view = new SnakePartView();
			}
			
			this.addChild(_view);
		}
		
		public function get posX():int {
			return _posX;
		}
		public function set posX(value:int):void {
			_posX = value;
			this.x = _posX * World.CELL_SIZE + World.CELL_SIZE / 2;
			
		}
		
		public function get posY():int {
			return _posY;
		}
		public function set posY(value:int):void {
			_posY = value;
			this.y = _posY * World.CELL_SIZE + World.CELL_SIZE / 2;
		}
	}

}