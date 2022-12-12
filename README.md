[![Board Status](https://dev.azure.com/secondraw/5bbf8443-7599-4324-b501-11880661b1ae/4c9b1020-bb63-4fb4-a4fc-a18fb697f662/_apis/work/boardbadge/9cd4f7b2-1c79-4cef-9552-9c0fd7ed7914)](https://dev.azure.com/secondraw/5bbf8443-7599-4324-b501-11880661b1ae/_boards/board/t/4c9b1020-bb63-4fb4-a4fc-a18fb697f662/Microsoft.RequirementCategory)
# dfsrAct01-LogMake_pwrShl
Implement DFSR monitoring to collect instance details

3 events will occur:
  Get replication backlog files queue between primary and secondary DFS-R server
  Get replication backlog files queue between secondary to go back to primary DFS-R server
  Check health state of Replication folder
  

[Act 02](https://github.com/botsama/dfsrAct02-LogAction_pwrShl) script will perform some conditions, based off the contents of this master log file.  
This Act01 file generates the logs, used by [Act 02 script](https://github.com/botsama/dfsrAct02-LogAction_pwrShl)
This job best works scheduled hourly from scheduled tasks (Cron for Windows, essentially).

Advised to schedule this on your secondary DFSR server, but only needed on One of the Two servers. As the script will queue both directions and servers upon script being run

In case you wonder what DFS-R is, it is Microsoft's Distributed File System Replication.
https://docs.microsoft.com/en-us/powershell/module/dfsr/?view=win10-ps

**For Server 2012 non-R2 lacking PowerShell DFSR utilities**

Post Server 2012-R2 editions have really robust powershell support but these scripts are tooled for compatibility with Server 2012-Non R2 support by polling DFSR state with OS-level commands and building log history.
