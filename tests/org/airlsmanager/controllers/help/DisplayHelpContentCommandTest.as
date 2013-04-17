////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.help
{
	import flexunit.framework.Assert;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.helpers.HelpUrlResolver;
	import org.airlsmanager.views.mediators.window.WindowMediator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;

	/**
	 * DisplayHelpContentCommandTest class 
	 */
	public class DisplayHelpContentCommandTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.DISPLAY_HELP_CONTENT;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:DisplayHelpContentCommand;
		
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
		//  windowMediator
		//---------------------------------- 
		/**
		 * Retrieve instance of <code>WindowMediator</code>.
		 */		
		private function get windowMediator():WindowMediator
		{
			return facade.retrieveMediator(WindowMediator.NAME) as WindowMediator;
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
			
			command = new DisplayHelpContentCommand();
			command.initializeNotifier(FACADE_NAME);
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade.removeMediator(WindowMediator.NAME);
			
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
			command.execute(new Notification(STARTUP_NOTIFICATION));
			
			Assert.assertTrue(facade.hasMediator(WindowMediator.NAME));
			Assert.assertNotNull(windowMediator.helpWindow);
			Assert.assertFalse(windowMediator.helpWindow.closed);
			Assert.assertEquals(windowMediator.helpWindow.url, 
				HelpUrlResolver.getInstance().normalizeUrl(HelpUrlResolver.DEFAULT_HELP_FILE, "en_US"));
		}
		
		/**
		 * Test execute method with notification's body of the command.
		 */ 
		[Test]
		public function testExecuteWithBody():void
		{
			var screenName:String = "Does_not_exist_view";
			command.execute(new Notification(STARTUP_NOTIFICATION, screenName));
			
			Assert.assertTrue(facade.hasMediator(WindowMediator.NAME));
			Assert.assertNotNull(windowMediator.helpWindow);
			Assert.assertFalse(windowMediator.helpWindow.closed);
			Assert.assertEquals(windowMediator.helpWindow.url, 
				HelpUrlResolver.getInstance().normalizeUrl(screenName, "en_US"));
		}		
	}
}