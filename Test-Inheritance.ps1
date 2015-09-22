class Glass
{
	[int]$Size
	[int]$CurrentAmount
	
	Glass () { }
	
	Glass ([int]$Size, [int]$CurrentAmount)
	{
		$this.Size = $Size
		$this.CurrentAmount = $CurrentAmount
	}
	
	[void] Drink ($Ounces)
	{
		if ( ($this.CurrentAmount - $ounces) -ge 0)
		{
			$this.CurrentAmount -= $Ounces
		}
		else
		{
			Write-Warning "Not enough left. Only $($this.CurrentAmount)."
		}
	}
	
	[void] Fill ($Ounces)
	{
		if (($this.CurrentAmount + $ounces) -le $this.Size)
		{
			$this.CurrentAmount += $Ounces
		}
		else
		{
			Write-Warning "The glass isn't that big. Only room for $($this.Size - $this.CurrentAmount)"
		}
	}
}

class BeerGlass: Glass
{
	[int]Drink($Ounces)
	{
		([Glass]$this).Drink($Ounces)
		return $this.CurrentAmount		
	}
	
	[void]Gulp()
	{
		$this.Drink(3)	
	}		
}