////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.common
{
	import flexunit.framework.Assert;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.controllers.help.DisplayHelpContentCommand;
	import org.airlsmanager.controllers.popup.DisplayBackupPopupCommand;
	import org.airlsmanager.controllers.popup.DisplayBackupProgressPopupCommand;
	import org.airlsmanager.controllers.popup.DisplayRestorePopupCommand;
	import org.airlsmanager.controllers.setting.SetLocalStoreSettings;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * RemoveLsmCommandsTest class 
	 */
	public class RemoveLsmCommandsTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.REMOVE_COMMANDS;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:RemoveLsmCommands;
		
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
		[Before]
		public function before():void
		{
			facade = Facade.getInstance(FACADE_NAME);
			
			command = new RemoveLsmCommands();
			command.initializeNotifier(FACADE_NAME);
			
			
			
			facade.registerCommand(STARTUP_NOTIFICATION					, RemoveLsmCommands);
			facade.registerCommand(LsmNotifications.REGISTER_COMMANDS	, RegisterLsmCommands);
			
			facade.registerCommand(LsmNotifications.DISPLAY_BACKUP_POPUP			, DisplayBackupPopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP	, DisplayBackupProgressPopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_RESTORE_POPUP			, DisplayRestorePopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_HELP_CONTENT			, DisplayHelpContentCommand);
			
			facade.registerCommand(LsmNotifications.SET_LS_SETTINGS, SetLocalStoreSettings);			
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade 	= null;
			command = null;
			
			// Remove facade
			Facade.removeCore(FACADE_NAME);
		}
		
		/**
		 * Test execute method of the command.
		 */ 
		[Test]
		public function testExecute():void
		{
			Assert.assertTrue(facade.hasCommand(STARTUP_NOTIFICATION));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.REGISTER_COMMANDS));
			
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_RESTORE_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_HELP_CONTENT));
			
			Assert.assertTrue(facade.hasCommand(LsmNotifications.SET_LS_SETTINGS));
			
			command.execute(new Notification(STARTUP_NOTIFICATION));
			
			Assert.assertFalse(facade.hasCommand(STARTUP_NOTIFICATION));
			Assert.assertFalse(facade.hasCommand(LsmNotifications.REGISTER_COMMANDS));
			
			Assert.assertFalse(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_POPUP));
			Assert.assertFalse(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP));
			Assert.assertFalse(facade.hasCommand(LsmNotifications.DISPLAY_RESTORE_POPUP));
			Assert.assertFalse(facade.hasCommand(LsmNotifications.DISPLAY_HELP_CONTENT));
			
			Assert.assertFalse(facade.hasCommand(LsmNotifications.SET_LS_SETTINGS));
		}		
	}
}


