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
	import org.airlsmanager.views.components.popup.BackupPopup;
	import org.airlsmanager.views.mediators.popup.BackupPopupMediator;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * DisplayBackupPopupCommandTest class 
	 */
	public class DisplayBackupPopupCommandTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.DISPLAY_BACKUP_POPUP;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:DisplayBackupPopupCommand;
		
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
		 * Retrieve instance of <code>BackupPopupMediator</code>.
		 */		
		private function get popupMediator():BackupPopupMediator
		{
			return facade.retrieveMediator(BackupPopupMediator.NAME) as BackupPopupMediator;
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
			
			command = new DisplayBackupPopupCommand();
			command.initializeNotifier(FACADE_NAME);
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade.removeMediator(BackupPopupMediator.NAME);
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
			
			Assert.assertTrue(facade.hasMediator(BackupPopupMediator.NAME));
			Assert.assertTrue(popupMediator.getViewComponent() is BackupPopup);
			Assert.assertTrue(facade.hasProxy(LocalStoreProxy.NAME));
		}	
	}
}