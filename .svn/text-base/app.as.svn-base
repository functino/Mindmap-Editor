import flash.display.MovieClip;
import fl.controls.Button;
import fl.controls.TextArea;
import fl.controls.Slider;
import fl.controls.ColorPicker;
import fl.events.ColorPickerEvent;
import fl.controls.SliderDirection;
import fl.events.SliderEvent;
import fl.controls.ProgressBar;
import fl.controls.ComboBox;
import fl.controls.Label;


import application.commands.*;
import application.views.*;
import application.models.*;
import application.*;

stage.align = StageAlign.TOP_LEFT;
stage.scaleMode = StageScaleMode.NO_SCALE;


var parameters = LoaderInfo(this.root.loaderInfo).parameters;	
Configure.init(parameters);
I18n.init();
I18n.setLang(Configure.read('lang'));

var loadingContainer = new LoadingScreen();
addChild(loadingContainer);
loadingContainer.display();
Configure.write('loadingContainer', loadingContainer);

var mm = new Mindmap();
var mindmapContainer = new MovieClip();
mindmapContainer.y = 30;
mindmapContainer.visible = false;
addChild(mindmapContainer);

var guiContainer = new MovieClip();
guiContainer.y=0;
guiContainer.visible = false;
addChild(guiContainer);


var barImage = new Bitmap(new BarImage(1, 50));
barImage.x = 0;
barImage.width = guiContainer.stage.stageWidth;
barImage.height = 30;
barImage.y = 0;
guiContainer.addChild(barImage);



var ml = new MindmapLoader(mm);
ml.addEventListener('onComplete', onCompleteHandler);
ml.loadMindmap();

function onCompleteHandler()
{
	trace('oncomplete fired');
	loadingContainer.visible = false;
	mindmapContainer.visible = true;
	guiContainer.visible = true;
}

addEventListener("enterFrame", function(){
	mm.view.drawMap();
});

mindmapContainer.addChild(mm.view);
mindmapContainer.graphics.beginFill(0xffffff);
mindmapContainer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);

// make the mindmap draggable
mindmapContainer.addEventListener(MouseEvent.MOUSE_DOWN, function(e){
	if(e.target == mindmapContainer)
	{
		mm.view.startDrag();
	}
});
mindmapContainer.addEventListener(MouseEvent.MOUSE_UP, function(e){
	if(e.target ==mindmapContainer)
	{
		mm.view.stopDrag();
	}
});
var invoker = Invoker.getInstance();

