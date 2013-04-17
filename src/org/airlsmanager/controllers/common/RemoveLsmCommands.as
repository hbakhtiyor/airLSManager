////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.common
{
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.controllers.BaseCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * RemoveLSMCommands class 
	 */
	public class RemoveLsmCommands extends BaseCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Remove registered commands
		 */
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LsmNotifications.REMOVE_COMMANDS);
			facade.removeCommand(LsmNotifications.REGISTER_COMMANDS);
			
			facade.removeCommand(LsmNotifications.DISPLAY_BACKUP_POPUP);
			facade.removeCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP);
			facade.removeCommand(LsmNotifications.DISPLAY_RESTORE_POPUP);
			facade.removeCommand(LsmNotifications.DISPLAY_HELP_CONTENT);
			
			facade.removeCommand(LsmNotifications.SET_LS_SETTINGS);
		}
	}
}