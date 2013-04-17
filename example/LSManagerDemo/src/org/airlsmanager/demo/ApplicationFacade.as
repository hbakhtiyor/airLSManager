////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo
{
	import org.airlsmanager.demo.controllers.common.DisposeCommand;
	import org.airlsmanager.demo.controllers.common.StartupCommand;
	import org.airlsmanager.demo.controllers.data.WriteDataCommand;
	import org.airlsmanager.demo.views.components.LsmApplication;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * ApplicationFacade class 
	 */
	public class ApplicationFacade extends Facade
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------

		
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
		 * ApplicationFacade 
		 */
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController(): void 
		{
			super.initializeController();
			
			registerCommand(Notifications.STARTUP			, StartupCommand);
			registerCommand(Notifications.DISPOSE			, DisposeCommand);
			registerCommand(Notifications.WRITE_SAMPLE_DATA	, WriteDataCommand);
		}		
		
		
		//--------------------------------------------------------------------------
		//
		//  Static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Singleton factory method
		 */
		public static function getInstance( key:String ) : ApplicationFacade 
		{
			if ( instanceMap[ key ] == null ) 
				instanceMap[ key ]  = new ApplicationFacade( key );
			
			return instanceMap[ key ] as ApplicationFacade;
		}		
	
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**  
		 *  Sends <code>Notifications.DISPOSE</code> notification,
		 *  which executes <code>DisposeCommand</code>
		 * 
		 * 	@see org.airlsmanager.demo.controllers.common.DisposeCommand
		 */ 
		public function dispose(key:String):void
		{
			sendNotification(Notifications.DISPOSE, key);
		}
		
		/**
		 *  Starts the application
		 *  Sends <code>Notifications.DISPOSE</code> notification,
		 *  which executes <code>DisposeCommand</code>
		 * 
		 * 	@see org.airlsmanager.demo.controllers.common.DisposeCommand; 
		 */
		public function startup(app:LsmApplication):void
		{
			sendNotification(Notifications.STARTUP, app);
		}	
	}
}