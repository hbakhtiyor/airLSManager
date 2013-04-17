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
	
	import mx.events.FlexEvent;
	
	import flexunit.framework.Assert;
	
	import org.airlsmanager.views.components.popup.BackupPopup;
	import org.airlsmanager.views.events.popup.BackupPopupEvent;
	import org.airlsmanager.views.skins.popup.BackupPopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	/**
	 * BackupPopupTest class 
	 */
	public class BackupPopupTest
	{

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of component instance.
		 */
		private var component:BackupPopup;
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Creates all needed objects for the tests.
		 */ 
		[Before(async, ui)]
		public function before():void
		{
			component = new BackupPopup();
			component.setStyle("skinClass", BackupPopupSkin);
			Async.proceedOnEvent(this, component, FlexEvent.CREATION_COMPLETE, 1000);
			UIImpersonator.addChild(component);
			component.validateNow();			
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After(async, ui)]
		public function after():void
		{
			UIImpersonator.removeChild(component);
			component = null;
		}
		
		/**
		 * Test backupDirectory property of the component.
		 */ 
		[Test(async, ui, timeout="4000")]
		public function testBackupDirectory():void
		{
			var backupDirectory:String = "/home/hacker/Documents/My Backups";
			var asyncHandler:Function = Async.asyncHandler(this, onPathFileInputUpdateCompleted, 4000, backupDirectory);

			component.pathFileInput.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler, false, 0, true);
			component.backupDirectory = backupDirectory;
			component.validateNow();
		}
		
		/**
		 * Test that <code>BackupPopupEvent.BROWSE_DIR</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testBrowseButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onBrowseButtonClicked, 4000, BackupPopupEvent.BROWSE_DIR);
			component.addEventListener(BackupPopupEvent.BROWSE_DIR, asyncHandler, false, 0, true);
			component.browseButton.enabled = true;
			component.browseButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		
		/**
		 * Test that <code>BackupPopupEvent.CANCEL_BACKUP</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testCancelBackupButtonClickHandled():void
		{
			component.isProcess = true;
			component.validateNow();
			
			var asyncHandler:Function = Async.asyncHandler(this, onCancelBackupButtonClicked, 4000, BackupPopupEvent.CANCEL_BACKUP);
			component.addEventListener(BackupPopupEvent.CANCEL_BACKUP, asyncHandler, false, 0, true);
			component.cancelBackupButton.enabled = true;
			component.cancelBackupButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Handle <code>FlexEvent.UPDATE_COMPLETE</code> event dispatched by <code>pathFileInput<code>
		 */
		private function onPathFileInputUpdateCompleted(event:FlexEvent, passThroughData:String):void 
		{
			Assert.assertEquals(component.pathFileInput.text, passThroughData);
		}
		
		/**
		 * Handle <code>BackupPopupEvent.BROWSE_DIR</code> event dispatched by <code>browseButton<code>
		 */
		private function onBrowseButtonClicked(event:BackupPopupEvent, passThroughData:String):void 
		{
			Assert.assertEquals(event.type, passThroughData);
		}		
		
		/**
		 * Handle <code>BackupPopupEvent.CANCEL_BACKUP</code> event dispatched by <code>cancelBackupButton<code>
		 */
		private function onCancelBackupButtonClicked(event:BackupPopupEvent, passThroughData:String):void 
		{			
			Assert.assertEquals(event.type, passThroughData);
			Assert.assertFalse(component.isProcess);
		}		
	}
}

