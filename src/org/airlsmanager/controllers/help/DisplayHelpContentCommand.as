////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.controllers.help
{
	import mx.resources.ResourceManager;
	
	import org.airlsmanager.controllers.BaseCommand;
	import org.airlsmanager.helpers.HelpUrlResolver;
	import org.airlsmanager.views.mediators.window.WindowMediator;
	import org.airlsmanager.views.windows.HelpWindow;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * ShowHelpCommand class 
	 */
	public class DisplayHelpContentCommand extends BaseCommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  windowMediator
		//---------------------------------- 
		/**
		 * Retrieve instance of <code>WindowMediator</code>. If proxy does not exist,
		 * register a new one.
		 */		
		private var _windowMediator:WindowMediator;

		private function get windowMediator():WindowMediator
		{
			if(!facade.hasMediator(WindowMediator.NAME))
				facade.registerMediator(new WindowMediator());
			
			return facade.retrieveMediator(WindowMediator.NAME) as WindowMediator;
		}

		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Launch help window
		 */ 
		override public function execute(note:INotification):void
		{
			var urlResolver:HelpUrlResolver = HelpUrlResolver.getInstance();			
			var helpUrl:String = note.getBody() as String || HelpUrlResolver.DEFAULT_HELP_FILE;
			
			if(!urlResolver.hasFormat(helpUrl))
			{
				helpUrl = helpUrl.replace(/Skin$/g, ''); // remove skin substring if it gets from skin.className
				helpUrl = urlResolver.getUrlByScreenName(helpUrl);
			}
			
			var locale:String = ResourceManager.getInstance().localeChain[0] as String;
			helpUrl = urlResolver.normalizeUrl(helpUrl, locale);			
			
			if(windowMediator.helpWindow == null)
			{
				var window:HelpWindow = new HelpWindow();
				window.url = helpUrl;
				windowMediator.helpWindow = window;
				window.open();
			}
			else
			{
				windowMediator.helpWindow.url = helpUrl;
				windowMediator.helpWindow.orderToFront();
			}
		}
		
	}
}