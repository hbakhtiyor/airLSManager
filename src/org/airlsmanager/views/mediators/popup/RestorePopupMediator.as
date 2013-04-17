////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.mediators.popup
{
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.views.events.popup.RestorePopupEvent;
	import org.airlsmanager.views.interfaces.popup.IRestorePopup;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * RestorePopupMediator class 
	 */
	public class RestorePopupMediator extends BasePopupMediator
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
		public static const NAME:String = "RestorePopupMediator";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		public var defaultBackupFile:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * RestorePopupMediator 
		 */
		public function RestorePopupMediator(viewComponent:IRestorePopup, defaultBackupFile:String = null)
		{
			super(NAME, viewComponent);
			this.defaultBackupFile = defaultBackupFile;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * A getter for casting viewComponet to <code>IRestorePopup</code>.
		 * 
		 * @return Casts viewComponent to <code>IRestorePopup</code> and returns it. 
		 * 
		 */		
		public function get component() : IRestorePopup
		{
			return viewComponent as IRestorePopup;
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
			
			if(component)
			{
				component.addEventListener(RestorePopupEvent.RESTORE_NOW		, onRestoreNow);
				component.addEventListener(RestorePopupEvent.BROWSE_BACKUP		, onBrowseBackup);
				component.addEventListener(RestorePopupEvent.CANCEL_RESTORE		, onCancelRestore);
								
				if(defaultBackupFile && storeManagerProxy.setRestoreFile(defaultBackupFile))
				{
					component.selectedFileDate = storeManagerProxy.selectedFileDate;
					component.restoreEnabled = true;
				}

			}
		}
		
		/**
		 *  @inheritDoc
		 */			
		override public function onRemove():void
		{
			if( component )
			{
				component.removeEventListener(RestorePopupEvent.RESTORE_NOW		, onRestoreNow);
				component.removeEventListener(RestorePopupEvent.BROWSE_BACKUP	, onBrowseBackup);
				component.removeEventListener(RestorePopupEvent.CANCEL_RESTORE	, onCancelRestore);
			}

			super.onRemove();
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function listNotificationInterests():Array
		{
			var arr:Array = super.listNotificationInterests();
			arr.push(LsmNotifications.RESTORE_FILE_SELECTED);
			arr.push(LsmNotifications.RESTORE_FILE_CANCELED);
			
			return arr;
		}
		
		/**
		 *  @inheritDoc
		 */	
		override public function handleNotification(note:INotification):void
		{
			switch(note.getName())
			{
				case LsmNotifications.RESTORE_FILE_SELECTED:
					component.selectedFileDate = storeManagerProxy.selectedFileDate;
					component.restoreEnabled = true;
					break;
				case LsmNotifications.RESTORE_FILE_CANCELED:
					component.selectedFileDate = storeManagerProxy.selectedFileDate;
					component.restoreEnabled = false;
					break;
				default:
					super.handleNotification(note);				
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * Handler for <code>RestorePopupEvent.CANCEL_RESTORE</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */	
		private function onCancelRestore(event:RestorePopupEvent):void
		{
			if(storeManagerProxy.progressing)
				storeManagerProxy.cancel();
		}
		
		/**
		 * 
		 * Handler for <code>RestorePopupEvent.RESTORE_NOW</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		private function onRestoreNow(event:RestorePopupEvent):void
		{
			storeManagerProxy.restoreNow();
		}
		
		/**
		 * 
		 * Handler for <code>RestorePopupEvent.BROWSE_BACKUP</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		private function onBrowseBackup(event:RestorePopupEvent):void
		{
			storeManagerProxy.browseForOpen();
		}
	}
}