//add Key- and MouseEvent-Listeners if the mindmap is editable
if(Configure.read('editable'))
{
	mindmapContainer.doubleClickEnabled = true;
	mindmapContainer.addEventListener(MouseEvent.DOUBLE_CLICK, function(e){
			var newNode = new Node(mm);
			newNode.setX((e.localX - mm.view.x)/mm.view.scaleX - 15);
			newNode.setY((e.localY - mm.view.y)/mm.view.scaleY - 15);
			var parentNode = null;
			if(e.ctrlKey)
			{
				parentNode = mm.getActiveNode();
			}
			else
			{
				parentNode = mm.getRootNode();
			}
			
			var com = new CreateNodeCommand(mm, newNode, parentNode);
			Invoker.getInstance().addCommand(com);
	});		
		
		
	var save:Button = new Button();
	save.x = 0;
	save.y = 0;
	save.width = 30;
	save.label = ''; 
	var saveIcon = new Bitmap(new SaveIcon(16, 16));
	save.setStyle('icon', saveIcon);
	save.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		ml.save();
	});
	guiContainer.addChild(save);
	
	
	
	var button:Button = new Button();
	button.x = 30;
	button.y = 0;
	button.width = 30;
	button.label = '';
	var addIcon = new Bitmap(new AddIcon(16, 16));
	button.setStyle('icon', addIcon);
	button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		mm.createNode();
	});
	guiContainer.addChild(button);
	
	
	var remove:Button = new Button();
	remove.x = 60;
	remove.y = 0;
	remove.width = 30;
	remove.label = '';
	var removeIcon = new Bitmap(new RemoveIcon(16, 16));
	remove.setStyle('icon', removeIcon);
	remove.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		mm.deleteElement();
	});
	guiContainer.addChild(remove);
	
	var colorButton:ColorPicker = new ColorPicker();
	colorButton.height = 21;
	colorButton.width = 20;
	colorButton.x = 92;
	colorButton.y = 2;
	guiContainer.addChild(colorButton);
	colorButton.addEventListener(ColorPickerEvent.CHANGE, function(e:ColorPickerEvent){
		var co = new SetBackgroundColorCommand(mm.getActiveNode(), "0x" + e.target.hexValue);
		Invoker.getInstance().addCommand(co);
	});	
	
	
	var undo:Button = new Button();
	undo.x = 115;
	undo.y = 0;
	undo.width = 30;
	undo.label = '';
	var undoIcon = new Bitmap(new UndoIcon(16, 16));
	undo.setStyle('icon', undoIcon);
	undo.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		Invoker.getInstance().undo();
	});
	guiContainer.addChild(undo);
	
	var redo:Button = new Button();
	redo.x = 145;
	redo.y = 0;
	redo.width = 30;
	redo.label = '';
	var redoIcon = new Bitmap(new RedoIcon(16, 16));
	redo.setStyle('icon', redoIcon);
	redo.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		Invoker.getInstance().redo();
	});
	guiContainer.addChild(redo);
	
	
	var bold:Button = new Button();
	bold.x = 180;
	bold.y = 0;
	bold.width = 20;
	bold.label = '';
	var boldIcon = new Bitmap(new BoldIcon(16, 16));
	bold.setStyle('icon', boldIcon);
	bold.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		mm.toggleNodeBold();
	});
	guiContainer.addChild(bold);
	
	var italic:Button = new Button();
	italic.x = 200;
	italic.y = 0;
	italic.width = 20;
	italic.label = '';
	var italicIcon = new Bitmap(new ItalicIcon(16, 16));
	italic.setStyle('icon', italicIcon);
	italic.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		mm.toggleNodeItalic();
	});
	guiContainer.addChild(italic);
	
	var underline:Button = new Button();
	underline.x = 220;
	underline.y = 0;
	underline.width = 20;
	underline.label = '';
	var underlineIcon = new Bitmap(new UnderlineIcon(16, 16));
	underline.setStyle('icon', underlineIcon);
	underline.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
		mm.toggleNodeUnderline();
	});
	guiContainer.addChild(underline);
	
	
		
	var fontCombo:ComboBox = new ComboBox();
	guiContainer.addChild(fontCombo);
	fontCombo.x=240;
	fontCombo.width = 85;
	fontCombo.y=0;
	fontCombo.prompt = "Font";
	fontCombo.addItem( { label: "Comic Sans MS", data:"Comic Sans MS" } );
	fontCombo.addItem( { label: "Arial", data:"Arial" } );
	fontCombo.addItem( { label: "Times New Roman", data:"Times New Roman" } );
	fontCombo.addItem( { label: "Verdana", data:"Verdana" } );
	fontCombo.addEventListener(Event.CHANGE, function(e:Event){
		var fontCom = new SetFontCommand(mm.getActiveNode(), e.target.selectedItem.data);
		Invoker.getInstance().addCommand(fontCom);
	});
	
	
	
	
	
	stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e){
		trace(e.keyCode);
		if(e.keyCode == Keyboard.DELETE) // user hits delete
		{
			var c = new RemoveNodeCommand(mm.getActiveNode());
			Invoker.getInstance().addCommand(c);
		}
		else if(e.keyCode == 68 && e.ctrlKey )
		{
			if(mm.getActiveNode() != mm.getRootNode())
			{
				var rbc = new RemoveBranchCommand(mm.getActiveNode());
				Invoker.getInstance().addCommand(rbc);
			}
		}
		else if(e.keyCode == Keyboard.INSERT || e.keyCode == 65 && e.ctrlKey)
		{
			mm.createNode('child');
		}
		else if(e.keyCode == Keyboard.ENTER)
		{
			mm.createNode();
		}
		else if(e.keyCode == 90 && e.ctrlKey)
		{
			Invoker.getInstance().undo();
		}
		else if(e.keyCode == 89 && e.ctrlKey)
		{
			Invoker.getInstance().redo();
		}
		else if(e.keyCode == Keyboard.END)
		{
			if(Configure.read('auto_node_url'))
			{
				var anc = new AutoNodeCommand(mm.getActiveNode());
				Invoker.getInstance().addCommand(anc);
			}
		}
	});
	
	
	
	
	
	
	

	
	
	
	var color2Button:ColorPicker = new ColorPicker();
	color2Button.height = 21;
	color2Button.width = 20;
	color2Button.x = 325;
	color2Button.y = 0;
	guiContainer.addChild(color2Button);
	color2Button.addEventListener(ColorPickerEvent.CHANGE, function(e:ColorPickerEvent){
		var co2 = new SetColorCommand(mm.getActiveNode(), "0x" + e.target.hexValue);
		Invoker.getInstance().addCommand(co2);
	});
	
	if(Configure.read('bitmap_gateway_url'))
	{
		var be = new BitmapExporter();
		be.gateway = Configure.read('bitmap_gateway_url');
		var exLabel:Label = new Label();
		exLabel.text = I18n.translate('export') + ":";
		exLabel.x = 350;
		guiContainer.addChild(exLabel);
		var im:Button = new Button();
		im.x = 390;
		im.y = 0;
		im.label = '';
		im.width = 30;
		var imageIcon = new Bitmap(new ImageIcon(16, 16));
		im.setStyle('icon', imageIcon);
		im.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
			be.export(mindmapContainer, 'png');
		});
		guiContainer.addChild(im);
		var pdf:Button = new Button();
		pdf.x = 420;
		pdf.y = 0;
		pdf.width = 30;
		pdf.label = '';
		var pdfIcon = new Bitmap(new PdfIcon(16, 16));
		pdf.setStyle('icon', pdfIcon);
		pdf.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
			be.export(mindmapContainer, 'pdf');
		});
		guiContainer.addChild(pdf);		
		
	}
	
	var layout:Button = new Button();
	layout.x = 460;
	layout.y = 0;
	layout.label = I18n.translate('layout');
	var eyeIcon = new Bitmap(new EyeIcon(16, 16));
	layout.setStyle('icon', eyeIcon);
	layout.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
																		
		var autoLayout:IAutoLayout;
		
		//here we could load different AutoLayouts
		autoLayout = new AutoLayout();
		var layoutCommand = new AutoLayoutCommand(mm, autoLayout);
		Invoker.getInstance().addCommand(layoutCommand);
	});
	guiContainer.addChild(layout);
}

















