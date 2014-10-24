package view.game {
	import flash.display.Sprite;
	
	public class Snake
	{
		public static const UP:int = 0;
		public static const LEFT:int = 1;
		public static const DOWN:int = 2;
		public static const RIGHT:int = 3;
		
		private const START_PARTS:int = 3;
		
		private var _container:Sprite;
		private var _parts:Vector.<SnakePart>;
		private var _head:SnakePart;
		private var _direction:int;
		
		public function Snake(cont:Sprite,startX:int,startY:int) 
		{
			_container = cont;
			_direction = UP;
			_parts = new Vector.<SnakePart>;
			
			var part:SnakePart;
			var i:int = START_PARTS-1;
			while (i >= 0) {
				part = new SnakePart(i);
				part.posX = startX;
				part.posY = startY + i;
				_container.addChild(part);
				_parts.unshift(part);
				i--;
			}
			_head = _parts[0];
		}
		
		public function get parts():Vector.<SnakePart> {
			return _parts;
		}
		
		public function destroy():void {
			for each(var part:SnakePart in _parts) {
				if (_container.contains(part)) { _container.removeChild(part); }
			}
			_parts.length = 0;
			_head = null;
		}
		
		public function turnLeft():void {
			_direction += 1;
			if (_direction > RIGHT) {
				_direction = UP;
			}
			updateHead();
		}
		
		public function turnRight():void {
			_direction -= 1;
			if (_direction < UP) {
				_direction = RIGHT;
			}
			updateHead();
		}
		
		public function eat():void {
			var end:SnakePart = _parts[_parts.length - 1];
			var endPart:SnakePart = new SnakePart(1);
			endPart.posX = end.posX;
			endPart.posY = end.posY;
			_container.addChild(endPart);
			_parts.push(endPart)
		}
		
		public function move():void {
			var len:int = _parts.length-1;
			for (var i:int = len; i > 0; i--) {
				var before:SnakePart = _parts[i - 1];
				var part:SnakePart = _parts[i];
				part.posX = before.posX;
				part.posY = before.posY;
			}
			
			switch(_direction) {
				case UP:
					_head.posY -= 1;
					break;
				case LEFT:
					_head.posX -= 1;
					break;
				case DOWN:
					_head.posY += 1;
					break;
				case RIGHT:
					_head.posX += 1;
					break;
			}
		}
		
		public function checkBitten():Boolean {
			var len:int = _parts.length;
			var part:SnakePart;
			for (var i:int = 1; i < len; i++) {
				part = _parts[i];
				if (part.posX == _head.posX && part.posY == _head.posY) {
					return true;
				}
			}
			return false;
		}
		
		private function updateHead():void {
			switch(_direction) {
				case UP:
					_head.rotation = 0;
					break;
				case LEFT:
					_head.rotation = -90;
					break;
				case DOWN:
					_head.rotation = -180;
					break;
				case RIGHT:
					_head.rotation = -270;
					break;
			}
		}
	}

}