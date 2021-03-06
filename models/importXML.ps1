$xdoc = New-Object System.Xml.XmlDocument
$file = Resolve-Path("C:\Users\yb66\Documents\Projects\2x3x10x\report_2017-09-08_11-16-13_2047028650350800033.xml")

$xdoc.load($file)

$xdoc.dashboardreport.data.chartdashlet.measures

#$xdoc.SelectNodes("//measures/measure/measure")
#$xdoc.SelectSingleNode("//measures/measure/measure[6]/measurement/timestamp")
#$xdoc.SelectSingleNode("//measures/measure/measure[6]/measurement")

$xdoc.SelectNodes("//measures/measure/measure/measurement/attribute::*")

$xdoc.SelectNodes("//measures/measure/measure/measurement/attribute::*")

#init an array
$objs = @()
$nodes = $xdoc.SelectNodes("//*[@timestamp]")
foreach ($node in $nodes) {
    $time = $node.attributes['timestamp'].value
    $avg = $node.attributes['avg'].value
    #$obj = new-object psobject -prop @{TIMESTAMP=$time;AVERAGE=$avg}
    #$objs += $obj
    $time $avg
}
$objs

