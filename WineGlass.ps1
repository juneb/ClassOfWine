<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2015 v4.2.93
	 Created on:   	9/9/2015 8:58 AM
	 Created by:   	 June Blender
	 Organization: 	SAPIEN Technologies, Inc
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
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
		return "$($this.Sweetness) $($this.Color) Wine: $($this.Name) $($this.Year) by $($this.Winery)." +
		" Priced at: $("{0:C}" -f $this.Price)."
	}
	
	static [Boolean] IsAged ([Wine]$Wine)
	{
		return (((Get-Date).Year - $Wine.Year) -ge 10)
	}
	
	[int] CompareTo ([Object]$otherWine)
	{
		if (!($otherWine.Year)) { return [Int]::MaxValue }
		
		return $this.Year.CompareTo($otherWine.Year)
	}
}

class Glass
{
	# Properties
	[int32]$Size
	[int32]$CurrentAmount
	
	# Constructors
	
	Glass () { }
	
	Glass ($Size, $Amount)
	{
		$this.Size = $Size
		$this.CurrentAmount = $Amount
	}
	
	[Boolean] Fill ([int32]$volume)
	{
		if ($this.currentAmount + $volume -le $this.Size)
		{
			$this.CurrentAmount += $volume
			return $true
		}
		else
		{
			Write-Warning "Sorry. The glass isn't big enough. You have room for $($this.Size - $this.CurrentAmount)."
			return $false	
		}
	}
	
	[Boolean] Drink ([int32]$amount)
	{
		if ($this.CurrentAmount - $amount -ge 0)
		{
			$this.CurrentAmount -= $amount
			return $true
		}
		elseif ($this.CurrentAmount -eq 0)
		{
			Write-Warning "Glass is empty. Time to refill."
			return $false
		}
		else
		{
			Write-Warning "Not enough left. Only $($this.CurrentAmount)..."
			return $false
		}
		
	}
}

class WineGlass: Glass
{
	#Properties
	[Wine]$Wine
	
	#Hidden properties
	hidden [Int]$Consumed
	hidden [Int]$TotalPoured
	
	
	#Constructors
	WineGlass () { }
	
	WineGlass ([Wine]$Wine, [int]$Size, [int]$Pour)
	{
		$this.Wine = $Wine
		$this.Size = $Size
		$this.CurrentAmount = $Pour
		$this.TotalPoured = $Pour
	}
	
	#Methods
	
	[void] Drink ([int32]$Ounces)
	{
		if (([Glass]$this).Drink($Ounces))
		{
			$this.Consumed += $Ounces
		}
	}
	
	Sip()
	{
		$this.Drink(1)
	}
	
	[void] Fill ([int32]$volume)
	{
		if (([Glass]$this).Fill($volume))
		{
			$this.TotalPoured += $volume
		}			
	}
	
	Refill ()
	{
		$this.Fill($this.Size - $this.CurrentAmount)
	}
	
	[Boolean] IsTipsy ()
	{
		return ($this.Consumed -ge 20)		
	}
	
	[String] GetCheck ()
	{
		# Standard bottle = 25 oz = 750 ml
		return "{0:C}" -f ([System.Math]::Ceiling($this.TotalPoured / 25) * $this.Wine.Price)
	}
	
	[String] toString ()
	{
		return "My $($this.Size)-oz. wine glass contains $($this.CurrentAmount) oz. of $($this.Wine.Name) by $($this.Wine.Winery)."
	}
}



$PSWine = [Wine]::new('PSWine', 'Chateau Snover', 2006, 'Red', 'Dry', 100)

$myWineGlass = [WineGlass]::new($PSWine, 6, 0)