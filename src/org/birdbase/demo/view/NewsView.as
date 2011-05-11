package org.birdbase.demo.view
{
	import com.bit101.components.Window;
	
	import flash.display.Bitmap;
	
	import org.as3commons.collections.Map;
	import org.birdbase.framework.view.AbstractTransitioningView;
	
	public class NewsView extends AbstractTransitioningView
	{
		public function NewsView()
		{
			super();
		}

		/**
		 * Start off this view faded out. 
		 */
		override public function main():void
		{
			this.alpha = 0;
		}
		
		/**
		 * Loops through all the bitmaps the mediator has sent it and displays them in draggable windows.
		 *  
		 * @param media
		 */
		public function setMedia( media:Map ):void
		{
			var a:Array = media.keysToArray();
			
			for( var i:Number = 0; i < a.length; i++ )
			{
				var image:Bitmap = media.itemFor( a[ i ] ) as Bitmap;
				
				var window:Window = new Window( this, 100 * ( i + 1 ), 100 * ( i + 1 ) );
				window.draggable = true;
				window.addChild( image );
				window.width = image.width;
				window.height = image.height;
			}
		}
	}
}