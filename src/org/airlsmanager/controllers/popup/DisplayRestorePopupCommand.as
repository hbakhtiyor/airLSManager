////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.popup
{
	
	import org.airlsmanager.views.components.popup.RestorePopup;
	import org.airlsmanager.views.mediators.popup.RestorePopupMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class DisplayRestorePopupCommand extends BasePopupCommand
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Launch restore pop-up
		 */ 
		override public function execute(note:INotification):void
		{
			if(!facade.hasMediator(RestorePopupMediator.NAME))
				displayPopupAndRegisterMediator(RestorePopup, RestorePopupMediator, note.getBody());
		}
	}
}