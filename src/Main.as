package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.birdbase.demo.MainContext;
	import org.birdbase.framework.BirdbaseContext;
	import org.birdbase.support.loading.IHasSteppedPreloader;
	import org.birdbase.support.loading.IPreloaderView;
	import org.birdbase.support.loading.StepEvent;
	
	/**
	 * This Main class serves as the root entry point to your Birdbase application. It attaches to a Preloader Factory
	 * class, as you can see, and provides a basic stepped preload display.
	 * 
	 * The Birdbase bootstrap process takes in a number of steps, from loading in the main classes to then loading in
	 * a configuration, assets and fonts, and then instantiating the application.
	 * 
	 * So the preload is broken initially, into two halves.
	 * 
	 * 1. Load Application code.
	 * 
	 * 2. Load Application data.
	 * 
	 * The first half is easy. We know how large the main.swf is, so we show a progress bar from 0 to 100% for that.
	 * 
	 * The second half is not so easy, because we don't know what we're loading in advance - it's all dynamically
	 * decided from the configuration. So we break this half down into some steps.
	 * 
	 * We can break the second half down into the total number of things it has to load, and then we can tell the 
	 * progress bar that it is evenly divided by this total. The progress bar will move more smoothly if there are more
	 * assets to load, as this gives it more steps.
	 * 
	 * The code that broadcasts the stepped loading events is in BirdbaseContext
	 * 
	 * Once Birdbase announces that it's done loading, the MainContext method kicks off the StartApplication command.
	 * 
	 * @author	Vish Vishvanath
	 */

	[SWF(width="800", height="600", frameRate="31", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite implements IHasSteppedPreloader
	{
		public var container:Sprite = new Sprite();
		protected var _context:MainContext;
		protected var _preloader:IPreloaderView;
		private var _total:uint;
		private var _current:Number = 0;
		private var _inc:Number;
		
		public function Main()
		{
			super();
		}
		
		/**
		 * This is handling the load completion of the SWF file. The main codebase.
		 *  
		 * @param preloader
		 */
		public function codePreloadComplete( preloader:IPreloaderView ):void
		{
			if( preloader === null )
			{
				throw new Error( "No preloader specified." );
			}
			
			if( !stage )
			{
				throw new Error( "The main application is not on the display list." );
			}
			
			_preloader = preloader;
			Object( _preloader ).setColour( 0xffffff );
			//clear the preload
			Object( _preloader ).drawPreload( 0 );
			initializeContext();
		}
		
		/**
		 * Now we can start the Context loading and handle the loading events out here with the Preloader progress.
		 */
		protected function initializeContext():void
		{
			this.addChild( container );
			_context = new MainContext( container );
			_context.addEventListener( StepEvent.NUMBER_STEPS, stepsAvailable );
			_context.addEventListener( StepEvent.STEP, onStepComplete );
			_context.addEventListener( BirdbaseContext.LOAD_COMPLETED, onLoadCompleted );
			_context.startup();
		}
		
		/**
		 * We need to know how many steps are left.
		 *  
		 * @param e
		 */
		private function stepsAvailable( e:StepEvent ):void
		{
			//the +2 accounts for the font loading step and ensures the steps are correct
			_total = e.totalSteps + 1;
			
			_inc = 1 / _total;
			
			//increment here as the fonts have been loaded
			increment();
		}
		
		private function increment():void
		{
			_current++;
			var normalized:Number = _inc * _current;
			Object( _preloader ).drawPreload( normalized );
		}
		
		private function onStepComplete( e:StepEvent ):void
		{	
			increment();
		}
		
		private function onLoadCompleted( e:Event ):void
		{
			try
			{
				_preloader.complete();
			}
			catch( e:Error )
			{
				error( e );
			}
		}
	}
}