////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.interfaces.popup
{
	public interface IRestorePopup extends IBaseProgressPopup
	{
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function get selectedFileDate():String;
		
		function set selectedFileDate(value:String):void;
		
		function get restoreEnabled():Boolean;
		
		function set restoreEnabled(value:Boolean):void
	}
}