<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2015 v4.2.93
	 Created on:   	9/21/2015 2:39 PM
	 Created by:   	 June Blender
	 Organization: 	SAPIEN Technologies, Inc
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

enum PrimaryColor {
	
	Red
	Yellow
	Blue
}


#enum PrimaryColor {
#	
#	Red = 17
#	Yellow = 2 * 3
#	Blue = 1KB
#}

function Get-FaveColor ([PrimaryColor]$MyFave)
{	
	"My favorite color is $MyFave."
}


class Umbrella 
{
	[PrimaryColor]$UmbrellaColor
}

[PrimaryColor]$Color = 1024