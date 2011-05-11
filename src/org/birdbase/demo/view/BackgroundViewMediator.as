package org.birdbase.demo.view
{
	/**
	 * A sample class for the background which is mapped to all URLs in the Navigator. This is an example of a view
	 * that needs to be permanently visible.
	 * 
	 * The URL mapping is seen as "/*" in the configuration.
	 *  
	 * @author	Vish Vishvanath
	 * @date	03 May 2011
	 */
	public class BackgroundViewMediator extends AbstractAssetLoadingMediator
	{
		[Inject]
		public var view:BackgroundView;
		
		public function BackgroundViewMediator()
		{
			super();

			// The superclass will load any assets found under this list name in the configuration.
			_assetSet = "background";
		}
		
		override protected function ready():void
		{
			view.main();
			view.setMedia( assets );
		}
	}
}