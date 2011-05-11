package org.birdbase.demo.view
{
	import com.bit101.components.PushButton;
	
	import flash.display.Bitmap;
	
	import org.as3commons.collections.Map;
	import org.birdbase.framework.view.AbstractTransitioningView;
	import org.idmedia.as3commons.lang.NullPointerException;
	
	/**
	 * Sample background view. On screen permanently.
	 *  
	 * @author	Vish Vishvanath
	 * @since	03 May 2011
	 */
	public class BackgroundView extends AbstractTransitioningView
	{
		public function BackgroundView()
		{
			super();
		}
		
		override public function main():void
		{
			this.alpha = 0;
		}
		
		public function setMedia( assets:Map ):void
		{
			if( assets.hasKey( "background" ) )
			{
				addChild( assets.itemFor( "background" ) as Bitmap );
			}
		}
	}
}