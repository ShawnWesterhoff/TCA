<#
.SYNOPSIS
Version: 0.7
Author: Shawn Westerhoff, MoneyGram International
Date: 10/20/17

.DESCRIPTION
loadDynatraceXML modifies the XML generated from Dynatrace dashboards for use
in MoneyGram Scalability spreadsheets.  Pipe output to Out-file as csv

.EXAMPLE
C:\PS> ./loadDynatracecXML -sourceFile "C:\xml\dash1.xml"  | out-file c:\xml\test1.csv
#>


Param(
  [Parameter(Mandatory=$True,Position=1)]
   [string]$sourceFile
   #[Parameter(Mandatory=$True)]
   #[string]$filePath
)

# Create the XML object from the source Dynatrace dashboard export XML file specified on the commandline as a parapeter
$xdoc = New-Object System.Xml.XmlDocument
$inputfile = Resolve-Path($sourceFile)
$xdoc.load($inputfile)

# Iterate through each line of XML measurement and add the name of the parent
# Then write the new line with the columns you want into the destination csv file
$nodeData = $xdoc.SelectNodes("/dashboardreport/data/chartdashlet/measures/measure/measure/measurement")
foreach ($a in $nodeData)
{
$ts = $a.timestamp
$avg = $a.avg
# The name of the parent node is needed to properly label the data row
# We actually want both the parent and its parent included in the data row so we fetch that as well
$p = $a.ParentNode.measure
$pp = $a.ParentNode.ParentNode.measure
"Title,$pp,SubTitle,$p,TIMESTAMP,$ts,AVERAGE,$avg"
}