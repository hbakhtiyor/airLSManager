////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Abd ar-Rahman (bakhtiyor.h@gmail.com)
//
// Released under the "MIT" license
//
// See LICENSE.txt for full license information.
////////////////////////////////////////////////////////////////////////////////
package org.airlsmanager.test
{
	import org.airlsmanager.controllers.common.RegisterLsmCommandsTest;
	import org.airlsmanager.controllers.common.RemoveLsmCommandsTest;
	import org.airlsmanager.controllers.help.DisplayHelpContentCommandTest;
	import org.airlsmanager.controllers.popup.DisplayBackupPopupCommandTest;
	import org.airlsmanager.controllers.popup.DisplayBackupProgressPopupCommandTest;
	import org.airlsmanager.controllers.popup.DisplayRestorePopupCommandTest;
	import org.airlsmanager.controllers.setting.SetLocalStoreSettingsTest;
	import org.airlsmanager.views.components.popup.BackupPopupTest;
	import org.airlsmanager.views.components.popup.BaseProgressPopupTest;
	import org.airlsmanager.views.mediators.popup.BackupPopupMediatorTest;
	import org.airlsmanager.views.mediators.popup.BasePopupMediatorTest;
	import org.airlsmanager.views.mediators.popup.RestorePopupMediatorTest;

	/**
	 * MainTestSuite class 
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class MainTestSuite
	{
		
		//--------------------------------------------------------------------------
		//
		//  TestCases : commands
		//
		//--------------------------------------------------------------------------
		
		public var command1:org.airlsmanager.controllers.common.RegisterLsmCommandsTest;
		public var command2:org.airlsmanager.controllers.common.RemoveLsmCommandsTest;
		public var command3:org.airlsmanager.controllers.help.DisplayHelpContentCommandTest;
		public var command4:org.airlsmanager.controllers.popup.DisplayBackupPopupCommandTest;
		public var command5:org.airlsmanager.controllers.popup.DisplayBackupProgressPopupCommandTest;
		public var command6:org.airlsmanager.controllers.popup.DisplayRestorePopupCommandTest;
		public var command7:org.airlsmanager.controllers.setting.SetLocalStoreSettingsTest;
		
		
		//--------------------------------------------------------------------------
		//
		//  TestCases : components
		//
		//--------------------------------------------------------------------------
		
		public var component1:org.airlsmanager.views.components.popup.BackupPopupTest;
		public var component2:org.airlsmanager.views.components.popup.RestorePopupTest;
		public var component3:org.airlsmanager.views.components.popup.BaseProgressPopupTest;
		
		
		//--------------------------------------------------------------------------
		//
		//  TestCases : mediators
		//
		//--------------------------------------------------------------------------
		
		public var mediator1:org.airlsmanager.views.mediators.popup.BackupPopupMediatorTest;
		public var mediator2:org.airlsmanager.views.mediators.popup.RestorePopupMediatorTest;
		public var mediator3:org.airlsmanager.views.mediators.popup.BasePopupMediatorTest;
	}
}