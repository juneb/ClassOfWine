<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.111
	 Created on:   	2/23/2016 1:33 PM
	 Created by:   	 June Blender
	 Organization: 	SAPIEN Technologies, Inc
	 Filename:     	
===========================================================================
.DESCRIPTION
This script shows how to use the Base keyword in the constructor of a subclass
to call a constructor of a base class. 
#>


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
	
	# Methods	
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

class AnyGlass: Glass
{
	AnyGlass () {}
	
	AnyGlass ($Size, $Amount): base($Size, $Amount) { }
	
	AnyGlass ($Size): base($Size, $Size) { }
}