////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.controllers.common
{
	import org.airlsmanager.demo.Notifications;
	import org.airlsmanager.demo.views.mediators.ApplicationMediator;
	import org.airlsmanager.demo.views.mediators.ContentHolderMediator;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * DestroyCommand class 
	 */
	public class DisposeCommand extends SimpleCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Remove registered mediators, proxies, commands and facade by given key.
		 */
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(ApplicationMediator.NAME);
			facade.removeMediator(ContentHolderMediator.NAME);
			
			facade.removeProxy(LocalStoreProxy.NAME);
			
			facade.removeCommand(Notifications.STARTUP);
			facade.removeCommand(Notifications.DISPOSE);
			facade.removeCommand(Notifications.WRITE_SAMPLE_DATA);
				
			Facade.removeCore(notification.getBody() as String);
		}
	}
}