package application
{
 	import application.commands.*;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	
	public class Invoker
	{

		var undoStack:Array;			
		var redoStack:Array;
		static var instance = null;
	 	
		public function Invoker()
	 	{
			undoStack = new Array();	
			redoStack = new Array();
		}
		
		public static function getInstance()
		{
			if(instance == null)
			{
				instance = new Invoker();
			}
			return instance;
				
		}
		
		public function addCommand(command:ICommand)
		{
			command.execute();
			if(Configure.read('update_url'))
			{
				var request:URLRequest = new URLRequest(Configure.read('update_url'));
				var variables:URLVariables = new URLVariables();
				variables.text = 'execute';
				request.data = variables;
				request.method = URLRequestMethod.POST;
				var loader = new URLLoader();
				loader.load(request);
			}
			undoStack.push(command);
		}
		
		public function undo()
		{
			var obj = undoStack.pop();
			if(obj != null)
			{
				obj.undo();
				redoStack.push(obj);				
			}

		}
		
		public function pop()
		{
			
			undoStack.pop();
			undoStack.pop();
			undoStack.pop();
			trace('pop()');

		}
		
		public function redo()
		{
			var obj = redoStack.pop();
			if(obj != null)
			{
				obj.execute();
				undoStack.push(obj);				
			}

		}
	}
}