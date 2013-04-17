////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.interfaces.popup
{
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	
	public interface IBaseProgressPopup extends IVisualElement, IFlexDisplayObject
	{
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function get hasHelp():Boolean;
		
		function set hasHelp(value:Boolean):void;
		
		function get isProcess():Boolean;
		
		function set isProcess(value:Boolean):void;
		
		function get isError():Boolean;
		
		function set isError(value:Boolean):void;
		
		function get isSuccessful():Boolean;
		
		function set isSuccessful(value:Boolean):void;
		
		function get errorMessage():String;
		
		function set errorMessage(value:String):void;
		
		function setProgress(numCompleted:Number, totalCount:Number):void
	}
}