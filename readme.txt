A simple flash based mindmap editor with various configuration options.

Currently used for the Moodle Mindmap Module: https://github.com/functino/Moodle-Mindmap-Module

Configuration options can be set via flashvars. The following config options are available:

- editable: true/false, default: fale
	Decides wether or not the currently viewd mindmap can be edited or is simply shown without the possibiliy to change something
- lang: de/en, default: de
	Language of the interface
- save_url: String, default: -
	A url where the editor POSTs data if the user tries to save a mindmap. The Mindmap data is send as xml in a POST param called "mindmail"
- save_function: String, default: -
	If you don't use a save_url you can alternatively use a javascript save_function. Simply provide the javascript function name and the editor will call this function with the XML as it's first parameter when the user tries to save something
- load_url: String: default: -
	A url where you provide the XML of a Mindmap that should be displayed
- xml_data: XML, -
	A valid mindmap XML-String. If you set this option the load_url will be ignored
- lock_url: String, -
	This url get's called in an interval to inform you that the user stills has the mindmap opened. Useful for implementing a "This mindmap is currently locked" feature
- lock_interval: Integer, 30
	How often should the lock_url get called. Value is in seconds
- bitmap_gateway_url: String, -
	If you provide this url there will be an additional button to export the mindmap as an image. An example implementation of this feature can be found in my Ekpenso repository (https://github.com/functino/Ekpenso)
- autonode_url: String, -
	This is just a fun feature do automatically create nodes. The Editor will POST a text and limit parameter to this url and you should return xml in the following format: <xml><node>result 1</node><node>result 2 </node>. For an example implementation see the Ekpenso repository (https://github.com/functino/Ekpenso)

This is a sample configuration with SWFObject:

var so = new SWFObject("http://example.com/viewer.swf", "viewer", 900, 600, "9", "#FFFFFF"); 
so.addVariable("load_url", "http://example.com/mindmaps/xml/20"); 
so.addVariable('save_url', 'http://example.com/mindmaps/save/20'); 
so.addVariable('lock_url', 'http://example.com/mindmaps/lock/20'); 
so.addVariable('bitmap_gateway_url', 'http://example.com/img.php'); 
so.addVariable('editable', 'true');
so.addVariable("lang", "en"); 
so.write("flashcontent");