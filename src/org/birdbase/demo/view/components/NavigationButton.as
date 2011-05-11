package org.birdbase.demo.view.components
{
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	
	public class NavigationButton extends PushButton
	{
		protected var _destination:String;
		
		public function NavigationButton( parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, label:String = "", defaultHandler:Function = null)
		{
			super( parent, xpos, ypos, label, defaultHandler );
		}
		
		public function get destination():String
		{
			return _destination;
		}
		
		public function set destination( value:String ):void
		{
			_destination = value;
		}
	}
}