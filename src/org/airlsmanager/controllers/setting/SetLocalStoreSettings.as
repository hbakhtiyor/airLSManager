////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.setting
{
	import org.airlsmanager.controllers.BaseCommand;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * SetLStoreSettings class 
	 */
	public class SetLocalStoreSettings extends BaseCommand
	{

		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override public function execute(notification:INotification):void
		{
			localStoreProxy.setting = notification.getBody() as SettingVo;
		}
	}
}