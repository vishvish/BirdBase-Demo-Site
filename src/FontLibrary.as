package 
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class FontLibrary extends MovieClip
	{
		[Embed(source="resources/Chunkfive.otf", fontName='chunk', mimeType='application/x-font', embedAsCFF='false')]
		public var chunkFont:Class;
		
		[Embed(source="resources/Quicksand_Dash.otf", fontName='quick', mimeType='application/x-font', embedAsCFF='false')]
		public var quickFont:Class;
		
		[Embed(source="resources/Vegur-M 0602.otf", fontName='vegur', mimeType='application/x-font', embedAsCFF='false')]
		public var vegurFont:Class;
		
		public function FontLibrary()
		{
			Font.registerFont( chunkFont );
			Font.registerFont( quickFont );
			Font.registerFont( vegurFont );
		}
	}
}