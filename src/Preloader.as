package  
{
	
	import flash.display.*;
	import flash.events.Event;
	import flash.filters.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import org.birdbase.support.loading.*;
	
	/**
	 * Application-specific Preloader class which loads the main application.
	 * 
	 * @author	Vish Vishvanath
	 * @author	Mischa Williamson
	 * @since	8 February 2011
	 */
	public class Preloader extends MovieClip implements IPreloaderView
	{
		/**
		 * 	The alpha value for the background bar code.
		 */
		public static const DEFAULT_ALPHA:Number = .15;
		
		private var _app:Object;
		private var _container:Sprite;
		private var _graphic:Sprite;
		private var _drawing:Sprite;
		private var _mask:Bitmap;
		private var _width:Number = NaN;
		private var _height:Number = NaN;
		
		private var _timeout:uint;
		
		public function Preloader()
		{
			stop();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		/**
		 * Called by the Main entry point. We wait a short while before cleaning up the preloader. 
		 */
		public function complete():void
		{
			_timeout = setTimeout( cleanup, 750 );
		}
		
		/**
		 * 	Tints this colour.
		 * 	
		 * 	@param color The colour to use for the tint.
		 * 	@param amount The amount of tint to apply in the range
		 * 	0 to 1.
		 */
		private function tint(
			target:DisplayObject,
			color:uint = NaN,
			amount:Number = 1 ):ColorTransform
		{
			var transform:ColorTransform = new ColorTransform();
			
			//invert the amount
			var inverted:Number = ( 1 - amount );
			var tintRed:Number = Math.round( amount * getRed( color ) );
			var tintGreen:Number = Math.round( amount * getGreen( color ) );
			var tintBlue:Number = Math.round( amount * getBlue( color ) );
			
			transform.redMultiplier = transform.greenMultiplier = transform.blueMultiplier = inverted;
			transform.alphaMultiplier = 1;
			transform.redOffset = tintRed;
			transform.greenOffset = tintGreen;
			transform.blueOffset = tintBlue;
			transform.alphaOffset = 0;
			
			target.transform.colorTransform = transform;
			
			return transform;
		}
		
		/**
		 * 	Gets the red part of a colour.
		 * 
		 * 	@param color The decimal colour.
		 * 
		 * 	@return The red part of the colour.
		 */
		private function getRed( color:uint = 0 ):uint
		{
			return ( ( color >> 16 ) & 0xFF );
		}
		
		/**
		 * 	Gets the green part of a colour.
		 * 
		 * 	@param color The decimal colour.
		 * 
		 * 	@return The green part of the colour.
		 */
		private function getGreen( color:uint = 0 ):uint
		{
			return ( ( color >> 8 ) & 0xFF );
		}
		
		/**
		 * 	Gets the blue part of a colour.
		 * 
		 * 	@param color The decimal colour.
		 * 
		 * 	@return The blue part of the colour.
		 */
		private function getBlue( color:uint = 0 ):uint
		{
			return ( color & 0xFF );
		}	
		
		public function setColour( colour:Number ):void
		{
			tint( _mask, colour );	
		}	
		
		private function getBitmapMask( target:DisplayObject ):Bitmap
		{
			var data:BitmapData = new BitmapData( _width, _height, true, 0x00000000 );
			data.draw( target, null );
			return new Bitmap( data );
		}
		
		protected function onAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_container = new Sprite();
			addChild( _container );
			
			_graphic = new Sprite();
			_graphic.graphics.beginFill( 0xFFFFFF );
			_graphic.graphics.drawRect( 10, 10, 300, 100 );
			_graphic.graphics.endFill();
			_graphic.alpha = DEFAULT_ALPHA;
			_width = _graphic.width;
			_height = _graphic.height;
			_container.addChild( _graphic );
			
			_drawing = new Sprite();
			_container.addChild( _drawing );
			
			_mask = getBitmapMask( _graphic );
			_container.addChild( _mask );
			
			setColour( 0xaf0303 );
			
			_mask.mask = _drawing;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( Event.RESIZE, resized );
			
			resized();
		}
		
		private function resized( e:Event = null ):void
		{
			_container.x = stage.stageWidth * .5 - _container.width * .5;
			_container.y = stage.stageHeight * .5 - _container.height * .5;	
		}
		
		protected function onEnterFrame( e:Event ):void
		{
			var bl:Number = root.loaderInfo.bytesLoaded;
			var bt:Number = root.loaderInfo.bytesTotal;
			
			if( root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal )
			{
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				nextFrame();
				init();
			}
			else
			{
				var normalized:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				drawPreload( normalized );
			}
		}
		
		public function drawPreload( normalized:Number ):void
		{
			if( _drawing )
			{
				var g:Graphics = _drawing.graphics;
				g.clear();
				g.beginFill( 0x0000ff, 1 );
				g.drawRect( 0, 0, _width * normalized, _height );
				g.endFill();
			}
		}
		
		protected function init():void
		{
			var mainClass:Class = Class( getDefinitionByName( "Main" ) );
			
			//ensure the code preload is fully drawn
			drawPreload( 1 );
			if( mainClass )
			{
				_app = new mainClass();
				addChild( _app as DisplayObject );
				IHasSteppedPreloader( _app ).codePreloadComplete( this );
			}
		}
		
		private function cleanup():void
		{
			clearTimeout( _timeout );
			//cleanup preload stuff
			try
			{
				stage.removeEventListener( Event.RESIZE, resized );
				_container.removeChild( _graphic );
				_container.removeChild( _drawing );
				_container.removeChild( _mask );
				removeChild( _container );	
				_app = null;
				_graphic = null;
				_drawing = null;
				_mask = null;
				_container = null;
			}
			catch( e:Error )
			{
				trace( e );
			}
		}
	}
}