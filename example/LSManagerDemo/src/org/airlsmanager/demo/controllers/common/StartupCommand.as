////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.controllers.common
{
	import org.airlsmanager.demo.consts.FileAssociationType;
	import org.airlsmanager.demo.views.components.LsmApplication;
	import org.airlsmanager.demo.views.mediators.ApplicationMediator;
	import org.airlsmanager.demo.views.mediators.ContentHolderMediator;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.models.vo.FileFormatVo;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * StartupCommand class 
	 */
	public class StartupCommand extends SimpleCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  defaultSetting
		//----------------------------------
		/**
		 *  Creates default setting for backup/restore
		 */		
		private function get defaultSetting():SettingVo
		{
			var setting:SettingVo = new SettingVo();
			
			setting.backupDir 		= "Demo Backups";
			setting.maxFileIndex 	= 10;
			setting.excludeFiles 	= ['.*errors.*', '.*\.tmp'];
			setting.fileFormat 		= new FileFormatVo(FileAssociationType.BAK_EXTENSION);
			
			return setting;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Register mediators and backup/restore proxy.
		 */
		override public function execute(notification:INotification):void
		{
			var app:LsmApplication = notification.getBody() as LsmApplication;
			if(app)
			{
				facade.registerMediator(new ApplicationMediator(app));
				facade.registerMediator(new ContentHolderMediator(app.holder));
				
				facade.registerProxy(new LocalStoreProxy(defaultSetting));
			}
		}
	}
}