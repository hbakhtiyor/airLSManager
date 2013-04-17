////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.helpers
{
	import flash.net.SharedObject;

	public class SharedSettings
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------

		/**
		 * Key for date of last backup stored in SO
		 */
		public static const LAST_BACKUP			: String = "lastBackup";
		
		/**
		 * Key for date of last restore stored in SO
		 */
		public static const LAST_RESTORE		: String = "lastRestore";
		
		/**
		 * The name of the SO
		 */
		public static const SHARED_NAME 		: String = "settings";
	

		//--------------------------------------------------------------------------
		//
		//  Static Methods
		//
		//--------------------------------------------------------------------------

		/**
		 * Writes given value to SO under given key 
		 * @param key Key under which the given value is stored
		 * @param value Data to save
		 */		
		public static function write(key:String, value:*):void
		{
			var shObj:SharedObject = SharedObject.getLocal(SHARED_NAME, "/");
			shObj.data[key] = value;
			shObj.flush();
		}

		/**
		 * Reades given value from SO by given key 
		 * @param key A String under which the given value is stored
		 * @return stored value as any types
		 */
		public static function read(key:String):*
		{
			var shObj:SharedObject = SharedObject.getLocal(SHARED_NAME, "/");
			return shObj.data[key];
		}
	}
}