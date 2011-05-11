package org.birdbase.demo.view
{
	import flash.utils.Dictionary;
	
	import org.as3commons.collections.Map;
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.signals.*;
	import org.birdbase.framework.model.Settings;
	
	/**
	 * This is a sample abstract mediator to show you how to load assets on demand.
	 * 
	 * Any mediator that extends this should supply an assetSet string that refers to a group of assets in the 
	 * configuration.yml file.
	 * 
	 * The onRegister method will pull out this dictionary and load all the files referred to.
	 * 
	 * Once the assets are loaded, the init() method loops through them and sets a dynamic reference to each asset
	 * in the mediator. That is why these classes are dynamic.
	 * 
	 * ready() is fired and your mediator has all the assets it needs to carry on. They should be sent to the view
	 * and used there. Remember to check for null pointers if assets fail to load.
	 * 
	 * @author	Vish Vishvanath
	 * @date	03 May 2011
	 * 
	 */
	public class AbstractAssetLoadingMediator extends AbstractMediator
	{
		[Inject]
		public var settings:Settings;
		
		[Inject(name="loaded")]
		public var assetLoader:IAssetLoader;
		
		public var assetList:Dictionary;
		
		protected var _assets:Map = new Map();
		
		/**
		 * Set this variable in all your mediators that
		 * you wish to dynamically populate with assets
		 * listed in the configuration under this key.
		 */
		protected var _assetSet:String = "global";
		
		public function AbstractAssetLoadingMediator()
		{
			super();
		}

		/**
		 * Fetches the asset list from the configuration for this particular mediator/view,
		 * sends this as a payload to the AssetLoader and triggers init() once all the assets are loaded.
		 */
		override public function onRegister():void
		{
			debug();
			try
			{
				var list:Dictionary = settings.getSetting( "view_assets" );
				
				debug( "Loading assets for " + this._assetSet );
				
				assetList = list[ _assetSet ];
				
				if( list[ _assetSet ] )
				{
					for( var a:String in assetList )
					{
						info( "Loading " + assetList[ a ] );
						assetLoader.addLazy( a, settings.getSetting( "base" ) + assetList[ a ] );
					}
					
					assetLoader.onError.add( onError );
					assetLoader.onComplete.add( init );
					assetLoader.start();
				}
				else
				{
					init( null, null );
				}
			}
			catch( e:Error )
			{
				fatal( e );
				throw( e );
			}
		}

		/**
		 * Override in the subclass if error handling required.
		 *  
		 * @param signal
		 */
		protected function onError( signal:ErrorSignal ):void
		{
			error( signal.message );
			throw new Error( signal.message );
		}
		
		/**
		 * Triggered by a successful load of the required assets for the mediator/view.
		 *  
		 * @param signal
		 * @param data
		 */
		public function init( signal:LoaderSignal, data:* ):void
		{
			assetLoader.onComplete.remove( init );
			for( var a:String in assetList )
			{
				_assets.add( a, assetLoader.getAsset( a ) );
			}
			ready();
		}
		
		protected function ready():void
		{
			warn( "Extend in concrete classes" );
		}
		
		public function get assets():Map
		{
			return _assets;
		}
	}
}