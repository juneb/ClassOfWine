<#
	.SYNOPSIS
		Creates a Glass class
	
	.DESCRIPTION
		This version of the Glass class prevents you from creating a glass where
        current amount of liquid > size of glass.

        ----------------------

		Creates a class that represents a Glass with Size and CurrentAmount properties
		and Drink and Fill methods.
		
		This class has has a null constructor and a constructor with Size and CurrentAmount
		properites.
		
		This class is a subclass of System.Object. The class is not sealed, so you can
		create glass-type subclasses from it.
	
	.PARAMETER Name
		A description of the Name parameter.
	
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
	
	.NOTES
		===========================================================================
		Created with:     SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.74
		Created on:       11/16/2014 1:32 PM
		Organization:     SAPIEN Technologies, Inc.
		Contact:          June Blender, juneb@sapien.com, @juneb_get_help
		Filename:         Glass.ps1
		===========================================================================
#>
# Questions? Read the help ^^^
class Glass
{
	# Properties
	[int32]$Size
	
	# I made this hidden because the user can use Drink() and 
	# Fill() to control the amount. They don't need to set it directly.
	hidden [int32]$CurrentAmount
	
	# You can't use ValidateRange to restrict the $CurrentAmount value, 
	# because it requires a constant.
	#   [ValidateRange(0, $this.Size)][int32]$CurrentAmount
	
	
	# Constructors	
	
	# The default constructor is included, because it's required for inheritance.
	# To create a subclass, the base class must have a default constructor.
	# PowerShell 5.0.10586.122
	Glass () { }
	
	Glass ([int32]$Size)
	{
		$this.Size = $Size
	}
	
	# This works, but only when you use it to create a new object.
	# To be a base class, you need a default constructor.
	#	Glass ([int32]$Size, [int32]$Amount)
	#	{
	#		$this.Size = $Size
	#		if ($Amount -gt $Size)
	#		{
	#			$this.CurrentAmount = $Size
	#		}
	#		else
	#		{
	#			$this.CurrentAmount = $Amount	
	#		}
	#	}
	
	# Methods	
	[int32] Fill ([int32]$volume)
	{
		if ($this.currentAmount + $volume -le $this.Size)
		{
			$this.CurrentAmount += $volume
		}
		else
		{
			Write-Warning "Sorry. The glass isn't big enough. You have room for $($this.Size - $this.CurrentAmount)."
		}
		return $this.CurrentAmount
	}
	
	[int32] Drink ([int32]$amount)
	{
		if ($this.CurrentAmount - $amount -ge 0)
		{
			$this.CurrentAmount -= $amount
		}
		elseif ($this.CurrentAmount -eq 0)
		{
			Write-Warning "Glass is empty. Time to refill."
		}
		else
		{
			Write-Warning "Not enough left. Only $($this.CurrentAmount)..."
		}
		return $this.CurrentAmount
	}
	
	# This takes the place of the visible CurrentAmount property.
	# It's not as convenient.
	[int32] getCurrentAmount ()
	{
		return $this.CurrentAmount
	}
	
	
	# No, you can't override an accessor method
	#	[void] set_CurrentAmount ($Amount)
	#	{
	#		if ($Amount -gt $this.Size)
	#		{
	#			Write-Error "The $($this.Size)-oz. glass can't hold	that much liquid."
	#		}
	#		else
	#		{
	#			$this.CurrentAmount = $Amount
	#		}		
	#	}
}