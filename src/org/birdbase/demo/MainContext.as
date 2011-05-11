package org.birdbase.demo
{
	import flash.display.Sprite;
	
	import logmeister.LogMeister;
	import logmeister.connectors.TrazzleConnector;
	
	import org.birdbase.demo.commands.StartApplication;
	import org.birdbase.framework.BirdbaseContext;
	import org.birdbase.framework.controller.boot.BootManagement;
	import org.robotlegs.utilities.statemachine.StateEvent;
	
	/**
	 * The main entry point of the application, excluding pre-loader stuff.
	 * 
	 * If you are a Mac OS X User, go and download a copy of Trazzle from http://www.nesium.com/products/trazzle
	 * and you can see the log statements coming through the application and framework.
	 * 
	 * The LogMeister framework will cheerfully log to Firebug and several other logging consoles.
	 *  
	 * @author	Vish Vishvanath
	 * @since	03 May 2011
	 */
	public class MainContext extends BirdbaseContext
	{
		public function MainContext( contextView:Sprite )
		{
			super( contextView );
		}

		override public function startup():void
		{
			super.startup();
			
			LogMeister.addLogger( new TrazzleConnector( this.contextView.stage, "org.birdbase.demo", true ) );
			
			info();
			
			commandMap.mapEvent( BootManagement.START_APPLICATION, StartApplication, StateEvent, true );
		}
	}
}