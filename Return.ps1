function Test-Return
{
	'This is a string.'
	return 10	
}

class ReturnTester
{
	[int32] TestReturn ()
	{
		Get-Process PowerShell
		'This is a string.'
		return 10		
	}	
}