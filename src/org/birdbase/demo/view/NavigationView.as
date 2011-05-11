package org.birdbase.demo.view
{
	import flash.events.Event;
	
	import org.birdbase.demo.view.components.NavigationButton;
	import org.birdbase.framework.view.AbstractTransitioningView;
	
	public class NavigationView extends AbstractTransitioningView
	{
		public function NavigationView()
		{
			super();
		}
		
		public function buildNavigation( navigation:Array ):void
		{
			var padding:Number = 0;
			
			for( var i:Number = 0; i < navigation.length; i++ )
			{
				var navigationItem:* = navigation[ i ].item;

				var button:NavigationButton = new NavigationButton( this, 20 + padding, 20, navigationItem.label, onButtonPressed );
				button.destination = navigationItem.destination;
				
				padding += button.width;
			}
		}
		
		/**
		 * Re-dispatches the click event.
		 *  
		 * @param e
		 */
		private function onButtonPressed( e:Event ):void
		{
			dispatchEvent( e );
		}
	}
}