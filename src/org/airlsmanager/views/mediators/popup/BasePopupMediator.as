////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.mediators.popup
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.models.manager.LocalStoreManagerProxy;
	import org.airlsmanager.views.events.popup.PopupEvent;
	import org.airlsmanager.views.interfaces.popup.IBaseProgressPopup;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * BasePopupMediator class 
	 */
	public class BasePopupMediator extends Mediator
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
		 * BasePopupMediator 
		 */
		public function BasePopupMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * A getter for casting viewComponet to <code>IBaseProgressPopup</code>.
		 * 
		 * @return Casts viewComponent to <code>IBaseProgressPopup</code> and returns it. 
		 * 
		 */		
		public function get popup() : IBaseProgressPopup
		{
			return viewComponent as IBaseProgressPopup;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : protected
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  topApplication
		//---------------------------------- 		
		/**
		 * Get the first application from <code>FlexGlobals</code>
		 */		
		protected function get topApplication():DisplayObject
		{
			return FlexGlobals.topLevelApplication as DisplayObject;
		}
		
		//----------------------------------
		//  localStoreProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreProxy</code>. If proxy does not exist,
		 * register a new one.
		 */			
		protected function get localStoreProxy():LocalStoreProxy
		{
			if(!facade.hasProxy(LocalStoreProxy.NAME))
				facade.registerProxy(new LocalStoreProxy());
			
			return facade.retrieveProxy(LocalStoreProxy.NAME) as LocalStoreProxy;
		}
		
		//----------------------------------
		//  storeManagerProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreManagerProxy</code>. If proxy does not exist,
		 * register a new one.
		 */		
		protected function get storeManagerProxy() : LocalStoreManagerProxy
		{
			if(!facade.hasProxy(LocalStoreManagerProxy.NAME))
				facade.registerProxy(new LocalStoreManagerProxy());
			
			return facade.retrieveProxy(LocalStoreManagerProxy.NAME) as LocalStoreManagerProxy;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : private
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  topApplication
		//---------------------------------- 		
		/**
		 * Get the class name from component.
		 */	
		private function get className():String
		{
			var skinnableComp:SkinnableComponent = popup as SkinnableComponent;
			var _className:String;
			
			if(skinnableComp)
				_className = skinnableComp.skin ? skinnableComp.skin.className : skinnableComp.className;
			
			return _className;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */		
		override public function onRegister():void
		{
			super.onRegister();
			
			if(popup)
			{
				popup.addEventListener(PopupEvent.CLOSE	, onClosePopup);
				popup.addEventListener(PopupEvent.HELP	, onHelpPopup);
				
				if(topApplication)
					topApplication.addEventListener(Event.RESIZE, onResizePopup);
			}
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function onRemove():void
		{
			if(popup)
			{
				popup.removeEventListener(PopupEvent.CLOSE	, onClosePopup);
				popup.removeEventListener(PopupEvent.HELP	, onHelpPopup);
				
				if(topApplication)
					topApplication.removeEventListener(Event.RESIZE, onResizePopup);

				PopUpManager.removePopUp(popup as IFlexDisplayObject);
			}
			
			viewComponent = null;
			super.onRemove();
		}
		
		/**
		 *  @inheritDoc
		 */			
		override public function listNotificationInterests():Array
		{
			return [LsmNotifications.BACKUP_ERROR,
				LsmNotifications.RESTORE_ERROR,
				LsmNotifications.BACKUP_PROGRESS,
				LsmNotifications.RESTORE_PROGRESS,
				LsmNotifications.BACKUP_SUCCESSFULLY,
				LsmNotifications.RESTORE_SUCCESSFULLY
			];
		}
		
		/**
		 *  @inheritDoc
		 */			
		override public function handleNotification(note:INotification):void
		{
			switch(note.getName())
			{
				case LsmNotifications.BACKUP_ERROR:
				case LsmNotifications.RESTORE_ERROR:
					popup.errorMessage = note.getBody() as String;
					popup.isError = true;
					break;
				case LsmNotifications.BACKUP_SUCCESSFULLY:
				case LsmNotifications.RESTORE_SUCCESSFULLY:
					popup.isSuccessful = true;
					break;
				case LsmNotifications.BACKUP_PROGRESS:
				case LsmNotifications.RESTORE_PROGRESS:
					var event:ProgressEvent = note.getBody() as ProgressEvent;
					if(event)
						popup.setProgress(event.bytesLoaded, event.bytesTotal);
					break;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * Handler for <code>Event.RESIZE</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */	
		protected function onResizePopup(event:Event):void
		{
			PopUpManager.centerPopUp(popup as IFlexDisplayObject);
		}		
		
		/**
		 * 
		 * Handler for <code>PopupEvent.HELP</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		protected function onHelpPopup(event:PopupEvent):void
		{
			sendNotification(LsmNotifications.DISPLAY_HELP_CONTENT, className);
		}
		
		/**
		 * 
		 * Handler for <code>PopupEvent.CLOSE</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		protected function onClosePopup(event:PopupEvent):void
		{
			facade.removeMediator(mediatorName);
		}
	}
}