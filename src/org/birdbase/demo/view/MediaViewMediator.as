package org.birdbase.demo.view
{
	import com.epologee.navigator.NavigationState;
	import com.epologee.navigator.behaviors.IHasStateSwap;

	public class MediaViewMediator extends AbstractAssetLoadingMediator
	{
		[Inject]
		public var view:MediaView;
		
		public function MediaViewMediator()
		{
			super();
			
			_assetSet = "media";
		}

		override protected function ready():void
		{
			view.main();
			view.setMedia( assets );
		}
	}
}