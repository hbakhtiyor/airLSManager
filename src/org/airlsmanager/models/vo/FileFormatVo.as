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
	 * FileFormat class 
	 */
	public class FileFormatVo
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Extension of the backup .bak format. 
		 */		
		public static const BAK_EXTENSION:String = "bak";
		
		/**
		 * The delimiter separates between extension filter.
		 */		
		public static const FILTER_DELIMITER:String = ";";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * FileFormat 
		 */
		public function FileFormatVo(extension:String=null)
		{
			_extension = extension || BAK_EXTENSION;
			_extension = _extension.replace(/\./g, '');
			_type 	= "." + _extension;
			_filter = "*" + _type;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  extension
		//----------------------------------		
		/**
		 * Extension of the backup .bak format. 
		 */		
		private var _extension:String;

		public function get extension():String
		{
			return _extension;
		}

		//----------------------------------
		//  type
		//----------------------------------
		/**
		 * Type of the backup .bak format. 
		 */
		private var _type:String;

		public function get type():String
		{
			return _type;
		}

		//----------------------------------
		//  filter
		//----------------------------------
		/**
		 * Filter of the backup .bak format. 
		 */	
		private var _filter:String;

		public function get filter():String
		{
			return _filter;
		}
	}
}