////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.popup
{
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import org.airlsmanager.controllers.BaseCommand;
	import org.airlsmanager.views.interfaces.popup.IBaseProgressPopup;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	
	/**
	 * BasePopupCommand class 
	 */
	public class BasePopupCommand extends BaseCommand
	{
	
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  topApplication
		//---------------------------------- 		
		/**
		 * Get the first application from <code>FlexGlobals</code>
		 */
		protected function get topApplication():DisplayObject
		{
			return FlexGlobals.topLevelApplication as DisplayObject;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Create pop-up and register mediator by given parameters
		 */		
		protected function displayPopupAndRegisterMediator(popupClass:Class, mediatorClass:Class, data:Object=null):void
		{
			var view:IBaseProgressPopup = new popupClass();
			
			(view as UIComponent).width 	= topApplication.width;
			(view as UIComponent).height 	= topApplication.height;
			
			PopUpManager.addPopUp(view, topApplication, setting.isPopupModal);
			PopUpManager.centerPopUp(view);
			
			var mediator:IMediator = data ? new mediatorClass(view, data) : new mediatorClass(view);
			facade.registerMediator(mediator);
			
			(view as UIComponent).setFocus();
		}
	}
}