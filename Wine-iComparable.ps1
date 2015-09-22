enum WineSweetness
{
	VeryDry = 1
	Dry = 2
	Moderate = 3
	Sweet = 4
	VerySweet = 5
}


class Wine: iComparable
{
	#*************#
	# Properties  #
	#*************#
	[String]$Name
	[String]$Winery
	[Int]$Year
	[ValidateSet("Red", "White", "Rose")][String]$Color
	[WineSweetness]$Sweetness
	[Uint32]$Price = 0.0
	
	
	
	#****************#
	# #Constructors  #
	#****************#
	
	
	# Default - Automatic in PS
	Wine () { }
	
	# Simple: Takes name
	Wine ([String]$Name)
	{
		$this.Name = $Name
	}
	
	
	# Takes all properties
	Wine (
	[String]$Name,
	[String]$Winery,
	[Int]$Year,
	[ValidateSet("Red", "Rose", "White")][String]$Color,
	[WineSweetness]$Sweetness,
	[Uint32]$Price
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
	
	
	
	#****************#
	#    Methods     #
	
	
	# Override: Returns a human-readable string.
	[String] toString()
	{
		return "$($this.Sweetness) $($this.Color) Wine: $($this.Name) $($this.Year) by $($this.Winery)." +
		" Priced at: $("{0:C}" -f $this.Price)."
	}
	
	
#	[int] CompareTo ([Object]$otherWine)
#	{
#		if (!($otherWine.Year)) { return [Int]::MaxValue }
#		
#		return $this.Year.CompareTo($otherWine.Year)
#	}
	
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
	
} #endClass


$PrimalSyrah = [Wine]::new("PrimalSyrah")
$PrimalSyrah.Color = "Red"
$PrimalSyrah.Winery = "SAPIEN Vineyards"
$PrimalSyrah.Year = 1990
$PrimalSyrah.Sweetness = 1
$PrimalSyrah.Price = 36


$PSWine = [Wine]::new("PSWine", "Chateau Snover", "2012", "Red", "Dry", 40)

#Using null constructor and hashtable
$Duck = [Wine]@{
	Name = "Great Duck";
	Winery = "Escalante Winery";
	Year = "2003";
	Color = "White";
	Sweetness = 4;
	Price = 22
}

[Wine].GetInterfaces()