////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.validators
{
	import flash.filesystem.File;
	
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	/**
	 * DirectoryValidator class 
	 */
	public class DirectoryValidator extends Validator
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Indicates the error code. 
		 */
		private const ERROR_BAD_DIRECTORY:String = "BadFSDirectory"; 
		
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
		 * DirectoryValidator 
		 */
		public function DirectoryValidator()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  errorMessage
		//----------------------------------		
		private var _errorMessage:String;

		/**
		 * Provides a custom error message.
		 */
		public function get errorMessage():String
		{
			return _errorMessage;
		}

		/**
		 * @private
		 */
		public function set errorMessage(value:String):void
		{
			_errorMessage = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override protected function doValidation(value:Object):Array 
		{
			var directory:String = value as String;
			var results:Array = [];
			results = super.doValidation(value);        
			if (results.length > 0)
				return results;
			
			var file:File = File.applicationStorageDirectory.resolvePath(directory);
			if(!file.exists || !file.isDirectory) 
			{
				results.push(new ValidationResult(true, null, ERROR_BAD_DIRECTORY, _errorMessage || "Directory doesn't exist")); // "Directory doesn't exist"
				return results;
			}
			
			return results;
		}
	}
}