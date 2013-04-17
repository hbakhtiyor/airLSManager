////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.components.popup
{
	import flash.events.MouseEvent;
	
	import mx.core.IButton;
	import mx.events.ValidationResultEvent;
	import mx.validators.IValidator;
	
	import spark.components.TextInput;
	
	import org.airlsmanager.views.events.popup.BackupPopupEvent;
	import org.airlsmanager.views.interfaces.popup.IBackupPopup;
	

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the user selects the backup now button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.BackupPopupEvent.BACKUP_NOW
	 */
	[Event(name="backupNow", type="org.airlsmanager.views.events.popup.BackupPopupEvent")]
	
	/**
	 *  Dispatched when the user selects the browse button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.BackupPopupEvent.BROWSE_DIR
	 */
	[Event(name="browseDir", type="org.airlsmanager.views.events.popup.BackupPopupEvent")]		
	
	/**
	 *  Dispatched when the user selects the cancel backup button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.BackupPopupEvent.CANCEL_BACKUP
	 */
	[Event(name="cancelBackup", type="org.airlsmanager.views.events.popup.BackupPopupEvent")]	
	
	
	/**
	 * BackupPopup class 
	 */
	public class BackupPopup extends BaseProgressPopup implements IBackupPopup
	{
		
		//--------------------------------------------------------------------------
		//
		//  SkinParts
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  browseButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the browseButton of the component. 
		 * 
		 */		
		public var browseButton:IButton;
		
		//----------------------------------
		//  backupButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the backupButton of the component. 
		 * 
		 */		
		public var backupButton:IButton;
		
		//----------------------------------
		//  cancelButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the cancelButton of the component. 
		 * 
		 */		
		public var cancelButton:IButton;
		
		//----------------------------------
		//  cancelBackupButton
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the cancelBackupButton of the component. 
		 * 
		 */		
		public var cancelBackupButton:IButton;
		
		//----------------------------------
		//  dValidator
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the dValidator of the component. 
		 * 
		 */		
		public var dValidator:IValidator;
		
		//----------------------------------
		//  pathFileInput
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the pathFileInput of the component. 
		 * 
		 */		
		public var pathFileInput:TextInput;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		
		
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
		 * BackupPopup 
		 */
		public function BackupPopup()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  backupEnabled
		//----------------------------------
		/**
		 *  @private
		 */	
		private var _backupEnabled:Boolean = false;		
		
		/**
		 *  Enable/disable backup button
		 */	
		private var backupEnabledChanged:Boolean = false;
		
		/**
		 *  @private
		 */			
		public function get backupEnabled():Boolean
		{
			return _backupEnabled;
		}
		
		
		/**
		 *  @private
		 */			
		public function set backupEnabled(value:Boolean):void
		{
			if( _backupEnabled !== value)
			{
				_backupEnabled = value;
				backupEnabledChanged = true;
				invalidateProperties();
			}
		}
		
		//----------------------------------
		//  backupDirectory
		//----------------------------------
		/**
		 *  @private
		 */		
		private var _backupDirectory:String;
		
		/**
		 *  @private
		 */	
		private var backupDirectoryChanged:Boolean = false;
		
		/**
		 *  Default backup directory
		 */		
		public function get backupDirectory():String
		{
			return _backupDirectory;
		}
		
		/**
		 *  @private
		 */		
		public function set backupDirectory(value:String):void
		{
			if( _backupDirectory !== value)
			{
				_backupDirectory = value;
				backupDirectoryChanged = true;
				invalidateProperties();
			}
		}	

		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if(instance == backupButton)
			{
				backupButton.addEventListener(MouseEvent.CLICK, onBackupButtonClicked);
				
				backupButton.enabled = _backupEnabled;
			}
			else if(instance == browseButton)
			{
				browseButton.addEventListener(MouseEvent.CLICK, onBrowseButtonClicked);
			}
			else if(instance == cancelButton)
			{
				cancelButton.addEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			else if(instance == cancelBackupButton)
			{
				cancelBackupButton.addEventListener(MouseEvent.CLICK, onCancelButtonClicked);
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override protected function partRemoved(partName:String, instance:Object):void
		{
			if(instance == backupButton)
			{
				backupButton.removeEventListener(MouseEvent.CLICK, onBackupButtonClicked);
			}
			else if(instance == browseButton)
			{
				browseButton.removeEventListener(MouseEvent.CLICK, onBrowseButtonClicked);
			}
			else if(instance == cancelButton)
			{
				cancelButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			else if(instance == cancelBackupButton)
			{
				cancelBackupButton.removeEventListener(MouseEvent.CLICK, onCancelButtonClicked);
			}
			
			super.partRemoved(partName, instance);
		}
		
		/**
		 *  @inheritDoc
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(backupDirectoryChanged && pathFileInput)
			{
				pathFileInput.text = _backupDirectory;
				backupDirectoryChanged = false;
			}
			if(backupEnabledChanged && backupButton)
			{
				backupButton.enabled = _backupEnabled;
				backupEnabledChanged = false;
			}
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
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by backupButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by backupButton.
		 * 
		 */		
		private function onBackupButtonClicked(event:MouseEvent):void
		{
			var resultEvent:ValidationResultEvent = dValidator.validate();
			if(!resultEvent.results || resultEvent.results.length == 0)
			{
				setProgress(0, 100);
				
				isProcess = true;
				dispatchEvent(new BackupPopupEvent(BackupPopupEvent.BACKUP_NOW));
			}
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by cancelBackupButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by cancelBackupButton.
		 * 
		 */		
		private function onCancelButtonClicked(event:MouseEvent):void
		{
			isProcess = false;
			dispatchEvent(new BackupPopupEvent(BackupPopupEvent.CANCEL_BACKUP));
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by browseButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by browseButton.
		 * 
		 */		
		private function onBrowseButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new BackupPopupEvent(BackupPopupEvent.BROWSE_DIR));
		}		
	}
}