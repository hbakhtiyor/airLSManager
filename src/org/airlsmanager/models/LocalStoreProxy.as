////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.models
{
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	
	import spark.components.WindowedApplication;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.controllers.common.RegisterLsmCommands;
	import org.airlsmanager.controllers.common.RemoveLsmCommands;
	import org.airlsmanager.models.manager.LocalStoreManagerProxy;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * LocalStoreProxy class 
	 */
	public class LocalStoreProxy extends Proxy
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Name of Proxy class.
		 */
		public static const NAME:String = "LocalStoreProxy";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * LocalStoreProxy 
		 */
		public function LocalStoreProxy(setting:SettingVo=null)
		{
			_setting = setting;
			
			super(NAME);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : public
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  setting
		//----------------------------------
		/**
		 * Store backup/restore's settings 
		 */		
		private var _setting:SettingVo;
		
		/**
		 *  @private
		 */	
		public function get setting():SettingVo
		{
			return _setting || new SettingVo();
		}
		
		/**
		 *  @private
		 */		
		public function set setting(value:SettingVo):void
		{
			_setting = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : private
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  topApplication
		//----------------------------------
		/**
		 * Get the first application from <code>FlexGlobals</code>
		 */		
		private function get topApplication():WindowedApplication
		{
			return FlexGlobals.topLevelApplication as WindowedApplication;
		}
		
		//----------------------------------
		//  storeManagerProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreManagerProxy</code>. If proxy does not exist,
		 * register a new one.
		 */			
		private function get storeManagerProxy() : LocalStoreManagerProxy
		{
			if(!facade.hasProxy(LocalStoreManagerProxy.NAME))
				facade.registerProxy(new LocalStoreManagerProxy());
			
			return facade.retrieveProxy(LocalStoreManagerProxy.NAME) as LocalStoreManagerProxy;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------

		/**
		 *  @inheritDoc
		 */
		override public function onRegister():void
		{
			super.onRegister();
			
			facade.registerCommand(LsmNotifications.REGISTER_COMMANDS, RegisterLsmCommands);
			sendNotification(LsmNotifications.REGISTER_COMMANDS);
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function onRemove():void
		{
			facade.registerCommand(LsmNotifications.REMOVE_COMMANDS, RemoveLsmCommands);
			sendNotification(LsmNotifications.REMOVE_COMMANDS);
			
			if(topApplication && topApplication)
			{
				topApplication.removeEventListener(Event.CLOSING, onApplicationClosing);
			}
			
			super.onRemove();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 *  @private
		 */	
		public function observeBackup():void
		{
			if(topApplication)
			{
				topApplication.addEventListener(Event.CLOSING, onApplicationClosing, false, int.MAX_VALUE);
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------		
		/**
		 * 
		 *  Handler for <code>Event.CLOSING</code> event dispatched by nativeWindow.
		 * 
		 *  @param event The event dispatched by nativeWindow.
		 * 
		 */ 
		private function onApplicationClosing(event:Event):void
		{
			if(storeManagerProxy.progressing)
			{
				event.stopImmediatePropagation();
				event.preventDefault();
				
				sendNotification(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP);
			}
			else if(topApplication)
			{
				topApplication.removeEventListener(Event.CLOSING, onApplicationClosing);
			}
		}		
	}
}