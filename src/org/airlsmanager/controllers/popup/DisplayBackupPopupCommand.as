////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.popup
{
	
	import org.airlsmanager.views.components.popup.BackupPopup;
	import org.airlsmanager.views.mediators.popup.BackupPopupMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * DisplayBackupPopupCommand class 
	 */	
	public class DisplayBackupPopupCommand extends BasePopupCommand
	{

		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Launch backup pop-up
		 */ 
		override public function execute(note:INotification):void
		{				
			if(!facade.hasMediator(BackupPopupMediator.NAME))
				displayPopupAndRegisterMediator(BackupPopup, BackupPopupMediator);
		}
	}
}