////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.models.manager
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.resources.ResourceManager;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipErrorEvent;
	import deng.fzip.FZipFile;
	
	import org.airlsmanager.consts.BundleNames;
	import org.airlsmanager.consts.LsmNotifications;
	import org.airlsmanager.helpers.ApplicationStorageDirectory;
	import org.airlsmanager.helpers.DateFormat;
	import org.airlsmanager.helpers.DirectoryNormalizer;
	import org.airlsmanager.models.LocalStoreProxy;
	import org.airlsmanager.models.vo.SettingVo;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * LocalStoreManagerProxy class 
	 */
	public class LocalStoreManagerProxy extends Proxy
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Name of Proxy class.
		 */
		public static const NAME:String = "LocalStoreManagerProxy";
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * <code>FZip</code> containing backup zip file
		 */
		private var backupZip:FZip;
		
		/**
		 * <code>File</code> containing backup zip file
		 */
		private var backupFile:File;
		
		/**
		 * <code>FZip</code> containing backup zip file
		 */
		private var restoreZip:FZip;
		
		/**
		 * <code>File</code> containing backup zip file
		 */
		private var restoreFile:File;
		
		/**
		 * 
		 */		
		private var timerProcess:Timer;
		
		/**
		 * 
		 */		
		private var onTimerProgressListener:Function;
		
		/**
		 * 
		 */		
		private var fileSelected:Boolean = false;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 * LocalStoreManagerProxy 
		 */
		public function LocalStoreManagerProxy()
		{
			super(NAME);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties : public
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  selectedFileDate
		//----------------------------------
		private var _selectedFileDate:String;		
		
		/**
		 * 
		 */
		public function get selectedFileDate():String
		{
			return _selectedFileDate;
		}
		
		//----------------------------------
		//  progressing
		//----------------------------------
		private var _progressing:Boolean = false;		

		/**
		 * 
		 */
		public function get progressing():Boolean
		{
			return _progressing;
		}
		
		//----------------------------------
		//  defaultBackupDirectory
		//----------------------------------		
		/**
		 *  @private
		 */
		public function get defaultBackupDirectory():String
		{
			return DirectoryNormalizer.normalize(File.documentsDirectory.nativePath + "/" + setting.backupDir);
		}
		
		//----------------------------------
		//  backupDirectory
		//----------------------------------		
		/**
		 *  @private
		 */
		public function get backupDirectory():String
		{
			return backupFile && backupFile.nativePath ? backupFile.nativePath.replace(backupFile.name, "") : null;
		}		
	
		
		//--------------------------------------------------------------------------
		//
		//  Properties : private
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  fileName
		//----------------------------------		
		/**
		 *  @private
		 */
		private function get fileName():String
		{
			var	name:String = backupFile.extension ? 
				backupFile.name.substring(0, backupFile.name.lastIndexOf(".")) : backupFile.name;
			
			return name + setting.fileFormat.type;
		}
		
		//----------------------------------
		//  setting
		//----------------------------------
		/**
		 * Get setting from <code>LocalStoreProxy</code>.
		 */		
		private function get setting():SettingVo
		{
			return localStoreProxy.setting;
		}
		
		//----------------------------------
		//  localStoreProxy
		//----------------------------------
		/**
		 * Retrieve instance of <code>LocalStoreProxy</code>. If proxy does not exist,
		 * register a new one.
		 */			
		private function get localStoreProxy():LocalStoreProxy
		{
			if(!facade.hasProxy(LocalStoreProxy.NAME))
				facade.registerProxy(new LocalStoreProxy());
			
			return facade.retrieveProxy(LocalStoreProxy.NAME) as LocalStoreProxy;
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
			createDicectoryIfExists();
						
			super.onRegister();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function onRemove():void
		{
			removeBackupFileListeners();
			removeRestoreFileListeners();
			backupFile = null;
			restoreFile = null;
			if(restoreZip)
			{
				removeRestoreZipListeners();
				restoreZip.close();
				restoreZip = null;
			}
			if(backupZip)
			{
				backupZip.close();
				backupZip = null;
			}
			
			clearTimer();
			onTimerProgressListener = null;
			
			super.onRemove();
		}

		
		//--------------------------------------------------------------------------
		//
		//  Methods : public
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public function browseForSave():void
		{
			// set the filename to save
			checkIfBackupFileAvailable();
			backupFile.addEventListener(Event.SELECT, onBackupFileSelect);
			backupFile.addEventListener(Event.CANCEL, onBackupFileCancel);
			
			try
			{
				// opens the file save dialog box.
				backupFile.browseForSave(ResourceManager.getInstance().getString(BundleNames.AIR_LSMANAGER, "saveBackupDailogBoxTitle")||"Save export backup");
			}
			catch(err:Error)
			{
				removeBackupFileListeners();
				backupFile = null;
				sendNotification(LsmNotifications.BACKUP_ERROR, err.message);
			}
		}
		
		/**
		 *  @private
		 */
		public function browseForOpen():void
		{
			var backupFilterDescription:String = ResourceManager.getInstance().getString(
				BundleNames.AIR_LSMANAGER, "importBackupFilterDescription", [setting.fileFormat.extension]) || "AIR Backup (" + setting.fileFormat.extension + ")";
			
			var filter:FileFilter = new FileFilter(backupFilterDescription, setting.fileFormat.filter);
			restoreFile = File.documentsDirectory.resolvePath(defaultBackupDirectory);
			restoreFile.addEventListener(Event.SELECT, onRestoreFileSelect);
			restoreFile.addEventListener(Event.CANCEL, onRestoreFileCancel);
			try
			{
				// opens the file choose dialog box.
				restoreFile.browseForOpen(ResourceManager.getInstance().getString(BundleNames.AIR_LSMANAGER, "selectBackupDailogBoxTitle")||"Select a backup", [filter]);
			}
			catch(err:Error)
			{
				removeRestoreFileListeners();
				restoreFile = null;
				sendNotification(LsmNotifications.RESTORE_ERROR, err.message);
			}
		}
		
		/**
		 *  @private
		 */
		public function restoreNow():void
		{
			if(_progressing || !fileSelected)
				return;
			
			var zipBytes:ByteArray = new ByteArray();
			
			try
			{
				var stream:FileStream = new FileStream();
				stream.open(restoreFile, FileMode.READ);
				stream.readBytes(zipBytes);
				stream.close();
			}
			catch(error:IOError)
			{
				stream.close();
				restoreFile = null;
				sendNotification(LsmNotifications.RESTORE_ERROR, error.message);
				return;
			}
			
			restoreFile = null;
			// create zip file
			restoreZip = new FZip();
			restoreZip.addEventListener(Event.COMPLETE, onZipLoadComplete);
			restoreZip.addEventListener(FZipErrorEvent.PARSE_ERROR, onZipLoadError);
			restoreZip.loadBytes(zipBytes);
			_progressing = true;
		}
		
		/**
		 *  @private
		 */
		public function backupNow():void
		{
			if(_progressing || ApplicationStorageDirectory.isEmpty())
				return;

			var stream:FileStream;
			var currentFile:File;
			var fileData:ByteArray;
			var filePath:String;
			var fileList:Array = ApplicationStorageDirectory.getFileList(setting.excludeFiles);
			var totalFileList:Number = fileList.length;
			
			if(!fileSelected && !checkIfBackupFileAvailable())
				return;
				
			// creating zip
			backupZip = new FZip();
			
			// load each file, get bytearray and add it in the zip.
			onTimerProgressListener = function (event:TimerEvent):void
			{
				if(fileList.length > 0)
				{
					fileData = new ByteArray();
					filePath = ApplicationStorageDirectory.getFilePath(fileList.shift() as String);
					sendBackupProgressNotification(totalFileList - fileList.length, totalFileList);
					currentFile = File.applicationStorageDirectory.resolvePath(filePath);
					
					try
					{
						stream = new FileStream();
						stream.open(currentFile, FileMode.READ);
						stream.readBytes(fileData, 0, currentFile.size);
						stream.close();
						
						// add file to the zipfile.		   
						backupZip.addFile(filePath, fileData);
					}
					catch(error:IOError)
					{
						clearTimer();
						stream.close();
						backupFile = null;
						sendBackupErrorNotification(error.message);
						return;
					}
					catch(error:Error)
					{
						clearTimer();
						backupFile = null;
						sendBackupErrorNotification(error.message);
						return;
					}
				}
				else
				{
					clearTimer();
					// save backup zip
					if(!backupFile)
						return;
					
					var file:File = backupFile.parent.resolvePath(fileName);
					try
					{
						stream = new FileStream;
						stream.open(file, FileMode.WRITE);
						backupZip.serialize(stream);
						stream.close();
					}
					catch(error:IOError)
					{
						stream.close();
						backupFile = null;
						sendBackupErrorNotification(error.message);
						return;
					}
					catch(error:SecurityError)
					{
						stream.close();
						backupFile = null;
						sendBackupErrorNotification(error.message);
						return;
					}
					
					// end the zip
					backupZip.close();
					backupZip  = null;
					backupFile = null;
					_progressing = false;
					fileSelected = false;
					
					// Write date of last backup to SO
//					SharedSettingsUtil.write(SharedSettingsUtil.LAST_BACKUP, currentDate());
					// send completion notification
					sendNotification(LsmNotifications.BACKUP_SUCCESSFULLY);
					facade.removeProxy(NAME);
				}
			};
			
			timerProcess = new Timer(10);
			timerProcess.addEventListener(TimerEvent.TIMER, onTimerProgressListener);
			timerProcess.start();
			_progressing = true;
		}
		
		/**
		 *  @private
		 */
		public function cancel():void
		{
			if(_progressing)
			{
				removeBackupFileListeners();
				removeRestoreFileListeners();
				if(backupFile)
					backupFile.cancel();
				if(restoreFile)
					restoreFile.cancel();
				if(restoreZip)
				{
					removeRestoreZipListeners();
					restoreZip.close();
					restoreZip = null;
				}
				if(backupZip)
				{
					backupZip.close();
					backupZip = null;
				}
				
				clearTimer();
				onTimerProgressListener = null;
				_progressing = false;
			}
			
			facade.removeProxy(NAME);
		}
		
		/**
		 * @private
		 */
		public function setRestoreFile(restoreFilePath:String):Boolean
		{
			var file:File = new File(restoreFilePath);
			if(file.exists)
			{
				restoreFile = file;
				_selectedFileDate = DateFormat.format(restoreFile.creationDate);
				fileSelected = true;
			}
			
			return file.exists;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods : private
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function getBackupFilePath(index:uint = 0):String
		{
			return DirectoryNormalizer.normalize(defaultBackupDirectory + "/backup-" + 
				DateFormat.format(new Date(), "MM.dd.yyyy") + 
				(index != 0 ? "(" + index + ")" : "") + 
				setting.fileFormat.type);
		}
		
		/**
		 * @private
		 */
		private function checkIfBackupFileAvailable():Boolean
		{
			if(!backupFile)
				backupFile = File.documentsDirectory.resolvePath(getBackupFilePath());
			
			var indexFile:uint = 1;
			while(backupFile.exists && setting.maxFileIndex > indexFile)
				backupFile = File.documentsDirectory.resolvePath(getBackupFilePath(indexFile++));
			
			if(setting.maxFileIndex < indexFile)
				return false;
			
			return true;	
		}
		
		
		/**
		 * @private
		 */
		private function clearTimer():void
		{
			if(timerProcess)
			{
				timerProcess.stop();
				timerProcess.removeEventListener(TimerEvent.TIMER, onTimerProgressListener);
				timerProcess = null;
			}
		}
		
		/**
		 * @private
		 */
		private function createDicectoryIfExists():void
		{
			var file:File = File.documentsDirectory;
			file.nativePath = defaultBackupDirectory;
			if(!file.exists)
				file.createDirectory();
		}
		
		/**
		 * @private
		 */
		private function removeRestoreZipListeners():void
		{
			if(restoreZip)
			{
				restoreZip.removeEventListener(Event.COMPLETE, onZipLoadComplete);
				restoreZip.removeEventListener(FZipErrorEvent.PARSE_ERROR, onZipLoadError);
			}
		}
		
		/**
		 * @private
		 */
		private function removeRestoreFileListeners():void
		{
			if(restoreFile)
			{
				restoreFile.removeEventListener(Event.SELECT, onRestoreFileSelect);
				restoreFile.removeEventListener(Event.CANCEL, onRestoreFileCancel);
			}
		}
		
		/**
		 * @private
		 */
		private function sendRestoreProgressNotification(bytesLoaded:Number=0, bytesTotal:Number=0):void
		{
			var event:ProgressEvent = new ProgressEvent(
				ProgressEvent.PROGRESS, false, false, bytesLoaded, bytesTotal);
			sendNotification(LsmNotifications.RESTORE_PROGRESS, event);
		}
		
		/**
		 * @private
		 */
		private function sendRestoreErrorNotification(error:String):void
		{
			if(restoreZip)
			{
				restoreZip.close();
				restoreZip = null;
			}
			_progressing = false;
			fileSelected = false;
			sendNotification(LsmNotifications.RESTORE_ERROR, error);
		}
		
		
		/**
		 * @private
		 */
		private function removeBackupFileListeners():void
		{
			if(backupFile)
			{
				backupFile.removeEventListener(Event.SELECT, onBackupFileSelect);
				backupFile.removeEventListener(Event.CANCEL, onBackupFileCancel);
			}
		}
		
		/**
		 * @private
		 */
		private function sendBackupErrorNotification(error:String):void
		{
			if(backupZip)
			{
				backupZip.close();
				backupZip = null;
			}
			_progressing = false;
			fileSelected = false;
			sendNotification(LsmNotifications.BACKUP_ERROR, error);
		}
		
		/**
		 * @private
		 */
		private function sendBackupProgressNotification(bytesLoaded:Number=0, bytesTotal:Number=0):void
		{
			var event:ProgressEvent = new ProgressEvent(
				ProgressEvent.PROGRESS, false, false, bytesLoaded, bytesTotal);
			sendNotification(LsmNotifications.BACKUP_PROGRESS, event);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Handle file canceled. Remove listeners, clean up.
		 */
		private function onBackupFileCancel(event:Event):void
		{
			removeBackupFileListeners();
			backupFile = null;
			sendNotification(LsmNotifications.BACKUP_FILE_CANCELED);
		}
		
		/**
		 * Handler for file select.
		 */		
		private function onBackupFileSelect(event:Event):void
		{
			removeBackupFileListeners();
			fileSelected = true;
			
			sendNotification(LsmNotifications.BACKUP_FILE_SELECTED);
		}
		
		
		/**
		 * Handler for successful zip load.
		 * 
		 * Write files to local disk. When complete, send notification.
		 */
		private function onZipLoadComplete(event:Event):void
		{
			removeRestoreZipListeners();
			
			// extract files, and store on disk
			var length:uint = restoreZip.getFileCount();
			var storageDirectory:String = DirectoryNormalizer.normalize(File.applicationStorageDirectory.nativePath + "/");
			var fileIndex:uint = 0;
			
			onTimerProgressListener = function (event:TimerEvent):void
			{
				if(fileIndex < length)
				{
					var zipFile:FZipFile = restoreZip.getFileAt(fileIndex++);
					sendRestoreProgressNotification(fileIndex, length);
					
					if(zipFile.sizeUncompressed > 0)
					{
						// extract the entry's data from the zip
						var file:File = File.applicationStorageDirectory.resolvePath(storageDirectory + zipFile.filename);
						try
						{
							var stream:FileStream = new FileStream();
							stream.open(file, FileMode.WRITE);
							stream.writeBytes(zipFile.content);
							stream.close();
						}
						catch(error:IOError)
						{
							clearTimer();
							stream.close();
							sendRestoreErrorNotification(error.message);
							return;
						}
						catch(error:SecurityError)
						{
							clearTimer();
							stream.close();
							sendRestoreErrorNotification(error.message);
							return;
						}
					}
				}
				else
				{
					clearTimer();
					restoreZip.close();
					restoreZip = null;
					_progressing = false;
					fileSelected = false;
					
					// Write date of last backup to SO
//					SharedSettingsUtil.write(SharedSettingsUtil.LAST_RESTORE, currentDate());
					// send completion notification
					sendNotification(LsmNotifications.RESTORE_SUCCESSFULLY);
					facade.removeProxy(NAME);
				}
			};
			
			timerProcess = new Timer(10);
			timerProcess.addEventListener(TimerEvent.TIMER, onTimerProgressListener);
			timerProcess.start();
		}
		
		
		
		/**
		 * Handle zip load error. Remove listeners, clean up, and send out error note.
		 */
		private function onZipLoadError(event:FZipErrorEvent):void
		{
			removeRestoreZipListeners();
			restoreZip.close();
			restoreZip = null;
			_progressing = false;
			fileSelected = false;
			sendNotification(LsmNotifications.RESTORE_ERROR, event.text);
		}
		
		/**
		 * Handle file canceled. Remove listeners, clean up.
		 */
		private function onRestoreFileCancel(event:Event):void
		{
			removeRestoreFileListeners();
			restoreFile = null;
			_selectedFileDate = "";
			sendNotification(LsmNotifications.RESTORE_FILE_CANCELED);
		}
		
		/**
		 * Handler for file select.
		 */		
		private function onRestoreFileSelect(event:Event):void
		{
			removeRestoreFileListeners();
			_selectedFileDate = DateFormat.format(restoreFile.creationDate);
			fileSelected = true;
			sendNotification(LsmNotifications.RESTORE_FILE_SELECTED);
		}		
	}
}