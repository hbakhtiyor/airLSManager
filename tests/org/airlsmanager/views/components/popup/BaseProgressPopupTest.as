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
	
	import org.airlsmanager.views.events.popup.PopupEvent;
	import org.airlsmanager.views.skins.popup.BackupPopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	/**
	 * BaseProgressPopupTest class 
	 */
	public class BaseProgressPopupTest
	{

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of component instance.
		 */
		private var component:BaseProgressPopup;
		
		
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
			component = new BaseProgressPopup();
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
		 * Test that <code>PopupEvent.HELP</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testHelpButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCommonButtonClicked, 4000, PopupEvent.HELP);
			component.addEventListener(PopupEvent.HELP, asyncHandler, false, 0, true);
			component.helpButton.enabled = true;
			component.helpButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		
		/**
		 * Test that <code>PopupEvent.CLOSE</code> event is dispatched
		 */
		[Test(async, ui, timeout="4000")]
		public function testCloseButtonClickHandled():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCommonButtonClicked, 4000, PopupEvent.CLOSE);
			component.addEventListener(PopupEvent.CLOSE, asyncHandler, false, 0, true);
			component.closeButton.enabled = true;
			component.closeButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			component.validateNow();
		}
		
		/**
		 * Test isProcess property of the component.
		 */
		[Test(async, ui, timeout="4000")]
		public function testIsProcess():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCommonStateChanged, 4000, "process");
			component.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler, false, 0, true);
			component.isProcess = true;
			component.validateNow();
		}
		
		/**
		 * Test isError property of the component.
		 */
		[Test(async, ui, timeout="4000")]
		public function testIsError():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCommonStateChanged, 4000, "error");
			component.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler, false, 0, true);
			component.isError = true;
			component.validateNow();
		}

		/**
		 * Test isSuccessful property of the component.
		 */
		[Test(async, ui, timeout="4000")]
		public function testIsSuccessful():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, onCommonStateChanged, 4000, "successful");
			component.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler, false, 0, true);
			component.isSuccessful = true;
			component.validateNow();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Handle <code>PopupEvent.HELP</code> and <code>PopupEvent.CLOSE</code> events dispatched by button
		 */
		private function onCommonButtonClicked(event:PopupEvent, passThroughData:String):void 
		{
			Assert.assertEquals(event.type, passThroughData);
		}
		
		/**
		 * Handle <code>FlexEvent.UPDATE_COMPLETE</code> event dispatched by component
		 */
		private function onCommonStateChanged(event:FlexEvent, passThroughData:String):void 
		{
			Assert.assertEquals(component.skin.currentState, passThroughData);
		}		
	}
}

