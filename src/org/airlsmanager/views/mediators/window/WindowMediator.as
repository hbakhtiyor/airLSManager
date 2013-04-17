////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.mediators.window
{
	import flash.events.Event;
	
	import org.airlsmanager.views.windows.HelpWindow;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * WindowMediator help and help windows of application  
	 */
	public class WindowMediator extends Mediator
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * Constant for mediator's name.
		 * 
		 */		
		public static const NAME:String = "WindowMediator";
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * CourseProxy 
		 */
		public function WindowMediator()
		{
			super(NAME);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  topApplication
		//---------------------------------- 
		/**
		 * Help Window
		 */
		private var _helpWindow:HelpWindow;
		
		public function set helpWindow(value:HelpWindow):void
		{
			if( value )
			{
				_helpWindow = value;
				_helpWindow.addEventListener(Event.CLOSE, onHelpWindowClose);
			}
		}
		
		/**
		 *  @private
		 */
		public function get helpWindow():HelpWindow
		{
			return _helpWindow;
		}
		

		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function onRemove():void
		{
			if(_helpWindow)
			{
				_helpWindow.removeEventListener(Event.CLOSE, onHelpWindowClose);
				
				if(!_helpWindow.closed) _helpWindow.close();
				_helpWindow = null;				
			}
			
			super.onRemove();	
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *  Handler for <code>Event.CLOSE</code> event dispatched by helpWindow.
		 * 
		 *  @param event The event dispatched by helpWindow.
		 * 
		 */
		private function onHelpWindowClose(event:Event):void
		{
			facade.removeMediator(NAME);
		}
	}
}