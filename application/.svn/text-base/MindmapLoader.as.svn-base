package application
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class MindmapLoader
	{
		private var xml:XML;
		private var mindmap;
        private var loader:URLLoader;
		private var onCompleteCallback;
		
		public function MindmapLoader(m)
	 	{
			this.mindmap = m;
			trace('MindmapLoader::MindmapLoader()');
		}
		
		public function addEventListener(type, func)
		{
			if(type=='onComplete')
			{
				this.onCompleteCallback = func;
			}
		}

		public function loadMindmap()
		{
			trace('loading');
			if(Configure.read('xml_data'))
			{
				xml = new XML(Configure.read('xml_data'));
				this.parseXML(xml);
			}
			else if(Configure.read('load_url'))
			{
				trace('Loading from URL: ' + Configure.read('load_url'));
				var request:URLRequest = new URLRequest(Configure.read('load_url'));
	
				loader = new URLLoader();
				
				try {
					loader.load(request);
				}
				catch (error:SecurityError)
				{
					trace("A SecurityError has occurred.");
				}
				loader.addEventListener(IOErrorEvent.IO_ERROR, function(){trace('IOERROREVENT');});
				loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			}
			
			if(Configure.read('lock_url'))
			{
				var interval = Configure.read('lock_interval');
				var timer:Timer = new Timer(1000*interval);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, function(){
					var lockRequest:URLRequest = new URLRequest(Configure.read('lock_url'));
					var lockLoader:URLLoader = new URLLoader();
					lockLoader.load(lockRequest);
					lockLoader.addEventListener(IOErrorEvent.IO_ERROR, function(){trace('IOERROREVENT');});
					lockLoader.addEventListener(Event.COMPLETE, function(){});
					trace('TICK');
				});
			}
			
		}

		private function parseXML(xml)
		{
			var mindmapXML = new MindmapXML();
			mindmapXML.setMindmap(this.mindmap);
			mindmapXML.parse(xml);
			if(this.onCompleteCallback != null)
			{
				onCompleteCallback();
			}
		}
		
        private function loaderCompleteHandler(event:Event):void {

                try {
					trace(loader.data);
                    xml = new XML(loader.data);
					this.parseXML(xml);  
					
					trace('try');
                } catch (e:TypeError) {
                    trace("Could not parse the XML file.");
                }
        }
		
		
		public function save()
		{
			xml = this.getXMLData();
			if(Configure.read('save_url'))
			{
				var request:URLRequest = new URLRequest(Configure.read('save_url'));
				var variables:URLVariables = new URLVariables();
				variables.mindmap = xml.toString();
				request.data = variables;
				request.method = URLRequestMethod.POST;
				var loader = new URLLoader();
				loader.load(request);
			}
			else if(Configure.read('save_function'))
			{
				var string = encodeURI(xml.toString());
				flash.external.ExternalInterface.call(Configure.read('save_function') + '("' + string + '")');
			}
			else
			{
				trace(xml.toString())
			}
		}
		
		private function getXMLData()
		{
			var mindmapXML = new MindmapXML();
			mindmapXML.setMindmap(this.mindmap);
			xml = mindmapXML.getXMLData();
			return xml;
		}
	}
}