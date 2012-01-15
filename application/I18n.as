package application
{
	public class I18n
	{
	 	static var instance = null;
		static var lang;
		static var translations;
		public function I18n()
		{
		}
		
		static public function init()
		{
			lang = "de";
			translations = new Array();
			translations['de'] = new Array();
			translations['de']['root_node'] = 'Wurzelknoten';
			translations['de']['loading_mindmap'] = 'Mindmap lädt';
			translations['de']['loading_mindmap'] = 'lädt';
			translations['de']['layout'] = 'Layout';			
			translations['de']['all'] = 'alle';
			translations['de']['export'] = 'Export';
			translations['en'] = new Array();
			translations['en']['loading_mindmap'] = 'Loading Mindmap';
			translations['de']['loading_mindmap'] = 'loading';
			translations['en']['root_node'] = 'root node';
			translations['de']['layout'] = 'Layout';			
			translations['de']['all'] = 'all';
			translations['de']['export'] = 'Export';
		}
		
		static public function getLang()
		{
			return lang;
		}
		
		static public function setLang(la)
		{
			lang = la;
		}
		
		static public function translate(string, setLang=null)
		{
			var curLang = lang;
			if(setLang != null)
			{
				curLang = setLang;
			}
			
			if(translations[curLang][string] != null)
			{
				return translations[curLang][string];
			}
			return string;
		}
	}
}