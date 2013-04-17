////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.models.vo
{
	

	/**
	 * SettingVo class 
	 */
	public class SettingVo
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * SettingVo 
		 */
		public function SettingVo()
		{
			backupDir 		= "My Backups";
			maxFileIndex 	= 100;
			excludeFiles 	= [];
			fileFormat 		= new FileFormatVo();			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/**
		 * Default backup directory 
		 */		
		public var backupDir:String;
		
		/**
		 * 
		 */		
		public var maxFileIndex:uint;
		
		/**
		 * Rules for excluding files 
		 */		
		public var excludeFiles:Array;
		
		/**
		 * File association format 
		 */		
		public var fileFormat:FileFormatVo;
		
		/**
		 * 
		 */		
		public var isPopupModal:Boolean = true;
		
		/**
		 * Required restart after restore data 
		 */		
		public var requiredRestart:Boolean = true;
	}
}