////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.views.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	
	import spark.components.Button;
	import spark.components.supportClasses.SkinnableComponent;
	
	import org.airlsmanager.demo.views.events.ApplicationEvent;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the user selects the backup button.
	 *
	 *  @eventType org.airlsmanager.demo.views.events.ApplicationEvent.DISPLAY_BACKUP_POPUP
	 */
	[Event(name="displayBackupPopup", type="org.airlsmanager.demo.views.events.ApplicationEvent")]
	
	/**
	 *  Dispatched when the user selects the restore button.
	 *
	 *  @eventType org.airlsmanager.demo.views.events.ApplicationEvent.DISPLAY_RESTORE_POPUP
	 */
	[Event(name="displayRestorePopup", type="org.airlsmanager.demo.views.events.ApplicationEvent")]	
	
	/**
	 *  Dispatched when the user selects the write data button.
	 *
	 *  @eventType org.airlsmanager.demo.views.events.ApplicationEvent.WRITE_SAMPLE_DATA
	 */
	[Event(name="writeSampleData", type="org.airlsmanager.demo.views.events.ApplicationEvent")]	
	
	
	/**
	 * ContentHolder class 
	 */
	public class ContentHolder extends SkinnableComponent
	{
		
		//--------------------------------------------------------------------------
		//
		//  SkinParts
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  displayBackupButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the displayBackupButton of the component. 
		 * 
		 */	
		public var displayBackupButton:Button;
		
		
		//----------------------------------
		//  displayRestoreButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the displayRestoreButton of the component. 
		 * 
		 */	
		public var displayRestoreButton:Button;
		
		//----------------------------------
		//  writeSampleDataButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the writeSampleDataButton of the component. 
		 * 
		 */	
		public var writeSampleDataButton:Button;
		
		//----------------------------------
		//  openStorageButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the openStorageButton of the component. 
		 * 
		 */	
		public var openStorageButton:Button;
		
		
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
		 * ContentHolder 
		 */
		public function ContentHolder()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  generatedDate
		//----------------------------------
		/**
		 *  @private
		 */
		private var _generatedDate:Date;

		[Bindable(event="generatedDateChange")]
		/**
		 *  Last generated date 
		 */		
		public function get generatedDate():Date
		{
			return _generatedDate;
		}

		/**
		 * @private
		 */
		public function set generatedDate(value:Date):void
		{
			if( _generatedDate !== value)
			{
				_generatedDate = value;
				dispatchEvent(new Event("generatedDateChange"));
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
			
			if(instance == displayBackupButton)
			{
				displayBackupButton.addEventListener(MouseEvent.CLICK, onDisplayBackupButtonClicked);
			}
			else if(instance == displayRestoreButton)
			{
				displayRestoreButton.addEventListener(MouseEvent.CLICK, onDisplayRestoreButtonClicked);
			}			
			else if(instance == writeSampleDataButton)
			{
				writeSampleDataButton.addEventListener(MouseEvent.CLICK, onWriteSampleDataButtonClicked);
			}			
			else if(instance == openStorageButton)
			{
				openStorageButton.addEventListener(MouseEvent.CLICK, onOpenStorageButtonClicked);
			}			
		}
		
		/**
		 *  @inheritDoc
		 */		
		override protected function partRemoved(partName:String, instance:Object):void
		{	
			if(instance == displayBackupButton)
			{
				displayBackupButton.removeEventListener(MouseEvent.CLICK, onDisplayBackupButtonClicked);
			}
			else if(instance == displayRestoreButton)
			{
				displayRestoreButton.removeEventListener(MouseEvent.CLICK, onDisplayRestoreButtonClicked);
			}			
			else if(instance == writeSampleDataButton)
			{
				writeSampleDataButton.removeEventListener(MouseEvent.CLICK, onWriteSampleDataButtonClicked);
			}
			else if(instance == openStorageButton)
			{
				openStorageButton.removeEventListener(MouseEvent.CLICK, onOpenStorageButtonClicked);
			}	
			
			super.partRemoved(partName, instance);
		}
		
		/**
		 *  @inheritDoc
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			
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
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by writeSampleDataButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by writeSampleDataButton.
		 * 
		 */			
		private function onWriteSampleDataButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new ApplicationEvent(ApplicationEvent.WRITE_SAMPLE_DATA));			
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by displayRestoreButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by displayRestoreButton.
		 * 
		 */			
		private function onDisplayRestoreButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new ApplicationEvent(ApplicationEvent.DISPLAY_RESTORE_POPUP));			
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by displayBackupButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by displayBackupButton.
		 * 
		 */			
		private function onDisplayBackupButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new ApplicationEvent(ApplicationEvent.DISPLAY_BACKUP_POPUP));
		}
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by openStorageButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by openStorageButton.
		 * 
		 */		
		private function onOpenStorageButtonClicked(event:MouseEvent):void
		{
			try
			{
				File.applicationStorageDirectory.openWithDefaultApplication();
			}
			catch(err:Error)
			{
				Alert.show(err.message);
			}
		}
	}
}