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
	import org.airlsmanager.views.components.popup.BaseProgressPopup;
	import org.airlsmanager.views.events.popup.PopupEvent;
	import org.airlsmanager.views.skins.popup.BackupPopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * BasePopupMediatorTest class 
	 */
	public class BasePopupMediatorTest
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
		
		/**
		 * Constant for mediator's name.
		 */ 
		public static const MEDIATOR_NAME:String = 'testMediatorName';
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of component instance.
		 */
		private var component:BaseProgressPopup;
		
		/**
		 * Holds reference of mediator instance.
		 */
		private var mediator:BasePopupMediator;
		
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
			component = new BaseProgressPopup();
			component.setStyle("skinClass", BackupPopupSkin);
			Async.proceedOnEvent(this, component, FlexEvent.CREATION_COMPLETE, 1000);
			UIImpersonator.addChild(component);
			
			facade = Facade.getInstance(FACADE_NAME);
			mediator = new BasePopupMediator(MEDIATOR_NAME, component);
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
			
			facade.removeMediator(MEDIATOR_NAME);
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
			Assert.assertTrue(mediator.getViewComponent() is BaseProgressPopup);
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
			Assert.assertContained(LsmNotifications.BACKUP_ERROR, arr);
			Assert.assertContained(LsmNotifications.BACKUP_PROGRESS, arr);
			Assert.assertContained(LsmNotifications.BACKUP_SUCCESSFULLY, arr);
			Assert.assertContained(LsmNotifications.RESTORE_ERROR, arr);
			Assert.assertContained(LsmNotifications.RESTORE_PROGRESS, arr);
			Assert.assertContained(LsmNotifications.RESTORE_SUCCESSFULLY, arr);
		}
		
		/**
		 * Test onRegister method of the mediator.
		 */ 
		[Test]
		public function testOnRegister():void
		{
			Assert.assertNotNull(mediator.popup);
			
			with(mediator.popup)
			{
				Assert.assertTrue(hasEventListener(PopupEvent.HELP));
				Assert.assertTrue(hasEventListener(PopupEvent.CLOSE));
			}
		}
		
		/**
		 * Test onRemove method of the mediator.
		 */ 
		[Test]
		public function testOnRemove():void
		{
			facade.removeMediator(MEDIATOR_NAME);
			
			Assert.assertNull(mediator.popup);
			Assert.assertFalse(facade.hasMediator(MEDIATOR_NAME));
		}		
	}
}