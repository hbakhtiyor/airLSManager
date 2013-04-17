////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.views.components
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.filesystem.File;
	
	import mx.events.FlexEvent;
	
	import spark.components.WindowedApplication;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.demo.ApplicationFacade;
	import org.airlsmanager.demo.consts.FileAssociationType;
	
	/**
	 * LsmApplication class 
	 */
	public class LsmApplication extends WindowedApplication
	{

		
		//--------------------------------------------------------------------------
		//
		//  SkinParts
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  browseButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the holder of the component. 
		 * 
		 */	
		public var holder:ContentHolder;

		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>NAME</code> constatnt defines singleton key for the application and its facade
		 */ 
		public static const NAME:String = "LsmApplication";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  localStoreProxy
		//----------------------------------
		/**
		 *  @private 
		 */		
		private var _facade:ApplicationFacade;
		/**
		 * 
		 *  Reference of facade instance. 
		 */
		private function get facade():ApplicationFacade
		{
			if(!_facade)
				_facade = ApplicationFacade.getInstance(NAME) as ApplicationFacade;
			
			return _facade;
		}

		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 * LsmApplication 
		 */
		public function LsmApplication()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onApplicationCreationCompleted);
			addEventListener(InvokeEvent.INVOKE, onInvokedWithArguments);
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

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * Handler for <code>FlexEvent.CREATION_COMPLETE</code> event dispatched by application.
		 * 
		 * @param event The <code>FlexEvent</code> event dispatched by application.
		 * 
		 */			
		private function onApplicationCreationCompleted(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, onApplicationCreationCompleted);
			addEventListener(Event.CLOSING, onApplicationClosing);
			if(facade)
			{
				facade.startup(this);
			}			
		}		
		
		/**
		 * 
		 * Handler for <code>Event.CLOSING</code> event dispatched by application.
		 * 
		 * @param event The <code>Event</code> event dispatched by application.
		 * 
		 */			
		private function onApplicationClosing(event:Event):void
		{
			removeEventListener(Event.CLOSING, onApplicationClosing);
			facade.dispose(NAME);
			
			for (var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
				NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).close();			
		}
		
		/**
		 * 
		 * Handler for <code>InvokeEvent.INVOKE</code> event dispatched by application.
		 * 
		 * @param event The <code>InvokeEvent</code> event dispatched by application.
		 * 
		 */	
		private function onInvokedWithArguments(event:InvokeEvent):void 
		{
			removeEventListener(InvokeEvent.INVOKE, onInvokedWithArguments);
			var args:Array = event.arguments as Array;
			var fileToOpen:String = args ? args.shift() as String : null;
			
			if (fileToOpen && facade) 
			{
				var file:File = new File(fileToOpen);
				if(file.exists)
				{
					// type is null in MacOS
					var fileType:String = file.type || "." + file.extension;
					if(fileType == FileAssociationType.BAK_EXTENSION)
						facade.sendNotification(LsmNotifications.DISPLAY_RESTORE_POPUP, fileToOpen);
				}
			}
		}
	}
}