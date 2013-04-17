////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.consts
{
	

	/**
	 * Notifications class 
	 */
	public class LsmNotifications
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * The <code>RESTORE_FILE_SELECTED</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */ 
		public static const RESTORE_FILE_SELECTED	:String = "restoreFileSelected";
		
		/**
		 * The <code>RESTORE_FILE_CANCELED</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const RESTORE_FILE_CANCELED	:String = "restoreFileCanceled";
		
		/**
		 * The <code>RESTORE_ERROR</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const RESTORE_ERROR			:String = "restoreError";
		
		/**
		 * The <code>RESTORE_SUCCESSFULLY</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const RESTORE_SUCCESSFULLY	:String = "restoreSuccessfully";
		
		/**
		 * The <code>RESTORE_PROGRESS</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const RESTORE_PROGRESS		:String = "restoreProgress";
		
		/**
		 * The <code>BACKUP_FILE_SELECTED</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */
		public static const BACKUP_FILE_SELECTED	:String = "backupFileSelected";
		
		/**
		 * The <code>BACKUP_FILE_CANCELED</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const BACKUP_FILE_CANCELED	:String = "backupFileCanceled";
		
		/**
		 * The <code>BACKUP_ERROR</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const BACKUP_ERROR			:String = "backupError";
		
		/**
		 * The <code>BACKUP_SUCCESSFULLY</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const BACKUP_SUCCESSFULLY		:String = "backupSuccessfully";
		
		/**
		 * The <code>BACKUP_PROGRESS</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const BACKUP_PROGRESS			:String = "backupProgress";		
		
		/**
		 * The <code>DISPLAY_RESTORE_POPUP</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>DISPLAY_RESTORE_POPUP</code> notification invokes <code>DisplayRestorePopupCommand</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.popup.DisplayRestorePopupCommand
		 */
		public static const DISPLAY_RESTORE_POPUP			:String = "displayRestorePopup";
		
		/**
		 * The <code>DISPLAY_BACKUP_POPUP</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>DISPLAY_BACKUP_POPUP</code> notification invokes <code>DisplayBackupPopupCommand</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.popup.DisplayBackupPopupCommand
		 */
		public static const DISPLAY_BACKUP_POPUP			:String = "displayBackupPopup";
		
		/**
		 * The <code>DISPLAY_BACKUP_PROGRESS_POPUP</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>DISPLAY_BACKUP_PROGRESS_POPUP</code> notification invokes <code>DisplayBackupProgressPopupCommand</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.popup.DisplayBackupProgressPopupCommand
		 */
		public static const DISPLAY_BACKUP_PROGRESS_POPUP	:String = "displayBackupProgressPopup";
		
		/**
		 * The <code>DISPLAY_HELP_CONTENT</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>DISPLAY_HELP_CONTENT</code> notification invokes <code>DisplayHelpContentCommand</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.help.DisplayHelpContentCommand
		 */
		public static const DISPLAY_HELP_CONTENT	:String = "displayHelpContent";
		
		/**
		 * The <code>SET_LS_SETTINGS</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>SET_LS_SETTINGS</code> notification invokes <code>SetLocalStoreSettings</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.setting.SetLocalStoreSettings
		 */
		public static const SET_LS_SETTINGS			:String = "setLocalStoreSettings";
		
		/**
		 * The <code>REGISTER_COMMANDS</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>REGISTER_COMMANDS</code> notification invokes <code>RegisterLsmCommands</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.common.RegisterLsmCommands
		 */
		public static const REGISTER_COMMANDS		:String = "registerLsmCommands";
		
		/**
		 * The <code>REMOVE_COMMANDS</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>REMOVE_COMMANDS</code> notification invokes <code>RemoveLsmCommands</code></p>
		 *  
		 * @see  org.airlsmanager.controllers.common.RemoveLsmCommands
		 */
		public static const REMOVE_COMMANDS			:String = "removeLsmCommands";
	}
}