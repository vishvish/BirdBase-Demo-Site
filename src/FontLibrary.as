package 
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	/**
	 * This is a utility class that provides fonts to your BirdBase application.
	 * 
	 * For a guide to using this class, please see the site here:
	 * http://birdbase.org/2011/05/font-library/
	 * 
	 * @author	Vish Vishvanath
	 */
	public class FontLibrary extends MovieClip
	{
		/**
		 * Lavoisier courtesy of Alec Julien at http://haikumonkey.net/lavoisier-font/ 
		 */
		[Embed(source="resources/lavoisier.otf", fontName='lavoisier', mimeType='application/x-font', embedAsCFF='false')]
		public var lavoisierFont:Class;
		
		public function FontLibrary()
		{
			Font.registerFont( lavoisierFont );
		}
	}
}