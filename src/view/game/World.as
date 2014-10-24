package view.game 
{
	import control.AppControl;
	import event.GameEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class World extends Sprite
	{
		//Game Settings
		public static const WORLD_WIDTH:int = 15;
		public static const WORLD_HEIGHT:int = 10;
		public static const CELL_SIZE:int = 50;
		public static const TICK_DECREMENT:int = 50;
		public static const START_TICK:int = 500;
		
		//Types of objects
		public static const FREE_TYPE:int = 0;
		public static const WALL_TYPE:int = 1;
		public static const SNAKE_TYPE:int = 2;
		public static const VICTIM_TYPE:int = 3;
		
		//world core
		private var _delta:int;
		private var _tick:int;
		private var _currentTick:int;
		private var _score:int;
		private var _gameOver:Boolean;
		private var _skillCount:int;
		
		//view
		private var _scoreTF:TextField;
		private var _snake:Snake;
		private var _field:Vector.<Vector.<int>>;
		private var _wall:Vector.<Brick>;
		private var _fieldView:Sprite;
		private var _victims:Vector.<Victim>;
		
		public function World() 
		{
			_fieldView = new Sprite;
			this.addChild(_fieldView);
			
			initField();
			
			_victims = new Vector.<Victim>;
			
			_scoreTF = new TextField;
			var tf:TextFormat = new TextFormat();
			tf.size = 50;
			_scoreTF.defaultTextFormat = tf;
			
			this.addChild(_scoreTF);
			
			initGame();
		}
		
		public function get score():int {
			return _score;
		}
		public function get gameOver():Boolean {
			return _gameOver;
		}
		
		public function initGame():void {
			_gameOver = false;
			_skillCount = 0;
			_tick = START_TICK;
			_currentTick = _tick;
			if (_snake) {
				_snake.destroy();
			}
			_snake = new Snake(_fieldView, 7, 5);
			_score = 0;
			_scoreTF.text = String(_score);
			_scoreTF.x = (AppControl.STAGE_W - _scoreTF.textWidth) / 2;
			_scoreTF.y = AppControl.STAGE_H - _scoreTF.textHeight - 10;
			
			if (_victims.length > 0) {
				for each(var victim:Victim in _victims) {
					if (_fieldView.contains(victim)) { _fieldView.removeChild(victim); }
				}
			}
			_victims.length = 0;
			
			addVictim();
		}
		
		public function get snake():Snake {
			return _snake;
		}
		
		public function update(delta:int):void {
			if (_gameOver) {
				dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
				return;
			}
			
			_currentTick -= delta;
			if (_currentTick <= 0) {
				_snake.move();
				if (_snake.checkBitten() || checkForCrash()) {
					_gameOver = true;
					return;
				}
				
				checkForEating();
				
				_currentTick = _tick;
			}
		}
		
		private function initField():void {
			_field = new Vector.<Vector.<int>>;
			_wall = new Vector.<Brick>;
			var brick:Brick;
			for (var i:int = 0; i < WORLD_WIDTH; i++) {
				for (var j:int = 0; j < WORLD_HEIGHT; j++) {
					if (i == 0 || i == WORLD_WIDTH - 1 || j == 0 || j == WORLD_HEIGHT - 1) {
						brick = new Brick();
						brick.x = CELL_SIZE * i + CELL_SIZE/2;
						brick.y = CELL_SIZE * j + CELL_SIZE/2;
						_fieldView.addChild(brick);
					}
				}
			}
		}
		
		private function addVictim():void {
			_field.length = 0;
			for (var i:int = 0; i < WORLD_WIDTH; i++) {
				var f:Vector.<int> = new Vector.<int>;
				for (var j:int = 0; j < WORLD_HEIGHT; j++) {
					if (i == 0 || i == WORLD_WIDTH - 1 || j == 0 || j == WORLD_HEIGHT - 1) {
						f.push(WALL_TYPE);
					} else {
						f.push(FREE_TYPE);
					}
				}
				_field.push(f);
			}
			
			var len:int = _snake.parts.length;
			for (i = 0; i < len; i++) {
				_field[_snake.parts[i].posX][_snake.parts[i].posY] = SNAKE_TYPE;
			}
			
			var rndX:int;
			var rndY:int;
			var flag:Boolean = false;
			while (!flag) {
				rndX = 1 + Math.random() * (WORLD_WIDTH-1);
				rndY = 1 + Math.random() * (WORLD_HEIGHT-1);
				if (_field[rndX][rndY] == FREE_TYPE) {
					var victim:Victim = new Victim(int(Math.random() * 3));
					victim.posX = rndX;
					victim.posY = rndY;
					flag = true;
					_fieldView.addChild(victim);
					_victims.push(victim);
					_field[rndX][rndY] = VICTIM_TYPE;
				}
			}
		}
		
		private function checkForCrash():Boolean {
			var head:SnakePart = _snake.parts[0];
			for (var i:int = 0; i < WORLD_WIDTH; i++) {
				for (var j:int = 0; j < WORLD_HEIGHT; j++) {
					if (_field[i][j] == WALL_TYPE && head.posX == i && head.posY == j) {
						return true;
					}
				}
			}
			return false;
		}
		
		private function checkForEating():void {
			var head:SnakePart = _snake.parts[0];
			var victim:Victim;
			for (var i:int = 0; i < _victims.length; i++) {
				victim = _victims[i];
				if (victim.posX == head.posX && victim.posY == head.posY) {
					_score += victim.points;
					_scoreTF.text = String(_score);
					
					_snake.eat();
					_fieldView.removeChild(victim);
					_victims.splice(i, 1);
					i--;
					addVictim();
					
					if (_snake.parts.length == (WORLD_WIDTH - 1) * (WORLD_HEIGHT - 1)) {
						_gameOver = true;
						return;
					}
					if (int(_score / 100) > _skillCount && _tick - TICK_DECREMENT > 0) {
						_tick -= TICK_DECREMENT;
						_skillCount++;
					}
					
					break;
				}
			}
		}
		
		public function destroy():void {
			//TODO update this for clear world if need to close game screen
		}
	}

}