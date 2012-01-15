package application
{
	import flash.display.MovieClip;
	import fl.controls.ProgressBar;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Bitmap;
	
	public class LoadingScreen extends MovieClip
	{
		var loadingContainer;
		var loadingBar;
		var ekpensoIcon;
		public function LoadingScreen()
		{
			loadingContainer = new MovieClip();
		}
		
		public function display()
		{
			addChild(loadingContainer);
			ekpensoIcon = new Bitmap(new EkpensoIcon(400, 149));
			loadingContainer.addChild(ekpensoIcon);
			ekpensoIcon.x = ekpensoIcon.stage.stageWidth/2 - ekpensoIcon.width/2;
			ekpensoIcon.y = ekpensoIcon.stage.stageHeight/2 - ekpensoIcon.height/2;
			ekpensoIcon.alpha = 0.2;
			
			loadingBar = new ProgressBar();
			loadingContainer.addChild(loadingBar);
			loadingBar.x = loadingBar.stage.stageWidth/2 - loadingBar.width/2;
			loadingBar.y = loadingBar.stage.stageHeight/2 - loadingBar.height;
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0x88AA00;
			tf.size = 15;
			tf.bold = true;
			tf.font = 'Trebuchet MS';
			var loadingText:TextField = new TextField();
			loadingText.width = 300;
			loadingText.text = I18n.translate('loading');
			loadingText.setTextFormat(tf);
			loadingContainer.addChild(loadingText);
			loadingText.x = loadingBar.x;
			loadingText.y = loadingBar.y - loadingBar.height - 20;
		}
	}
}