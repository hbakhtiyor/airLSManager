////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.interfaces.popup
{
	public interface IBackupPopup extends IBaseProgressPopup
	{
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function get backupEnabled():Boolean;
		
		function set backupEnabled(value:Boolean):void;
		
		function get backupDirectory():String;
		
		function set backupDirectory(value:String):void;
	}
}