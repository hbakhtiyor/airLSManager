////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.setting
{
	import flexunit.framework.Assert;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.controllers.setting.SetLocalStoreSettings;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	/**
	 * SetLocalStoreSettingsTest class 
	 */
	public class SetLocalStoreSettingsTest
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
		public static const STARTUP_NOTIFICATION:String = LsmNotifications.SET_LS_SETTINGS;
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Holds reference of command instance.
		 */
		private var command:SetLocalStoreSettings;
		
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
		//  storeProxy
		//---------------------------------- 
		/**
		 * Retrieve instance of <code>LocalStoreProxy</code>.
		 */		
		private function get storeProxy():LocalStoreProxy
		{
			return facade.retrieveProxy(LocalStoreProxy.NAME) as LocalStoreProxy;
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
			
			command = new SetLocalStoreSettings();
			command.initializeNotifier(FACADE_NAME);
		}
		
		/**
		 * Destroys objects of the tests.
		 */		
		[After]
		public function after():void
		{
			facade.removeProxy(LocalStoreProxy.NAME);
			
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
			var setting:SettingVo = new SettingVo();
			setting.excludeFiles = [".*secret.*"];
			command.execute(new Notification(STARTUP_NOTIFICATION, setting));
			
			Assert.assertTrue(facade.hasProxy(LocalStoreProxy.NAME));
			Assert.assertObjectEquals(storeProxy.setting, setting);
		}	
	}
}
