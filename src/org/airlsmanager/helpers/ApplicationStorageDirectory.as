////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.helpers
{
	import flash.filesystem.File;

	/**
	 * ApplicationStorageDirectory class 
	 */
	public class ApplicationStorageDirectory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Static methods : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		public static function getFileList(excludeFiles:Array=null, dirList:Array = null, folderName:String = null):Array
		{
			// path to application storage dir.
			var directory:File = folderName ? File.applicationStorageDirectory.resolvePath(folderName) : 
				File.applicationStorageDirectory;
			
			// gets a list of files and folders.
			var directoryListing:Array = directory.getDirectoryListing();
			dirList = dirList ? dirList : [];
			
			for each (var file:File in directoryListing) 
			{
				if(isExcludeFile(file.name, excludeFiles)) continue;
				
				if(!file.isDirectory)
					dirList.push(file.nativePath);
				else
					getFileList(excludeFiles, dirList, file.nativePath);				    	
			}
			
			return dirList;
		}
		
		/**
		 * @private
		 */
		public static function getFilePath(fullFilePath:String):String
		{
			var storageDirectory:String = File.applicationStorageDirectory.nativePath;
			return fullFilePath.substr(storageDirectory.length + 1, fullFilePath.length);
		}
		
		/**
		 * @private
		 */		
		public static function isEmpty():Boolean
		{
			var directoryListing:Array = File.applicationStorageDirectory.getDirectoryListing();
			return !directoryListing || directoryListing.length == 0;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Static methods : private
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */	
		private static function isExcludeFile(fileName:String, excludeFiles:Array=null):Boolean
		{
			for each(var excludeRule:String in excludeFiles)
			{
				var pattern:RegExp = new RegExp("^" + excludeRule + "$", "ig");
				if(pattern.test(fileName)) return true;
			}
			
			return false;
		}
	}
}