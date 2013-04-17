////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.views.components.popup
{
	import flash.events.MouseEvent;
	
	import mx.controls.ProgressBarMode;
	import mx.core.IButton;
	import mx.core.IVisualElement;
	import mx.managers.IFocusManagerContainer;
	
	import spark.components.SkinnableContainer;
	
	import org.airlsmanager.views.events.popup.PopupEvent;
	import org.airlsmanager.views.interfaces.popup.IBaseProgressPopup;
	

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the user selects the help button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.PopupEvent.HELP
	 */
	[Event(name="help", type="org.airlsmanager.views.events.popup.PopupEvent")]
	
	/**
	 *  Dispatched when the user selects the close button.
	 *
	 *  @eventType org.airlsmanager.views.events.popup.PopupEvent.CLOSE
	 */
	[Event(name="close", type="org.airlsmanager.views.events.popup.PopupEvent")]
	
	
	//--------------------------------------
	//  SkinStates
	//--------------------------------------
	
	/**
	 * error view state if got error
	 */	
	[SkinState("error")]
	
	/**
	 * process view state when to start restore/backup
	 */	
	[SkinState("process")]
	
	/**
	 * successful view state when successfully completed
	 */	
	[SkinState("successful")]
	
	
	/**
	 * BasePopup class 
	 */
	public class BaseProgressPopup extends SkinnableContainer implements IBaseProgressPopup, IFocusManagerContainer
	{
	
		
		//--------------------------------------------------------------------------
		//
		//  SkinParts
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  helpButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the helpButton of the component. 
		 * 
		 */		
		public var helpButton:IButton;
		
		//----------------------------------
		//  closeButton
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the closeButton of the component. 
		 * 
		 */		
		public var closeButton:IButton;
		
		//----------------------------------
		//  progressBar
		//---------------------------------- 
		
		[SkinPart(required="false")]
		
		/**
		 * 
		 * A skin part that defines the progressBar of the component. 
		 * 
		 */		
		public var progressBar:IVisualElement;
		

		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 */
		
		
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
		 * RestoreWindow 
		 */
		public function BaseProgressPopup()
		{
			super();
		}

		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  hasHelp
		//----------------------------------
		/**
		 *  @private
		 */
		private var _hasHelp:Boolean = true;
		
		/**
		 *  @private
		 */
		private var hasHelpChanged:Boolean = false;

		/**
		 *  Visible/invisible help button
		 */		
		public function get hasHelp():Boolean
		{
			return _hasHelp;
		}

		/**
		 *  @private
		 */
		public function set hasHelp(value:Boolean):void
		{
			if(_hasHelp != value)
			{
				_hasHelp = value;
				hasHelpChanged = true;
				invalidateProperties();
			}
		}

		//----------------------------------
		//  isProcess
		//----------------------------------
		/**
		 *  @private
		 */
		private var _isProcess:Boolean = false;
		
		/**
		 *  Change to process state
		 */		
		public function get isProcess():Boolean
		{
			return _isProcess;
		}
		
		/**
		 *  @private
		 */
		public function set isProcess(value:Boolean):void
		{
			if(_isProcess != value)
			{
				resetStates();
				_isProcess = value;
				invalidateSkinState();
			}
		}
		
		//----------------------------------
		//  isError
		//----------------------------------
		/**
		 *  @private
		 */		
		private var _isError:Boolean = false;
		
		/**
		 *  Change to error state
		 */		
		public function get isError():Boolean
		{
			return _isError;
		}
		
		/**
		 *  @private
		 */		
		public function set isError(value:Boolean):void
		{
			if(_isError != value)
			{
				resetStates();
				_isError = value;
				invalidateSkinState();
			}
		}
				
		//----------------------------------
		//  isSuccessful
		//----------------------------------
		/**
		 *  @private
		 */
		private var _isSuccessful:Boolean = false;
		
		/**
		 *  Change to successful state
		 */		
		public function get isSuccessful():Boolean
		{
			return _isSuccessful;
		}
		
		/**
		 *  @private
		 */		
		public function set isSuccessful(value:Boolean):void
		{
			if(_isSuccessful != value)
			{
				resetStates();
				_isSuccessful = value;
				invalidateSkinState();
			}
		}
		
		//----------------------------------
		//  errorMessage
		//----------------------------------
		/**
		 *  @private
		 */
		private var _errorMessage:String;
		
		/**
		 *  @private
		 */		
		private var errorMessageChanged:Boolean = false;
		
		/**
		 *  Common error message  
		 */		
		public function get errorMessage():String
		{
			return _errorMessage;
		}

		/**
		 *  @private
		 */
		public function set errorMessage(value:String):void
		{
			if(_errorMessage != value)
			{
				_errorMessage = value;
				errorMessageChanged = true;
				invalidateProperties();
			}
		}

				
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
		
			if(instance == helpButton)
			{
				helpButton.addEventListener(MouseEvent.CLICK, onHelpButtonClicked);
				
				helpButton.visible 			= _hasHelp;
				helpButton.includeInLayout 	= _hasHelp;
			}
			else if(instance == closeButton)
			{
				closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			else if(instance == progressBar)
			{
				if((progressBar as Object).hasOwnProperty('mode'))
					progressBar['mode'] = ProgressBarMode.MANUAL;
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override protected function partRemoved(partName:String, instance:Object):void
		{
			if(instance == helpButton)
			{
				helpButton.removeEventListener(MouseEvent.CLICK, onHelpButtonClicked);				
			}
			else if(instance == closeButton)
			{
				closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClicked);
			}
			
			super.partRemoved(partName, instance);
		}
		
		/**
		 *  @inheritDoc
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(helpButton && hasHelpChanged)
			{
				helpButton.visible 			= _hasHelp;
				helpButton.includeInLayout 	= _hasHelp;
				
				hasHelpChanged = false;
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override protected function getCurrentSkinState():String
		{
			if(isError)
				return "error";
			if(isSuccessful)
				return "successful";
			if(isProcess)
				return "process";
			return "normal";
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods : public
		//
		//--------------------------------------------------------------------------
		/**
		 * Sets the state of the bar to reflect the amount of progress made.
		 * 
		 * @param numCompelted Completed amount 
		 * @param totalCount  Total amount
		 * 
		 */		
		public function setProgress(numCompleted:Number, totalCount:Number):void
		{
			if(progressBar && (progressBar as Object).hasOwnProperty('setProgress'))
			{
				progressBar['setProgress'](numCompleted, totalCount);
			}
		}

		
		//--------------------------------------------------------------------------
		//
		//  Methods : private
		//
		//--------------------------------------------------------------------------
		/**
		 *  Reset all states, change to normal state
		 */		
		private function resetStates():void
		{
			_isError 		= false;
			_isProcess 		= false;
			_isSuccessful 	= false;
		}
		
		
		

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by helpButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by helpButton.
		 * 
		 */		
		protected function onHelpButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new PopupEvent(PopupEvent.HELP));
		}		
		
		/**
		 * 
		 * Handler for <code>MouseEvent.CLICK</code> event dispatched by closeButton.
		 * 
		 * @param event The <code>MouseEvent</code> event dispatched by closeButton.
		 * 
		 */		
		protected function onCloseButtonClicked(event:MouseEvent):void
		{
			dispatchEvent(new PopupEvent(PopupEvent.CLOSE));
		}		
	}
}