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
	import org.airlsmanager.helpers.ApplicationStorageDirectory;
	import org.airlsmanager.models.manager.LocalStoreManagerProxy;
	import org.airlsmanager.views.components.popup.BackupPopup;
	import org.airlsmanager.views.events.popup.BackupPopupEvent;
	import org.airlsmanager.views.skins.popup.BackupPopupSkin;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * BackupPopupMediatorTest class 
	 */
	public class BackupPopupMediatorTest
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
		private var component:BackupPopup;
		
		/**
		 * Holds reference of mediator instance.
		 */
		private var mediator:BackupPopupMediator;
		
		/**
		 * Holds reference of facade instance.
		 */
		private var facade:IFacade;
		
		

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------		
		//----------------------------------
		//  storeManagerProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreManagerProxy</code>.
		 */		
		private function get storeManagerProxy():LocalStoreManagerProxy
		{
			return facade.retrieveProxy(LocalStoreManagerProxy.NAME) as LocalStoreManagerProxy;
		}
		
		
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
			
			facade = Facade.getInstance(FACADE_NAME);
			mediator = new BackupPopupMediator(component);
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
			
			facade.removeMediator(BackupPopupMediator.NAME);
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
			Assert.assertTrue(mediator.getViewComponent() is BackupPopup);
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
			Assert.assertContained(LsmNotifications.BACKUP_FILE_SELECTED, arr);
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
				Assert.assertTrue(hasEventListener(BackupPopupEvent.BACKUP_NOW));
				Assert.assertTrue(hasEventListener(BackupPopupEvent.BROWSE_DIR));
				Assert.assertTrue(hasEventListener(BackupPopupEvent.CANCEL_BACKUP));
				
				Assert.assertEquals(storeManagerProxy.defaultBackupDirectory, backupDirectory);
				Assert.assertEquals(!ApplicationStorageDirectory.isEmpty(), backupEnabled);
			}
		}
		
		/**
		 * Test onRemove method of the mediator.
		 */ 
		[Test]
		public function testOnRemove():void
		{
			facade.removeMediator(BackupPopupMediator.NAME);
			
			Assert.assertNull(mediator.component);
			Assert.assertFalse(facade.hasMediator(BackupPopupMediator.NAME));
		}		
	}
}