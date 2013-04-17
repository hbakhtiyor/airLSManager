////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.helpers
{
	import flash.system.Capabilities;

	/**
	 * DirectoryNormalizer class 
	 */
	public class DirectoryNormalizer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Static methods : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		public static function normalize(path:String):String
		{
			if(!path)
				return null;
			
			if(isWindows)
				return path.replace(/\//ig, "\\");
			else
				return path.replace(/\\/ig, "/");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Static methods : private
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Returns true if os is windows
		 */		
		private static function get isWindows():Boolean
		{
			return Capabilities.os.toLowerCase().indexOf( "windows" ) != -1; 			
		}
		
	}
}