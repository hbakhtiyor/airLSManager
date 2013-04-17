////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers
{
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * BaseCommand class 
	 */
	public class BaseCommand extends SimpleCommand
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  localStoreProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreProxy</code>. If proxy does not exist,
		 * register a new one.
		 */		
		protected function get localStoreProxy():LocalStoreProxy
		{
			if(!facade.hasProxy(LocalStoreProxy.NAME))
				facade.registerProxy(new LocalStoreProxy());
			
			return facade.retrieveProxy(LocalStoreProxy.NAME) as LocalStoreProxy;
		}
				
		//----------------------------------
		//  setting
		//----------------------------------
		/**
		 * Get setting from <code>LocalStoreProxy</code>.
		 */		
		protected function get setting():SettingVo
		{
			return localStoreProxy.setting;
		}
	}
}