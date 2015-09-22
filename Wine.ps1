<#
    .NOTES
    ===========================================================================
     Created with:     SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.74
     Created on:       11/16/2014 1:32 PM
     Organization:     SAPIEN Technologies, Inc.
     Contact:          June Blender, juneb@sapien.com, @juneb_get_help
     Filename:         Wine.ps1
    ===========================================================================
    .SYNOPSIS
        Creates a Wine class

    .DESCRIPTION
        Creates a class that represents a Wine. 

		Includes: 
		--	A ToString method (override) that returns a string that describes the wine.
		--  A constructor that converts a deserialized object to a Wine object.
		--  The Wine class supports iComparable. Its CompareTo method compares the age of two wines.
        

    .EXAMPLE
        [Wine]::new()
        
    .EXAMPLE
        [Wine]::new("Great Duck")

    .EXAMPLE
        $PSWine = [Wine]::new("PSWine", "Chateau Snover", "2012", $False, "Red", 1, "Pithy", 98)

    .EXAMPLE
        $Duck = [Wine]@{Name="Great Duck"; 
                Winery="Escalante Winery"; 
                Year="2003"; 
                isSparkling = $True; 
                Color = "White"; 
                Sweetness = 1; 
                Description= "Rich and magnificent"; 
                Price = 32}
    .EXAMPLE
		$Duck.CompareTo($myWine)
		-1

	.EXAMPLE
		$Duck.ToString()
		Sparkling VeryDry White Wine: Great Duck 2003 by Escalante Winery. Described as: Rich and magnificent. Priced at: $32.00.


	.EXAMPLE
		$Duck | Export-Clixml -Path Wine.xml
        $newDuck = Import-Clixml -Path Wine.xml | Foreach { [Wine]::new( $_ ) }

    .OUTPUTS
        Wine
#>


enum WineSweetness
{
	VeryDry
	Dry
	Medium
	Sweet
	VerySweet
}



class Wine: iComparable
{
	# Properties
	[String]$Name
	[String]$Winery
	[Int32]$Year
	[ValidateSet("Red", "White", "Rose")][String]$Color
	[WineSweetness]$Sweetness
	[Double]$Price = 0.0
	
	
	# Constructors
	Wine() { }
	
	Wine ([String]$Name)
	{
		$this.Name = $Name
	}
	
	Wine (
	[String]$Name,
	[String]$Winery,
	[Int32]$Year,
	[ValidateSet("Red", "White", "Rose")][String]$Color,
	[WineSweetness]$Sweetness,
	[Double]$Price
	)
	{
		$this.Name = $Name
		$this.Winery = $Winery
		$this.Year = $Year
		$this.Color = $Color
		$this.Sweetness = $Sweetness
		$this.Price = $Price
	}
	
	# Converts deserialized objects
	Wine ([PSObject]$InputObject)
	{
		$this.Name = $InputObject.Name
		$this.Winery = $InputObject.Winery
		$this.Year = $InputObject.Year
		$this.Color = $InputObject.Color
		$this.Sweetness = $InputObject.Sweetness
		$this.Price = $InputObject.Price
	}
	
	# Methods
	[String] toString()
	{
		return  "$($this.Sweetness) $($this.Color) Wine: $($this.Name) $($this.Year) by $($this.Winery)." +
		" Priced at: $("{0:C}" -f $this.Price)."
	}
	
	static [Boolean] IsAged ([Wine]$Wine)
	{
		return (((Get-Date).Year - $Wine.Year) -ge 10)
	}
	
	
	[int] CompareTo ([Object]$otherWine)
	{
		if (!($otherWine.Price)) { return [Int]::MaxValue }
		
		return $this.Price.CompareTo($otherWine.Price)
	}
	
	
	#	[int] CompareTo ([Object]$otherWine)
	#	{
	#		if (!($otherWine.Year)) { return [int]::MaxValue }
	#		if ($this.Year -lt $otherWine.Year)
	#		{
	#			return -1
	#		}
	#		elseif ($this.Year -gt $otherWine.Year)
	#		{
	#			return 1
	#		}
	#		else
	#		{
	#			return 0
	#		}
	#	}
}




$PSWine = [Wine]::new("PSWine", "Chateau Snover", 2006, "Red", 'Dry', 40)

$Duck = [Wine]@{
	Sweetness = 0
	Name = "Great Duck";
	Winery = "Escalante Winery";
	Year = 2003;
	Color = "White";
	Price = 32
}

$Path = 'C:\ps-test\Wine\Wine.xml'
$PSWine, $Duck | Export-Clixml -Path $Path
$myXMLWines = Import-Clixml -Path $Path | foreach {[Wine]::New($_)}