////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.helpers
{
	import flash.globalization.DateTimeFormatter;

	/**
	 * DateFormat class 
	 */
	public class DateFormat
	{
		

		//--------------------------------------------------------------------------
		//
		//  Static methods : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */		
		public static function format(date:Date, format:String=null):String
		{
			if(!date)
				return null;
			format = format ? format : "MM/dd/yyyy";
			var formatter:DateTimeFormatter = new DateTimeFormatter("en-US");
			formatter.setDateTimePattern(format);
			return formatter.format(date);
		}			
	}
}