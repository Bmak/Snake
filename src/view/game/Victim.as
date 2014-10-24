package view.game 
{
	import flash.display.Sprite;
	
	public class Victim extends Sprite
	{
		private var _posX:int;
		private var _posY:int;
		private var _view:Sprite;
		private var _type:int;
		private var _points:int;
		
		public function Victim(type:int) 
		{
			_type = type;
			switch(type) {
				case 0:
					_view = new Victim1();
					_points = 10;
					break;
				case 1:
					_view = new Victim2();
					_points = 25;
					break;
				case 2:
					_view = new Victim3();
					_points = 50;
					break;
				default:
					_view = new Victim1();
					_points = 10;
					break;
			}
			
			this.addChild(_view);
		}
		
		public function get points():int {
			return _points;
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