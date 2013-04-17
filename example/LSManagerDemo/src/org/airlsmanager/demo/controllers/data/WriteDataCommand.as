////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.controllers.data
{
	import org.airlsmanager.demo.models.GeneratorDataProxy;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * WriteDataCommand class 
	 */
	public class WriteDataCommand extends SimpleCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  dataProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>GeneratorDataProxy</code>. If proxy does not exist,
		 * register a new one.
		 */		
		private function get dataProxy():GeneratorDataProxy
		{
			if(!facade.hasProxy(GeneratorDataProxy.NAME))
				facade.registerProxy(new GeneratorDataProxy());
			
			return facade.retrieveProxy(GeneratorDataProxy.NAME) as GeneratorDataProxy;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Write demonstration sample data.
		 */
		override public function execute(notification:INotification):void
		{
			dataProxy.generate();
		}
	}
}