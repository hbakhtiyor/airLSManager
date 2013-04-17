////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.popup
{
	
	import org.airlsmanager.views.components.popup.BaseProgressPopup;
	import org.airlsmanager.views.mediators.popup.BackupProgressPopupMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * DisplayBackupProgressPopupCommand class 
	 */	
	public class DisplayBackupProgressPopupCommand extends BasePopupCommand
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Launch backup progress pop-up
		 */ 
		override public function execute(note:INotification):void
		{
			if(!facade.hasMediator(BackupProgressPopupMediator.NAME))
				displayPopupAndRegisterMediator(BaseProgressPopup, BackupProgressPopupMediator);
		}
	}
}