<#
.SYNOPSIS
Version: 0.8
Author: Shawn Westerhoff, MoneyGram International
Date: 10/20/17

.DESCRIPTION
loadDynatraceXML modifies the XML generated from Dynatrace dashboards for use
in MoneyGram Scalability spreadsheets.  Pipe output to Out-file as csv

.EXAMPLE
C:\PS> ./loadPurepathXML -sourceFile "C:\xml\dash1.xml"  | out-file c:\xml\test1.csv
#>


Param(
  [Parameter(Mandatory=$True,Position=1)]
   [string]$sourceFile
   #[Parameter(Mandatory=$True)]
   #[string]$filePath
)

# Comment out the parapeter above and uncomment/set the sourcefile for testing
#$sourceFile = "C:\xml\rep.xml"

# Create the XML object from the source Dynatrace dashboard export XML file specified on the commandline as a parameter
$xdoc = New-Object System.Xml.XmlDocument
$inputfile = Resolve-Path($sourceFile)
$xdoc.load($inputfile)

# Write the header row
"Agent,ResponseTime,EndTime,State"
# Iterate through each line of XML measurement and add the name of the parent
# Then write the new line with the columns you want into the destination csv file
$nodeData = $xdoc.SelectNodes("/dashboardreport/data/purepathsdashlet/purepaths/purepath")
foreach ($a in $nodeData)
{
$state = $a.state
$agent = $a.agent
$response = $a.response_time
$endtime = $a.endtime
# The name of the parent node is needed to properly label the data row
# We actually want both the parent and its parent included in the data row so we fetch that as well
# Not used in purepaths as we get the info we need in the "agent" attribute
#$p = $a.ParentNode.measure
#$pp = $a.ParentNode.ParentNode.name
"$agent,$response,$endtime,$state"
}