var zoomSlider:Slider = new Slider();
guiContainer.addChild(zoomSlider);
zoomSlider.x= zoomSlider.stage.stageWidth - zoomSlider.width - 19;
zoomSlider.y=10;
zoomSlider.direction = SliderDirection.HORIZONTAL;
zoomSlider.maximum = 3;
zoomSlider.minimum = 0.2;
zoomSlider.snapInterval = 0.001;
zoomSlider.value = 1;
zoomSlider.liveDragging = true;

zoomSlider.addEventListener(SliderEvent.CHANGE, zoomSliderChangeHandler);

function zoomSliderChangeHandler(e:SliderEvent){
	mm.view.scaleX = zoomSlider.value;
	mm.view.scaleY = zoomSlider.value;
	var rn = mm.getRootNode();
	mm.view.x = rn.getX() - rn.getX() * zoomSlider.value;
	mm.view.y = rn.getY() - rn.getY() * zoomSlider.value;
}



var expandCombo:ComboBox = new ComboBox();
guiContainer.addChild(expandCombo);
expandCombo.setSize(40,20);
expandCombo.x = zoomSlider.x - expandCombo.width - 20;
expandCombo.y=3;
expandCombo.prompt = "";
expandCombo.addItem( { label: "1", data:1 } );
expandCombo.addItem( { label: "2", data:2 } );
expandCombo.addItem( { label: "3", data:3 } );
expandCombo.addItem( { label: "4", data:4 } );
expandCombo.addItem( { label: I18n.translate("all"), data:100 } );
expandCombo.selectedIndex = 5;
expandCombo.addEventListener(Event.CHANGE, function(e:Event){
	mm.expandLevel(e.target.selectedItem.data);
});







var format:TextFormat = new TextFormat();
format.color = 0x000000;
format.size = 9;

var zoomIn = new Button();
zoomIn.label = '+';
zoomIn.setStyle("textFormat", format);
zoomIn.width=15;
zoomIn.height=15;
zoomIn.setStyle('textPadding', 0);
zoomIn.x = zoomSlider.x + zoomSlider.width;
zoomIn.y = 4;
zoomIn.addEventListener('click', function(){
    zoomSlider.value = zoomSlider.value + 0.1;
	zoomSliderChangeHandler(null);
});	
guiContainer.addChild(zoomIn);


var zoomOut = new Button();
zoomOut.label = '-';
zoomOut.setStyle("textFormat", format);
zoomOut.width=15;
zoomOut.height=15;
zoomOut.setStyle('textPadding', 0);
zoomOut.x = zoomSlider.x - zoomOut.width;
zoomOut.y = 5;
zoomOut.addEventListener('click', function(){
    zoomSlider.value = zoomSlider.value - 0.1;
	zoomSliderChangeHandler(null);
});	
guiContainer.addChild(zoomOut);