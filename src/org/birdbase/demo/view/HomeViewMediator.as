package org.birdbase.demo.view
{
	public class HomeViewMediator extends AbstractAssetLoadingMediator
	{
		[Inject]
		public var view:HomeView;
		
		public function HomeViewMediator()
		{
			super();
			
			_assetSet = "home";
		}
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override protected function ready():void
		{
			debug();
		}
	}
}