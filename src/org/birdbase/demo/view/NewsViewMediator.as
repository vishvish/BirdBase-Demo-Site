package org.birdbase.demo.view
{
	public class NewsViewMediator extends AbstractAssetLoadingMediator
	{
		[Inject]
		public var view:NewsView;
		
		public function NewsViewMediator()
		{
			super();
			
			_assetSet = "news";
		}

		override protected function ready():void
		{
			view.main();
			view.setMedia( assets );
		}
	}
}