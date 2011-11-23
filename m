From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Wed, 23 Nov 2011 10:53:37 -0800
Subject: LBA Range handling 
Message-ID: <5AC4D6A45304E048A30F105EB302760902CBB0AF@CORPEXCH1.na.ads.idt.com>

Matthew,

One of the purpose of the BA Range Type is to allow a driver not to
"export" a LBA range that the driver does not understand. i.e. if a SSD
is used in a RAID system previously,  the LBA range is configured to be
"RAID".  When a non-RAID driver is loaded by mistake, the non-RAID
driver should not export this LBA Range to the OS and hence the RAID
data cannot be overwritten unexpectedly.

When a SSD is brand new, the LBA range type is going to be "Reserved" as
it has never been used.

In the current linux driver, only the hidden attributes is checked.
Should more checking be done ?

In the Windows driver, we (IDT, Intel and Sandforace) have decided to
use the following algorithms to handle the LBA Range:

- Retrieve LBA Range entries via Get Features (ID#3) for each one of the
namespaces;
- Exam the first LBA Range entry of a given namespace;

if (NLB == Namespace Size)
{
    if (Type == 00b)
    {
	  // This is a brand new disk for this driver	
        Issue a Set Features (ID#3) command:
		- Type = 1 (Filesystem)
		- Attributes = 1 (can be overwritten, visible)
		- Starting LBA = 0
		- Number of Logical Blocks = size of the Name Space
        Export NameSpace to the OS
    }
    else if (Type == 01b)
    {
        If (Attributes_bit_1 == 0)
            Do not "export" NS to the OS
        else
        {
            if (Attributes_bit_0 == 0)
               "export" NS to the OS as "Read Only"
            else
               "export" NS to the OS
        }
    }
    else
    {
        Do not "export" the NS to the OS;
    }
}
else
{
    Do not "export" the NS to the OS;
}


Do you see any problem with this algorithms ?

If not, then should the linux driver match the Windows driver algorithm
?

Thanks

-Kwok
