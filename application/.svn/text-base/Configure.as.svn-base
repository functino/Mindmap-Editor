package application
{
	import flash.system.Capabilities;
	public class Configure
	{
		static var data = new Array();
		static var parameters;
		
		static public function init(p)
		{
			var xml:XML = <MindMap>
			  <MM>
				<Node x_Coord="250" y_Coord="250" PopUp="0" Name="K00001">
				  <Text>root</Text>
				  <Format Underlined="0" Italic="0" Bold="1" Alignment="M" Size_x="30" Size_y="70">
					<Font>Trebuchet MS</Font>
					<FontSize>14</FontSize>
					<FontColor>ffffff</FontColor>
					<BackgrColor>990000</BackgrColor>
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
				  <ConnectLine>
					<LineColor>000000</LineColor>
					<LineSize>1</LineSize>
				  </ConnectLine>
				</Node>
			  </MM>
			</MindMap>;
			var xml_string = xml.toString();
			xml_string = encodeURI(xml_string);			
			// if the flash runs in a Browser or via Adobe AIR...
			if(Capabilities.playerType == 'PlugIn' || Capabilities.playerType == 'ActiveX' || Capabilities.playerType == 'Desktop')
			{
				if(p['xml_data'] != null)
				{
					Configure.write('xml_data', decodeURI(p['xml_data']));
				}
				if(p['load_url']!= null)
				{
					Configure.write('load_url', p['load_url']);
				}
				
				if(p['xml_data'] == null && p['load_url'] == null)
				{
					Configure.write('xml_data', decodeURI(xml_string));
				}
				
				if(p['auto_node_url'] != null)
				{
					Configure.write('auto_node_url', p['auto_node_url']);
				}
				
				if(p['lock_url']!= null)
				{
					Configure.write('lock_url', p['lock_url']);
				}
				if(p['lock_inverval']!= null)
				{
					Configure.write('lock_interval', p['lock_interval']);
				}
				else
				{
					Configure.write('lock_interval', 30);
				}
				
				if(p['save_url']!=null)
				{
					Configure.write('save_url', p['save_url']);
				}
				if(p['update_url'] != null)
				{
					Configure.write('update_url', p['update_url']);
				}
				
				if(p['lang'] != null)
				{
					Configure.write('lang', p['lang']);
				}
				if(p['save_function'] != null)
				{
					Configure.write('save_function', p['save_function']);
				}
				if(p['bitmap_gateway_url'] != null)
				{
					Configure.write('bitmap_gateway_url', p['bitmap_gateway_url']);
				}
				
				if(p['editable'] != null)
				{
					Configure.write('editable', true);
				}
				else
				{
					Configure.write('editable', false);
				}
			}
			else
			{
				Configure.write('lang', 'de');
				Configure.write('editable', true);
				Configure.write('xml_data', decodeURI(xml_string));
			}
		}
		
		static public function read(key)
		{
			if(data[key] == null)
			{
				return false;	
			}
			return data[key];
		}		

		static public function write(key, value)
		{
			data[key] = value;
		}
	}
}