package 
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	public class FontLibrary extends MovieClip
	{
		[Embed(source="resources/lavoisier.otf", fontName='lavoisier', mimeType='application/x-font', embedAsCFF='false')]
		public var lavoisierFont:Class;
		
		public function FontLibrary()
		{
			Font.registerFont( lavoisierFont );
		}
	}
}