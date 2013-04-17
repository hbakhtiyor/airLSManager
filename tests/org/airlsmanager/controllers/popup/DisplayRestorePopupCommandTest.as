////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.popup
{
	import flexunit.framework.Assert;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.views.components.popup.RestorePopup;
	import org.airlsmanager.views.mediators.popup.RestorePopupMediator;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * DisplayRestorePopupCommandTest class 
	 */
	public class DisplayRestorePopupCommandTest
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
		 * Constant for notification's name.
		 */		
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.DISPLAY_RESTORE_POPUP;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:DisplayRestorePopupCommand;
		
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
		//  popupMediator
		//---------------------------------- 
		/**
		 * Retrieve instance of <code>RestorePopupMediator</code>.
		 */		
		private function get popupMediator():RestorePopupMediator
		{
			return facade.retrieveMediator(RestorePopupMediator.NAME) as RestorePopupMediator;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Creates all needed objects for the tests.
		 */ 
		[Before]
		public function before():void
		{
			facade = Facade.getInstance(FACADE_NAME);
			
			command = new DisplayRestorePopupCommand();
			command.initializeNotifier(FACADE_NAME);
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade.removeMediator(RestorePopupMediator.NAME);
			facade.removeProxy(LocalStoreProxy.NAME);
			
			facade 	= null;
			command = null;
			
			// Remove facade
			Facade.removeCore(FACADE_NAME);
			UIImpersonator.removeAllChildren();
		}
		
		/**
		 * Test execute method of the command.
		 */ 
		[Test]
		public function testExecute():void
		{
			command.execute(new Notification(STARTUP_NOTIFICATION));
			
			Assert.assertTrue(facade.hasMediator(RestorePopupMediator.NAME));
			Assert.assertTrue(popupMediator.getViewComponent() is RestorePopup);
			Assert.assertTrue(facade.hasProxy(LocalStoreProxy.NAME));
		}
		
		/**
		 * Test execute method with notification's body of the command.
		 */ 
		[Test]
		public function testExecuteWithBody():void
		{
			var backupFile:String = "/backups/backup-04.15.2013.bak";
			command.execute(new Notification(STARTUP_NOTIFICATION, backupFile));
			
			Assert.assertTrue(facade.hasMediator(RestorePopupMediator.NAME));
			Assert.assertTrue(popupMediator.getViewComponent() is RestorePopup);
			Assert.assertTrue(popupMediator.defaultBackupFile, backupFile);
			Assert.assertTrue(facade.hasProxy(LocalStoreProxy.NAME));
		}		
	}
}