////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.components.popup
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.IButton;
	
	import spark.components.WindowedApplication;
	
	import adobe.utils.ProductManager;
	
	import org.airlsmanager.views.events.popup.RestorePopupEvent;
	import org.airlsmanager.views.interfaces.popup.IRestorePopup;


	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the user selects the restore now button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.RestorePopupEvent.RESTORE_NOW
	 */
	[Event(name="restoreNow", type="org.airlsmanager.views.events.popup.RestorePopupEvent")]
	
	/**
	 *  Dispatched when the user selects the browse button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.RestorePopupEvent.BROWSE_BACKUP
	 */
	[Event(name="browseBackup", type="org.airlsmanager.views.events.popup.RestorePopupEvent")]		
	
	/**
	 *  Dispatched when the user selects the cancel restore button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.RestorePopupEvent.CANCEL_RESTORE
	 */
	[Event(name="cancelRestore", type="org.airlsmanager.views.events.popup.RestorePopupEvent")]
	
	/**
	 * RestorePopup class 
	 */
	public class RestorePopup extends BaseProgressPopup implements IRestorePopup
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
		//  restoreButton
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the restoreButton of the component. 
		 * 
		 */		
		public var restoreButton:IButton;
		
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
		//  cancelRestoreButton
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the cancelRestoreButton of the component. 
		 * 
		 */		
		public var cancelRestoreButton:IButton;
		
		//----------------------------------
		//  restartButton
		//----------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the restartButton of the component. 
		 * 
		 */		
		public var restartButton:IButton;


		
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
		 * RestorePopup 
		 */
		public function RestorePopup()
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
		private var _restoreEnabled:Boolean = false;
		
		/**
		 *  @private
		 */
		private var restoreEnabledChanged:Boolean = false;
		
		/**
		 *  Enable/disable backup button
		 */			
		public function get restoreEnabled():Boolean
		{
			return _restoreEnabled;
		}
		
		/**
		 *  @private
		 */
		public function set restoreEnabled(value:Boolean):void
		{
			if( _restoreEnabled !== value)
			{
				_restoreEnabled = value;
				restoreEnabledChanged = true;
				invalidateProperties();
			}
		}
		
		
		//----------------------------------
		//  backupEnabled
		//----------------------------------
		/**
		 *  @private
		 */		
		private var _selectedFileDate:String;
		
		[Bindable(event="selectedFileDateChange")]
		public function get selectedFileDate():String
		{
			return _selectedFileDate;
		}
		
		/**
		 *  @private
		 */
		public function set selectedFileDate(value:String):void
		{
			if( _selectedFileDate !== value)
			{
				_selectedFileDate = value;
				dispatchEvent(new Event("selectedFileDateChange"));
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
			
			if(instance == restoreButton)
			{
				restoreButton.addEventListener(MouseEvent.CLICK, onRestoreButtonClicked);
				
				restoreButton.enabled = _restoreEnabled;
			}
			else if(instance == browseButton)
			{
				browseButton.addEventListener(MouseEvent.CLICK, onBrowseButtonClicked);
			}
			else if(instance == cancelButton)
			{
				cancelButton.addEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			else if(instance == cancelRestoreButton)
			{
				cancelRestoreButton.addEventListener(MouseEvent.CLICK, onCancelButtonClicked);
			}
			else if(instance == restartButton)
			{
				restartButton.addEventListener(MouseEvent.CLICK, onRestartButtonClicked);
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override protected function partRemoved(partName:String, instance:Object):void
		{
			if(instance == restoreButton)
			{
				restoreButton.removeEventListener(MouseEvent.CLICK, onRestoreButtonClicked);
			}
			else if(instance == browseButton)
			{
				browseButton.removeEventListener(MouseEvent.CLICK, onBrowseButtonClicked);
			}
			else if(instance == cancelButton)
			{
				cancelButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			else if(instance == cancelRestoreButton)
			{
				cancelRestoreButton.removeEventListener(MouseEvent.CLICK, onCancelButtonClicked);
			}
			else if(instance == restartButton)
			{
				restartButton.removeEventListener(MouseEvent.CLICK, onRestartButtonClicked);
			}
			
			super.partRemoved(partName, instance);
		}
		
		/**
		 *  @inheritDoc
		 */
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(restoreButton && restoreEnabledChanged)
			{
				restoreButton.enabled = _restoreEnabled;
				restoreEnabledChanged = false;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */		
		override protected function onCloseButtonClicked(event:MouseEvent):void
		{
			if(isSuccessful)
				onRestartButtonClicked(null);
			else
				super.onCloseButtonClicked(event)
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
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by restoreButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by restoreButton.
		 * 
		 */		
		private function onRestoreButtonClicked(event:MouseEvent):void
		{
			setProgress(0, 100);
			
			isProcess = true;
			dispatchEvent(new RestorePopupEvent(RestorePopupEvent.RESTORE_NOW));
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by restartButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by restartButton.
		 * 
		 */		
		private function onRestartButtonClicked(event:MouseEvent):void
		{
			var app:WindowedApplication = FlexGlobals.topLevelApplication as WindowedApplication;
			
			var manager:ProductManager = new ProductManager("airappinstaller");
			manager.launch("-launch "+app.nativeApplication.applicationID+" "+app.nativeApplication.publisherID);
			app.close();			
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by cancelRestoreButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by cancelRestoreButton.
		 * 
		 */		
		private function onCancelButtonClicked(event:MouseEvent):void
		{
			isProcess = false;
			dispatchEvent(new RestorePopupEvent(RestorePopupEvent.CANCEL_RESTORE));
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
			dispatchEvent(new RestorePopupEvent(RestorePopupEvent.BROWSE_BACKUP));
		}
	}
}