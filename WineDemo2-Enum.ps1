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
        Creates a Wine class and a WineGlass class

    .DESCRIPTION
        Creates a class that represents a Wine. You can use the constructors
        to create instances of the Wine class

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
                Price = 12}


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

class Wine
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
	
	
	# Methods
	[String] toString()
	{
##		$sweet = $this.Sweetness
##		if ($sweet -like 'Very*')
##		{
##			$sweet = 'Very ' + ($this.Sweetness -split 'Very')[1]
##		}
#		
#		$sweet = $this.Sweetness
#		switch ($sweet) {
#			VerySweet { $sweet = 'Very Sweet'; break; }
#			VeryDry { $sweet = 'Very Dry'; break; }
#		}	
		
		return  "$($this.Sweetness) $($this.Color) Wine: $($this.Name) $($this.Year) by $($this.Winery). " +
		"Priced at: $("{0:C}" -f $this.Price)."
	}
}


$PSWine = [Wine]::new("PSWine", "Chateau Snover", 2012, "Red", 'Dry', 100)

$Duck = [Wine]@{
	Winery = "Escalante Winery";
	Name = "Great Duck";
	Year = 2003;
	Color = "White";
	Price = 32
	Sweetness = 3
}