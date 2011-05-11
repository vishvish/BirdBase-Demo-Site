package org.birdbase.demo.view
{
	import com.epologee.navigator.integration.swfaddress.SWFAddressNavigator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.birdbase.demo.view.components.NavigationButton;
	import org.birdbase.framework.model.Settings;
	
	public class NavigationViewMediator extends AbstractMediator
	{
		[Inject]
		public var settings:Settings;
		
		[Inject]
		public var view:NavigationView;
		
		[Inject]
		public var navigator:SWFAddressNavigator;
		
		public function NavigationViewMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			var navigationItems:Dictionary = settings.getSetting( "menu" );
			if( navigationItems.items )
			{
				view.buildNavigation( navigationItems.items );
			}
			else
			{
				throw new Error( "The navigation is empty" );
			}
			
			addViewListener( MouseEvent.CLICK, onViewPressed );
		}
		
		/**
		 * Responds to the NavigationView. Checks for a NavigationButton being pressed.
		 *  
		 * @param e
		 */
		private function onViewPressed( e:Event ):void
		{
			if( e.target is NavigationButton )
			{
				info( e.target.destination );
				navigator.requestNewState( e.target.destination );
			}
		}
	}
}