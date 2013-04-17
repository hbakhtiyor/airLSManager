////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.models
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.airlsmanager.demo.Notifications;
	import org.airlsmanager.helpers.SharedSettings;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * GeneratorDataProxy class 
	 */
	public class GeneratorDataProxy extends Proxy
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Lorem declaration
		 */
		public static const LOREM:String = 
		(<![CDATA[
			Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
			tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
			quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
			consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
			cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
			proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		]]>).toString();
				
		/**
		 * Name of Proxy class.
		 */
		public static const NAME:String = "GeneratorDataProxy";
		
		/**
		 * Key for generated date stored in SO
		 */		
		public static const GENERATED_DATE:String = "generatedDate";
			
			
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
		 * GeneratorDataProxy 
		 */
		public function GeneratorDataProxy()
		{
			super(NAME);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  generatedDate
		//----------------------------------
		/**
		 * Store last generated date to SO 
		 */			
		public function get generatedDate():Date
		{
			return SharedSettings.read(GENERATED_DATE) as Date;
		}

		/**
		 *  @private
		 */		
		public function set generatedDate(value:Date):void
		{
			SharedSettings.write(GENERATED_DATE, value);
		}

		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		/**
		 *  @private
		 */
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Write sample data to disc.
		 */		
		public function generate():void
		{
			var words:Array = LOREM.split(/\s|\W/g);
			
			for each(var directory:String in words)
			{
				if(!directory) continue;				
				for each(var fileName:String in words)
				{
					if(!fileName) continue;				
					var file:File = File.applicationStorageDirectory.resolvePath(directory + "/" + fileName + ".lorem");
					if(file.exists) continue;
					
					try
					{
						var stream:FileStream = new FileStream();
						stream.open(file, FileMode.WRITE);
						stream.writeUTF(LOREM);
						stream.close();
					}
					catch(err:Error)
					{
						stream.close();
					}
				}
			}
			
			generatedDate = new Date();
			
			sendNotification(Notifications.SAMPLE_DATA_WRITED);
		}
		
	}
}