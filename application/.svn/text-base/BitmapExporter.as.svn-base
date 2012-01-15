package application
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.text.TextFieldAutoSize;
	public class BitmapExporter
	{
		public var gateway:String; // the url of the gateway script (f.e. a php script ...)
		public var scale;
		private var format = 'png'; // format to export to
		public function BitmapExporter()
		{
			this.scale = 0.7;
		}
		
		public function setGateway(url)
		{
			this.gateway = url;
		}
		
		public function export(mc, format)
		{
			this.format = format;
			var snap:BitmapData = new BitmapData(mc.stage.stageWidth * scale, mc.stage.stageHeight * scale);
			trace('MovieClip: ' + mc.stage.stageWidth + ', ' + mc.stage.stageHeight);

			
			var myMatrix:Matrix = new Matrix();
			myMatrix.scale(scale, scale);
			snap.draw(mc,  myMatrix);
			
			var w:Number = snap.width;
			var h:Number = snap.height;
			var tmp;
			var pixels = new Array();
			

			for(var a=0; a<w; a++)
			{
				//Build pixels array using an onEnterframe to avoid timeouts, capture a row per iteration, show a progressbar
				for(var b=0; b<=h; b++){
					//tmp = snap.getPixel32(a, b).toString(16);
					tmp = snap.getPixel(a, b).toString(16);
					if(tmp == 'ffffff')
					{
						tmp = '';
					}
					pixels.push(tmp);
				}
			}
			snap.dispose();
			sendData(pixels, h, w);

			trace('done');
		}
		
		function sendData(pixels, h, w)
		{
			var request:URLRequest = new URLRequest(this.gateway);
			var variables:URLVariables = new URLVariables();
			variables.img = pixels.toString();
			variables.height = h;
			variables.width = w;
			variables.type = this.format;
			request.data = variables;
			request.method = URLRequestMethod.POST;
			trace('requestMethod' + request.method);
			flash.net.navigateToURL(request);
			trace('send');
		}
	}
}