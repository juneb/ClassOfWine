<#
.NOTES
===========================================================================
Created with:     SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.74
Created on:       11/16/2014 1:32 PM
Organization:     SAPIEN Technologies, Inc.
Contact:          June Blender, juneb@sapien.com, @juneb_get_help
Filename:         Glass.ps1
===========================================================================
.SYNOPSIS
Creates a Glass class

.DESCRIPTION
Creates a class that represents a Glass with Size and CurrentAmount properties
and Drink and Fill methods.

This class has has a null constructor and a constructor with Size and CurrentAmount
properites.

This class is a subclass of System.Object. The class is not sealed, so you can
create glass-type subclasses from it.

.EXAMPLE
[Glass]::new()

.EXAMPLE
$myGlass = [Glass]::new(8, 6)
This example creates an 8 oz. glass with 6 oz. of fluid.

.EXAMPLE
$myGlass.Fill(2)
This command adds 2 oz. of fluid to the glass. If the glass cannot hold the 
additional amount, the command fails.

.EXAMPLE
$myGlass.Drink(2)
This command subtracts 2 oz. of fluid from the glass. If the glass has less than
the specified amount, the command fails.

.OUTPUTS
Glass
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