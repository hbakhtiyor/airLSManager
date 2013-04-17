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
	
	import org.airlsmanager.views.events.popup.RestorePopupEvent;
	import org.airlsmanager.views.skins.popup.RestorePopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	/**
	 * RestorePopupTest class 
	 */
	public class RestorePopupTest
	{

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of component instance.
		 */
		private var component:RestorePopup;
		
		
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
			component = new RestorePopup();
			component.setStyle("skinClass", RestorePopupSkin);
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
		 * Test that <code>RestorePopupEvent.BROWSE_BACKUP</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testBrowseButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onBrowseButtonClicked, 4000, RestorePopupEvent.BROWSE_BACKUP);
			component.addEventListener(RestorePopupEvent.BROWSE_BACKUP, asyncHandler, false, 0, true);
			component.browseButton.enabled = true;
			component.browseButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		/**
		 * Test that <code>RestorePopupEvent.CANCEL_RESTORE</code> event is dispatched
		 */
		[Ignore]
		[Test(async, ui, timeout="4000")]
		public function testCancelRestoreButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCancelRestoreButtonClicked, 4000, RestorePopupEvent.CANCEL_RESTORE);
			component.addEventListener(RestorePopupEvent.CANCEL_RESTORE, asyncHandler, false, 0, true);
			component.cancelRestoreButton.enabled = true;
			component.cancelRestoreButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		/**
		 * Test that <code>RestorePopupEvent.RESTORE_NOW</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testRestoreButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onRestoreButtonClicked, 4000, RestorePopupEvent.RESTORE_NOW);
			component.addEventListener(RestorePopupEvent.RESTORE_NOW, asyncHandler, false, 0, true);
			component.restoreButton.enabled = true;
			component.restoreButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}		
		
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Handle <code>RestorePopupEvent.BROWSE_BACKUP</code> event dispatched by <code>browseButton<code>
		 */
		private function onBrowseButtonClicked(event:RestorePopupEvent, passThroughData:String):void 
		{
			Assert.assertEquals(event.type, passThroughData);
		}		
		
		/**
		 * Handle <code>RestorePopupEvent.CANCEL_RESTORE</code> event dispatched by <code>cancelRestoreButton<code>
		 */
		private function onCancelRestoreButtonClicked(event:RestorePopupEvent, passThroughData:String):void 
		{			
			Assert.assertEquals(event.type, passThroughData);
			Assert.assertFalse(component.isProcess);
		}
		
		/**
		 * Handle <code>RestorePopupEvent.RESTORE_NOW</code> event dispatched by <code>restoreButton<code>
		 */
		private function onRestoreButtonClicked(event:RestorePopupEvent, passThroughData:String):void 
		{			
			Assert.assertEquals(event.type, passThroughData);
			Assert.assertTrue(component.isProcess);
		}		
	}
}

