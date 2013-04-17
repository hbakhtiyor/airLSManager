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
	import org.airlsmanager.controllers.help.DisplayHelpContentCommand;
	import org.airlsmanager.controllers.popup.DisplayBackupPopupCommand;
	import org.airlsmanager.controllers.popup.DisplayBackupProgressPopupCommand;
	import org.airlsmanager.controllers.popup.DisplayRestorePopupCommand;
	import org.airlsmanager.controllers.setting.SetLocalStoreSettings;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * RegisterLsmCommands class 
	 */
	public class RegisterLsmCommands extends BaseCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Register necessary commands
		 */
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LsmNotifications.REGISTER_COMMANDS);
			
			facade.registerCommand(LsmNotifications.DISPLAY_BACKUP_POPUP			, DisplayBackupPopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_BACKUP_PROGRESS_POPUP	, DisplayBackupProgressPopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_RESTORE_POPUP			, DisplayRestorePopupCommand);
			facade.registerCommand(LsmNotifications.DISPLAY_HELP_CONTENT			, DisplayHelpContentCommand);
			
			facade.registerCommand(LsmNotifications.SET_LS_SETTINGS					, SetLocalStoreSettings);
		}		
	}
}