From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Mon, 2 Jul 2012 18:32:24 +0000
Subject: NVMe driver behaviour on LBA Range
Message-ID: <05CD7821AE397547A01AC160FBC2314704A798@corpmail1.na.ads.idt.com>

Paul and Matthew,


Both Windows and Linux driver should behave the same with LBA range data.  Before we add the support for the LBA range in Windows driver, I would like to get your opinion and agreement on what we should be doing in the driver.


This is my understanding and please let me know if you agree:

1.	By default (when a Set Feature - LBA Range has not been issued to a drive), a get feature - LBA range should return

	- Number of LBA Range (NUM) = 0 (means 1 entry)
	- Type = 0x00 (reserved)
	- Attributes - 0x01 (Read/writeable, not hidden from the OS)
	- Starting LBA = 0
	- Number of Logical Blocks (NLB) = total number of logical blocks in this namespace.
		- This should have the same size as the Namespace Size (NSZE) as returned by Identify Namespace.
	- Unique Identifier (GUID) = ??? what should this be ? Should the driver care ?

2.	When the driver get the default LBA range, it "exports" "NSZE" of LBA to the OS.

3.	What happen if the total size LBA as reported by LBA range does not match the Namespace size as reported by Identify Namespace ?
	Should the driver "export" the size as reported by Identify Namespace (NSZE) or LBA Range ? 
	I think it should be "NSZE" and not as reported by LBA range. What do you think ?

4.	When there are multiple entries in the LBA range, the driver still exports this namespace with size "NSZE" as 
	a single "LUN" with size as reported in "NSZE" except when there are ranges with "Hidden" attribute.

	ECN 25 describes the handling the hidden LBA.
	"The host storage driver should expose all LBA ranges that are not set to be hidden from the 
	OS / EFI / BIOS in the Attributes field.  All LBA ranges that follow a hidden range shall also be hidden; 
	the host storage driver should not expose subsequent LBA ranges that follow a hidden LBA range"

	The  number of logical blocks that are hidden from the OS must be deducted from "NSZE" before exporting this namespace to the OS.
	In this case, the size is smaller than "NSZE".

5.	When there are one or more ranges with attribute = 0 (Read Only), 
	the driver needs to keep track of these ranges internally.  The driver must return an error when there is a write request
	to these Read only LBA ranges.  


Please let me know what you think.

Thanks

-Kwok
	



	
