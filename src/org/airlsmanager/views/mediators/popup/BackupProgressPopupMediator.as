////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.mediators.popup
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import spark.components.WindowedApplication;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.views.interfaces.popup.IBaseProgressPopup;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * BackupProgressPopupMediator class 
	 */
	public class BackupProgressPopupMediator extends BasePopupMediator
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
		public static const NAME:String = "BackupProgressPopupMediator";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * BackupProgressPopupMediator 
		 */
		public function BackupProgressPopupMediator(viewComponent:IBaseProgressPopup)
		{
			super(NAME, viewComponent);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		

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
			
			if(popup)
			{
				popup.isProcess = true;
			}
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function handleNotification(note:INotification):void
		{
			super.handleNotification(note);
			
			switch(note.getName())
			{
				case LsmNotifications.BACKUP_ERROR:
				case LsmNotifications.BACKUP_SUCCESSFULLY:
					startClosingApplication();
					break;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods : private
		//
		//--------------------------------------------------------------------------
		/**
		 *  @private
		 */		
		private function startClosingApplication():void
		{
			var restartTimer:Timer = new Timer(1000, 1);
			restartTimer.addEventListener(TimerEvent.TIMER, onRestartTimer);
			restartTimer.start();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 *  Handler for <code>TimerEvent.TIMER</code> event dispatched by timer.
		 * 
		 *  @param event The event dispatched by timer.
		 * 
		 */		
		private function onRestartTimer(event:TimerEvent):void
		{
			var restartTimer:Timer = event.target as Timer;
			restartTimer.removeEventListener(TimerEvent.TIMER, onRestartTimer);
			
			if(topApplication is WindowedApplication)
				(topApplication as WindowedApplication).close();
		}
	}
}