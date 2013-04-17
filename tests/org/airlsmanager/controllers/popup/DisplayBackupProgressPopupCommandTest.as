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
	import org.airlsmanager.views.components.popup.BaseProgressPopup;
	import org.airlsmanager.views.mediators.popup.BackupProgressPopupMediator;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * DisplayBackupProgressPopupCommandTest class 
	 */
	public class DisplayBackupProgressPopupCommandTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:DisplayBackupProgressPopupCommand;
		
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
		 * Retrieve instance of <code>BackupProgressPopupMediator</code>.
		 */		
		private function get popupMediator():BackupProgressPopupMediator
		{
			return facade.retrieveMediator(BackupProgressPopupMediator.NAME) as BackupProgressPopupMediator;
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
			
			command = new DisplayBackupProgressPopupCommand();
			command.initializeNotifier(FACADE_NAME);
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade.removeMediator(BackupProgressPopupMediator.NAME);
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
			
			Assert.assertTrue(facade.hasMediator(BackupProgressPopupMediator.NAME));
			Assert.assertTrue(popupMediator.getViewComponent() is BaseProgressPopup);
			Assert.assertTrue(facade.hasProxy(LocalStoreProxy.NAME));
		}	
	}
}