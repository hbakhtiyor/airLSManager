////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.demo.views.mediators
{
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.demo.Notifications;
	import org.airlsmanager.demo.models.GeneratorDataProxy;
	import org.airlsmanager.demo.views.components.ContentHolder;
	import org.airlsmanager.demo.views.events.ApplicationEvent;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * ContentHolderMediator class 
	 */
	public class ContentHolderMediator extends Mediator
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * Constant for mediator's name.
		 * 
		 */
		public static const NAME:String = "ContentHolderMediator"
		
			
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
		 * ContentHolderMediator 
		 */
		public function ContentHolderMediator(viewComponent:ContentHolder)
		{
			super(NAME, viewComponent);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * A getter for casting viewComponet to <code>ContentHolder</code>.
		 * 
		 * @return Casts viewComponent to <code>ContentHolder</code> and returns it. 
		 * 
		 */			
		private function get component():ContentHolder
		{
			return viewComponent as ContentHolder;	
		}		
		
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
		 *  @inheritDoc
		 */
		override public function onRegister():void
		{
			super.onRegister();
			
			if(component)
			{
				component.addEventListener(ApplicationEvent.DISPLAY_BACKUP_POPUP	, onDisplayBackupPopup);
				component.addEventListener(ApplicationEvent.DISPLAY_RESTORE_POPUP	, onDisplayRestorePopup);
				component.addEventListener(ApplicationEvent.WRITE_SAMPLE_DATA		, onWriteSampleData);
				
				component.generatedDate = dataProxy.generatedDate;
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function onRemove():void
		{	
			if(component)
			{
				component.removeEventListener(ApplicationEvent.DISPLAY_BACKUP_POPUP	, onDisplayBackupPopup);
				component.removeEventListener(ApplicationEvent.DISPLAY_RESTORE_POPUP, onDisplayRestorePopup);
				component.removeEventListener(ApplicationEvent.WRITE_SAMPLE_DATA	, onWriteSampleData);
			}
			
			viewComponent = null;
			super.onRemove();
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function listNotificationInterests():Array
		{
			return [Notifications.SAMPLE_DATA_WRITED, 
				LsmNotifications.RESTORE_SUCCESSFULLY];
		}
		
		/**
		 *  @inheritDoc
		 */		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Notifications.SAMPLE_DATA_WRITED:
				case LsmNotifications.RESTORE_SUCCESSFULLY:
					component.generatedDate = dataProxy.generatedDate;
					break;
			}
		}
		
		
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
		 * Handler for <code>ApplicationEvent.WRITE_SAMPLE_DATA</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */		
		private function onWriteSampleData(event:ApplicationEvent):void
		{
			sendNotification(Notifications.WRITE_SAMPLE_DATA);			
		}
		
		/**
		 * 
		 * Handler for <code>ApplicationEvent.DISPLAY_RESTORE_POPUP</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		private function onDisplayRestorePopup(event:ApplicationEvent):void
		{
			sendNotification(LsmNotifications.DISPLAY_RESTORE_POPUP);			
		}
		
		/**
		 * 
		 * Handler for <code>ApplicationEvent.DISPLAY_BACKUP_POPUP</code> event dispatched by view.
		 * 
		 * @param event The event dispatched by view.
		 * 
		 */
		private function onDisplayBackupPopup(event:ApplicationEvent):void
		{
			sendNotification(LsmNotifications.DISPLAY_BACKUP_POPUP);	
		}		
		
	}
}