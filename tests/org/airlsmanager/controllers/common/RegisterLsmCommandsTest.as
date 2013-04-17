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
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * RegisterLsmCommandsTest class 
	 */
	public class RegisterLsmCommandsTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.REGISTER_COMMANDS;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:RegisterLsmCommands;
		
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
			
			command = new RegisterLsmCommands();
			command.initializeNotifier(FACADE_NAME);
			
			facade.registerCommand(STARTUP_NOTIFICATION, RegisterLsmCommands);
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
			
			command.execute(new Notification(STARTUP_NOTIFICATION));
			
			Assert.assertFalse(facade.hasCommand(STARTUP_NOTIFICATION));
			
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_RESTORE_POPUP));
			Assert.assertTrue(facade.hasCommand(LsmNotifications.DISPLAY_HELP_CONTENT));
			
			Assert.assertTrue(facade.hasCommand(LsmNotifications.SET_LS_SETTINGS));
		}		
	}
}


