////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo
{
	

	/**
	 * Constants class 
	 */
	public class Notifications
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * The <code>STARTUP</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>STARTUP</code> notification invokes <code>StartupCommand</code></p>
		 *  
		 * @see  org.airlsmanager.demo.controllers.common.StartupCommand
		 */
		public static const STARTUP:String = "startup";
		
		/**
		 * The <code>DISPOSE</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>DISPOSE</code> notification invokes <code>DisposeCommand</code></p>
		 *  
		 * @see  org.airlsmanager.demo.controllers.common.DisposeCommand
		 */		
		public static const DISPOSE:String = "dispose";
		
		/**
		 * The <code>WRITE_SAMPLE_DATA</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 * <p>The <code>WRITE_SAMPLE_DATA</code> notification invokes <code>WriteDataCommand</code></p>
		 *  
		 * @see  org.airlsmanager.demo.controllers.data.WriteDataCommand
		 */		
		public static const WRITE_SAMPLE_DATA:String = "writeSampleData";
		
		/**
		 * The <code>SAMPLE_DATA_WRITED</code> constant 
		 * defines the value of <code>name</code> property of the notification.
		 * 
		 */		
		public static const SAMPLE_DATA_WRITED:String = "sampleDataWrited";			
	}
}