package org.birdbase.demo.view
{
	import com.gskinner.motion.GTween;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * This is a sample abstract mediator that simply implements two methods used by AS3-Navigator.
	 * 
	 * The transitionIn method is called by the Navigator when showing a view/mediator and vice versa for the
	 * transitionOut.
	 * 
	 * I have included the GTween library to add basic fade-ins and -outs to illustrate how the transition interface
	 * works. Once you have finished your transition, you simply call the callOnComplete function. Either as a callback
	 * from a tween as below, or just callOnComplete.call()
	 * 
	 * @author	Vish Vishvanath
	 * @since	03 May 2011
	 */
	public class AbstractMediator extends Mediator implements IBirdbaseMediator
	{
		public function AbstractMediator()
		{
			super();
		}
		
		public function transitionIn(callOnComplete:Function):void
		{
			this.viewComponent.alpha = 0;
			
			var tween:GTween = new GTween( this.viewComponent, 1, { alpha: 1 } );
			tween.onComplete = callOnComplete;
		}
		
		public function transitionOut(callOnComplete:Function):void
		{
			var tween:GTween = new GTween( this.viewComponent, 1, { alpha: 0 } );
			tween.onComplete = callOnComplete;
		}
	}
}