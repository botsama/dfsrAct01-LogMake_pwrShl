# dfsrAct01-LogMake_pwrShl
Implement DFSR monitoring to collect instance details

3 events will occur:
  Get replication backlog files queue between primary and secondary DFS-R server
  Get replication backlog files queue between secondary to go back to primary DFS-R server
  Check health state of Replication folder
  
This job best works scheduled hourly from scheduled tasks (Cron for Windows).
  Advised to schedule this on your secondary DFSR server, but only needed on One of the Two servers. As the script will queue both directions and servers upon script being run

Act 02 script will perform some conditions, based off the contents of this master log file.
