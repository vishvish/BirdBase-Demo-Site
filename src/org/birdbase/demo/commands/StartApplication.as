package org.birdbase.demo.commands
{
	import com.epologee.navigator.integration.robotlegs.mapping.*;
	import com.epologee.navigator.integration.swfaddress.SWFAddressNavigator;
	
	import org.birdbase.demo.view.*;
	import org.birdbase.framework.controller.boot.BootManagement;
	import org.birdbase.framework.model.*;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.statemachine.StateEvent;
	
	/**
	 * This command is fired by the framework once the configuration is loaded and bootstrap is complete.
	 * 
	 * At this point, we have all the information to map our URLs to our views/mediators.
	 * 
	 * The example code in here is only one way to map URLs in AS3-Navigator. The integration, at time of writing,
	 * is being worked on by Eric-Paul Lecluse, and the standard way is to extend NavigatorContext.
	 * 
	 * I wanted to keep AS3-Navigator higher up in the application layers, and to dynamically map the view, mediator
	 * and URL using a little bit of reflection. I think it's tider than reams of XML. Hence the StateViewMap is
	 * manually instantiated below.
	 * 
	 * The references to ViewRecipes in the code are a way to layer multiple views in AS3-Navigator. Please refer to
	 * that library for better and more up-to-date documentation.
	 *  
	 * @author	Vish Vishvanath
	 * @since	03 May 2011
	 */
	public class StartApplication extends Command
	{
		[Inject]
		public var settings:Settings;
		
		[Inject]
		public var navigationModel:INavigationModel;
		
		[Inject]
		public var navigator:SWFAddressNavigator;
		
		/**
		 * The Navigator map. 
		 */
		public var stateViewMap:IStateViewMap;

		public function StartApplication()
		{
			super();
		}
		
		override public function execute():void
		{
			stateViewMap = new StateViewMap( navigator, injector, mediatorMap, contextView );
			
			joinViewToMediator( BackgroundView, BackgroundViewMediator );
			joinViewToMediator( HomeView, HomeViewMediator );
			joinViewToMediator( NavigationView, NavigationViewMediator );
			joinViewToMediator( MediaView, MediaViewMediator );
			joinViewToMediator( NewsView, NewsViewMediator );

			// we are done. Hand over control to the user.
			eventDispatcher.dispatchEvent(
				new StateEvent( StateEvent.ACTION, BootManagement.START_APPLICATION_COMPLETE ) );
		}

		/**
		 * Shortcut method.
		 *  
		 * @param view
		 * @param mediator
		 */
		private function joinViewToMediator( view:Class, mediator:Class ):ViewRecipe
		{
			var vr:ViewRecipe = stateViewMap.mapViewMediator( $( view ), view, mediator );
			return vr;
		}
		
		/**
		 * Shortcut method. The reflection all happens in the NavigationModel, mapping fully-qualified classes in.
		 * 
		 * @param view
		 * @return state
		 */
		private function $( view:Class ):Array
		{
			return navigationModel.getDestinationForView( view );
		}
	}
}