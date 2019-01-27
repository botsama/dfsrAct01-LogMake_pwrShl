$boxName = $env:COMPUTERNAME
$srcDfsSrv = "SITE-FS01"
$dstDfsSrv = "SITE-FS02"
$grpName = "SITE_FileRep"
$fldrName = "Data"
$newL = Write-Output `n
$outLogDfsr = ".\$($boxName)_DFSR_Status.log"
Filter timestamp {"Logs collected at $(Get-Date -Format "yyyy-MM-dd HH mm ss")"}


Function remoteDFSR
{
$countPdgFiles = (Get-DfsrBacklog -GroupName $grpName -FolderName $fldrName -SourceComputerName $srcDfsSrv -DestinationComputerName $dstDfsSrv -Verbose 4>&1).Message.Split(':')[2]
#Obtain files waiting to be replicated from Primary DFS server to secondary FileServer.
$sumDstSrv = $countPdgFiles + " files waiting to be written to $dstDfsSrv from $srcDfsSrv."
$sumDstSrv
}

Function primaryDFSR
{
$newL
$countClonePdg = (Get-DfsrBacklog -GroupName $grpName -FolderName $fldrName -SourceComputerName $dstDfsSrv -DestinationComputerName $srcDfsSrv -Verbose 4>&1).Message.Split(':')[2]
# Obtain pending files waiting to be written back to primary DFS server from secondary.
$sumCloneSrv = $countClonePdg + " files waiting to be written to $srcDfsSrv from $dstDfsSrv."
$sumCloneSrv
}

Function repStateFolder
{
$newL
$repStateCheck = Get-DfsReplicatedFolder | Select GroupName, FolderName, State
$repStateCheck
$newL
Timestamp | Write-Output
Write-Output ("-" * 80)
$newL
}

# Output function results to console
remoteDFSR | Write-Output
primaryDFSR | Write-Output
repStateFolder | Write-Output

# Write function results to a flat file and append results.
remoteDFSR | Out-File -Append $outLogDfsr
primaryDFSR | Out-File -Append $outLogDfsr
repStateFolder | Out-File -Append $outLogDfsr
