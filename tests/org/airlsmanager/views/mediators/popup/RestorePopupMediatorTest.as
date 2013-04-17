////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.mediators.popup
{
	import mx.events.FlexEvent;
	
	import flexunit.framework.Assert;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.views.components.popup.RestorePopup;
	import org.airlsmanager.views.events.popup.RestorePopupEvent;
	import org.airlsmanager.views.skins.popup.RestorePopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * RestorePopupMediatorTest class 
	 */
	public class RestorePopupMediatorTest
	{

		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constant for facade's name.
		 */ 
		public static const FACADE_NAME:String = 'testFacadeName';
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of component instance.
		 */
		private var component:RestorePopup;
		
		/**
		 * Holds reference of mediator instance.
		 */
		private var mediator:RestorePopupMediator;
		
		/**
		 * Holds reference of facade instance.
		 */
		private var facade:IFacade;
		
		
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
			
			facade = Facade.getInstance(FACADE_NAME);
			mediator = new RestorePopupMediator(component);
			facade.registerMediator(mediator);
			
			component.validateNow();			
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After(async, ui)]
		public function after():void
		{
			UIImpersonator.removeChild(component);
			
			facade.removeMediator(RestorePopupMediator.NAME);
			Facade.hasCore(FACADE_NAME);
			
			mediator 	= null;
			facade 		= null;
			component 	= null;
		}
		
		/**
		 * Test getViewComponent method of the mediator.
		 */ 
		[Test]
		public function testViewComponent():void
		{
			Assert.assertNotNull(mediator.getViewComponent());
			Assert.assertTrue(mediator.getViewComponent() is RestorePopup);
			Assert.assertObjectEquals(mediator.getViewComponent(), component);
		}
		
		/**
		 * Test listNotificationInterests method of the mediator.
		 */ 
		[Test]
		public function testListNotificationInterests():void
		{
			var arr:Array = mediator.listNotificationInterests();
			Assert.assertNotNull(arr);
			Assert.assertContained(LsmNotifications.RESTORE_ERROR, arr);
			Assert.assertContained(LsmNotifications.RESTORE_PROGRESS, arr);
			Assert.assertContained(LsmNotifications.RESTORE_SUCCESSFULLY, arr);
			Assert.assertContained(LsmNotifications.RESTORE_FILE_SELECTED, arr);
			Assert.assertContained(LsmNotifications.RESTORE_FILE_CANCELED, arr);
		}
		
		/**
		 * Test onRegister method of the mediator.
		 */ 
		[Test]
		public function testOnRegister():void
		{
			Assert.assertNotNull(mediator.component);
			
			with(mediator.component)
			{
				Assert.assertTrue(hasEventListener(RestorePopupEvent.RESTORE_NOW));
				Assert.assertTrue(hasEventListener(RestorePopupEvent.BROWSE_BACKUP));
				Assert.assertTrue(hasEventListener(RestorePopupEvent.CANCEL_RESTORE));
			}
		}
		
		/**
		 * Test onRemove method of the mediator.
		 */ 
		[Test]
		public function testOnRemove():void
		{
			facade.removeMediator(RestorePopupMediator.NAME);
			
			Assert.assertNull(mediator.component);
			Assert.assertFalse(facade.hasMediator(RestorePopupMediator.NAME));
		}		
	}
}