package application
{
 	import application.commands.*;
 	import application.models.*;
	import application.*;
 	
	public class MindmapXML
	{
		var mindmap;
		var xml;
		var allPositionsZero = true;

		public function MindmapXML()
	 	{
			trace('MindmapXML::MindmapXML()');
		}
		
		public function setMindmap(m)
		{
			this.mindmap = m;
		}
		
		public function getMindmap()
		{
			return this.mindmap;
		}
		
		public function parse(xml)
		{
			
			var map = xml.MM[0];
			var rootNodeXML = map.Node[0];
			var rootNode = this.mindmap.getRootNode();
			this.formatNode(rootNodeXML, rootNode);
			trace('MindmapXML::parse()');
			trace(rootNodeXML.Text.text());
			
			for(var i in rootNodeXML.Node)
			{
				this.parseNode(rootNodeXML.Node[i], rootNode);
			}
			
			//there were no coords specified
			if(allPositionsZero)
			{
				mindmap.getRootNode().setX(250);
				mindmap.getRootNode().setY(250);			
				var autoLayout = new AutoLayout();
				autoLayout.layout(mindmap);
				trace('allPositionsZero');
			}
		}
		
		private function parseNode(nodeXML, node)
		{
			var n = new Node(mindmap);
			node.addNode(n);
			this.formatNode(nodeXML, n);
			for(var i in nodeXML.Node)
			{
				this.parseNode(nodeXML.Node[i], n);
			}
		}
		
		private function formatNode(xml, node)
		{
		 	node.setText(xml.Text.text());
			if(xml.@x_Coord != 0 || xml.@y_Coord != 0)
			{
				allPositionsZero = false;
			}
			node.setX(xml.@x_Coord);
			node.setY(xml.@y_Coord);
			node.setExpand(xml.@PopUp);
			node.setBold(Number(xml.Format.@Bold));
			node.setItalic(Number(xml.Format.@Italic));
			node.setUnderline(Number(xml.Format.@Underlined));
			node.setBackgroundColor("0x" + xml.Format.BackgrColor.text());
			node.setColor("0x" + xml.Format.FontColor.text());
			
			node.setFont(xml.Format.Font.text());
			/*
			node.setFontSize(xml.Format.FontSize.text());

			
			node.setLineSize(xml.Format.ConnectLine.LineSize.text());
			node.setLineColor(xml.Format.ConnectLine.LineColor.text());
			*/
		}
		
		public function getXMLData()
		{
		 	xml = new XML(<MindMap><MM></MM></MindMap>);
		 	xml.MM.appendChild(this.getNodeXMLData(mindmap.getRootNode()));
			return xml;
		}
		
		
		
		
		
		
		
		
		
		private function getNodeXMLData(node)
		{
			var node_xml:XML = new XML();
		 	node_xml = 	<Node x_Coord="0" y_Coord="0" PopUp="0" Name="K00001">
			<Text>test</Text>
			<Format Underlined="1" Italic="1" Bold="1" Alignment="M" Size_x="30" Size_y="70">
				<Font>Arial</Font>
				<FontSize>12</FontSize>
				<FontColor>000000</FontColor>
				<BackgrColor>000000</BackgrColor>
				<FormatLine>
					<LineColor>000000</LineColor>
					<LineSize>1</LineSize>
					<LineForm>DEFAULT</LineForm>
				</FormatLine>
				<ConnectLine>
					<LineColor>000000</LineColor>
					<LineSize>1</LineSize>
					<LineForm>DEFAULT</LineForm>
				</ConnectLine>
			</Format>
			</Node>;
			
			node_xml.Text = new XML(node.getText());
			node_xml.@x_Coord = node.getX();
			node_xml.@y_Coord = node.getY();
			node_xml.Format.@Underlined = int(node.getUnderline());
			node_xml.Format.@Italic = int(node.getItalic());
			node_xml.Format.@Bold = int(node.getBold());
			node_xml.Format.Font = new XML(node.getFont());
			node_xml.Format.FontSize = new XML(node.getFontSize());
			node_xml.Format.FontColor = new XML(String(node.getColor()).substr(2));
			
			node_xml.Format.BackgrColor = new XML(String(node.getBackgroundColor()).substr(2));
			node_xml.ConnectLine.LineColor = new XML(node.getLineColor());
			node_xml.ConnectLine.LineSize = new XML(node.getLineSize());
			
			var childs = node.getChilds()
			for(var i in childs)
			{
				node_xml.appendChild(this.getNodeXMLData(childs[i]));
			}
			
		 	return node_xml;
		}
	}
	



	


}