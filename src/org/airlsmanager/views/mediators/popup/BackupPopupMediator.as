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
	import org.airlsmanager.helpers.ApplicationStorageDirectory;
	import org.airlsmanager.views.events.popup.BackupPopupEvent;
	import org.airlsmanager.views.events.popup.PopupEvent;
	import org.airlsmanager.views.interfaces.popup.IBackupPopup;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * BackupPopupMediator class 
	 */
	public class BackupPopupMediator extends BasePopupMediator
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
		public static const NAME:String = "BackupPopupMediator";
		
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
		 * BackupPopupMediator 
		 */
		public function BackupPopupMediator(viewComponent:IBackupPopup)
		{
			super(NAME, viewComponent);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * A getter for casting viewComponet to <code>IBackupPopup</code>.
		 * 
		 * @return Casts viewComponent to <code>IBackupPopup</code> and returns it. 
		 * 
		 */		
		public function get component() : IBackupPopup
		{
			return viewComponent as IBackupPopup;
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
			
			if( component )
			{
				component.addEventListener(BackupPopupEvent.BACKUP_NOW		, onBackupNow);
				component.addEventListener(BackupPopupEvent.BROWSE_DIR		, onBrowseDir);
				component.addEventListener(BackupPopupEvent.CANCEL_BACKUP	, onCancelBackup);
				
				component.backupDirectory 	= storeManagerProxy.defaultBackupDirectory;
				component.backupEnabled 	= !ApplicationStorageDirectory.isEmpty();
			}
		}
		
		/**
		 *  @inheritDoc
		 */	
		override public function onRemove():void
		{
			if( component )
			{
				component.removeEventListener(BackupPopupEvent.BACKUP_NOW		, onBackupNow);
				component.removeEventListener(BackupPopupEvent.BROWSE_DIR		, onBrowseDir);
				component.removeEventListener(BackupPopupEvent.CANCEL_BACKUP	, onCancelBackup);
			}
			
			super.onRemove();
		}
		
		/**
		 *  @inheritDoc
		 */	
		override public function listNotificationInterests():Array
		{
			var arr:Array = super.listNotificationInterests();
			arr.push(LsmNotifications.BACKUP_FILE_SELECTED);
			
			return arr;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function handleNotification(note:INotification):void
		{
			switch(note.getName())
			{
				case LsmNotifications.BACKUP_FILE_SELECTED:
					component.backupDirectory = storeManagerProxy.backupDirectory;
					component.backupEnabled = true;
					break;
				default:
					super.handleNotification(note);
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override protected function onClosePopup(event:PopupEvent):void
		{
			if(storeManagerProxy.progressing)
				localStoreProxy.observeBackup();
			
			super.onClosePopup(event)
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *  Handler for <code>BackupPopupEvent.CANCEL_BACKUP</code> event dispatched by view.
		 * 
		 *  @param event The event dispatched by view.
		 * 
		 */
		private function onCancelBackup(event:BackupPopupEvent):void
		{
			if(storeManagerProxy.progressing)
				storeManagerProxy.cancel();
		}
		
		/**
		 * 
		 *  Handler for <code>BackupPopupEvent.BACKUP_NOW</code> event dispatched by view.
		 * 
		 *  @param event The event dispatched by view.
		 * 
		 */
		private function onBackupNow(event:BackupPopupEvent):void
		{
			storeManagerProxy.backupNow();
		}
		
		/**
		 * 
		 *  Handler for <code>BackupPopupEvent.BROWSE_DIR</code> event dispatched by view.
		 * 
		 *  @param event The event dispatched by view.
		 * 
		 */
		private function onBrowseDir(event:BackupPopupEvent):void
		{
			storeManagerProxy.browseForSave();
		}
	}
}