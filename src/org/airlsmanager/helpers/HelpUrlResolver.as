////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.helpers
{
	import mx.core.ByteArrayAsset;
	
	
	/**
	 * HelpUrlResolver provides info help to application's view.
	 */ 
	public class HelpUrlResolver
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Default format of the help. 
		 */		
		public static const DEFAULT_FORMAT:String 	= "htm";
		
		/**
		 * Default path of the help. 
		 */		
		public static const DEFAULT_PATH:String 	= "help/";
		
		/**
		 * Default help file
		 */		
		public static const DEFAULT_HELP_FILE:String = "Welcome.htm";
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  xml file containing help attributes
		 */
		[Embed("/assets_embed/xml/helps.xml", mimeType="application/octet-stream")]
		private static const HelpXML:Class;
		
		/**
		 * XML instance which holds helps xml
		 */ 
		public static var helps:XML;
		
		/**
		 * static instance of the class for singleton
		 */ 
		private static var instance:HelpUrlResolver;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Chesk if it is called directly and throws Singleton Error
		 * Populates helps xml from embbeded xml asset
		 */ 		
		public function HelpUrlResolver(classLock:SingletonLock)
		{
			if(classLock == null) 
				throw new Error("Private constructor. Use SingletonLock.getInstance() instead.");
			
			init();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  format
		//----------------------------------		
		/**
		 * Format of the help. e.g. html, htm, txt, ... 
		 */		
		private var _format:String;

		/**
		 * @private 
		 */		
		public function get format():String
		{
			return _format;
		}

		//----------------------------------
		//  path
		//----------------------------------		
		/**
		 * Path of the help files. e.g. /your_helps_dir/ 
		 */		
		private var _path:String;

		/**
		 * @private 
		 */		
		public function get path():String
		{
			return _path;
		}

		
		//--------------------------------------------------------------------------
		//
		//  Static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Class method for getting singleton insatnce of the class 
		 */ 
		public static function getInstance():HelpUrlResolver
		{
			if(instance == null)
				instance = new HelpUrlResolver(new SingletonLock());
			return instance;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @param screenName A String containig name of a view, for example <code>ConfigurationPopup</code>
		 * @return String url of  help for given screenName
		 */ 
		public function getUrlByScreenName(screenName:String):String
		{
			if(!screenName)
				throw new ArgumentError("Parameter screenName can not be null or empty");
			
			var xml:XML = getElementByAttribute("screenName", screenName) ;
			
			return xml && xml.@url ? xml.@url : screenName;
		}
		
		/**
		 * @private 
		 */		
		public function normalizeUrl(url:String, locale:String, format:String = null, path:String = null):String
		{
			if(!url)
				return "";
			
			// set default values if don't exist 
			format 	= format 	|| _format;
			path 	= path 		|| _path;
			
			format = "." + format;
			
			url = url.replace(format, "");
			url = url.replace(path, "");
			url = url.replace(locale + "/", "");
			
			return path + locale + "/" + url + format;			
		}
		
		/**
		 * @private 
		 */
		public function hasFormat(helpUrl:String):Boolean
		{
			return  helpUrl.lastIndexOf(".htm") != -1 || helpUrl.lastIndexOf(".html") != -1
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods : private
		//
		//--------------------------------------------------------------------------
		
		/**
		 * A utility method for validating existence of given attibute in xml element 
		 * @param attrName Name of attribute
		 * @param param value of attribute
		 * @return xml contaning given attribute or <code>null</code>
		 */		
		private function getElementByAttribute(attrName:String, param:String):XML
		{
			var xml:XMLList = helps.help.(attribute(attrName) == param);
			return xml && xml.length()> 0 ? XML(xml[0]): null;
		}
		
		/**
		 * @private 
		 */
		private function init():void
		{
			var ba:ByteArrayAsset = ByteArrayAsset(new HelpXML());
			helps = XML(ba.readUTFBytes(ba.length));
			
			_format = helps.@format || DEFAULT_FORMAT;
			_path 	= helps.@path	|| DEFAULT_PATH;
		}
	}
}
class SingletonLock { }