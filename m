From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Nov 2011 16:34:47 -0500
Subject: LBA Range handling
In-Reply-To: <5AC4D6A45304E048A30F105EB302760902CBB0AF@CORPEXCH1.na.ads.idt.com>
References: <5AC4D6A45304E048A30F105EB302760902CBB0AF@CORPEXCH1.na.ads.idt.com>
Message-ID: <20111123213447.GB14291@linux.intel.com>

On Wed, Nov 23, 2011@10:53:37AM -0800, Kong, Kwok wrote:
> One of the purpose of the BA Range Type is to allow a driver not to
> "export" a LBA range that the driver does not understand. i.e. if a SSD
> is used in a RAID system previously,  the LBA range is configured to be
> "RAID".  When a non-RAID driver is loaded by mistake, the non-RAID
> driver should not export this LBA Range to the OS and hence the RAID
> data cannot be overwritten unexpectedly.
> 
> When a SSD is brand new, the LBA range type is going to be "Reserved" as
> it has never been used.

umm ... it is?  We should probably get the committee to change that
type 0 from Reserved (which means you can't use it) to 'Unspecified'
or something ...

> In the current linux driver, only the hidden attributes is checked.
> Should more checking be done ?
> 
> In the Windows driver, we (IDT, Intel and Sandforace) have decided to
> use the following algorithms to handle the LBA Range:
> 
> - Retrieve LBA Range entries via Get Features (ID#3) for each one of the
> namespaces;
> - Exam the first LBA Range entry of a given namespace;
> 
> if (NLB == Namespace Size)
> {
>     if (Type == 00b)
>     {
> 	  // This is a brand new disk for this driver	
>         Issue a Set Features (ID#3) command:
> 		- Type = 1 (Filesystem)
> 		- Attributes = 1 (can be overwritten, visible)
> 		- Starting LBA = 0
> 		- Number of Logical Blocks = size of the Name Space
>         Export NameSpace to the OS
>     }
>     else if (Type == 01b)
>     {
>         If (Attributes_bit_1 == 0)
>             Do not "export" NS to the OS
>         else
>         {
>             if (Attributes_bit_0 == 0)
>                "export" NS to the OS as "Read Only"
>             else
>                "export" NS to the OS
>         }
>     }
>     else
>     {
>         Do not "export" the NS to the OS;
>     }
> }
> else
> {
>     Do not "export" the NS to the OS;
> }
> 
> 
> Do you see any problem with this algorithms ?

Yes.  If the type of the LBA range is 'page cache', for example, then
it needs to be exported to the OS in order for the OS to use it.  Also,
I think you have the sense of the hidden bit wrong.  The only change
I'd make to my current algorithm is that we should probably obey the
read-only bit.

Also, I don't know how to handle multiple LBA range types yet ... they
ought to be handled through the Linux partition mechanism, but it doesn't
have any concept of devices providing their own partitioning scheme yet.

> If not, then should the linux driver match the Windows driver algorithm
> ?
> 
> Thanks
> 
> -Kwok
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
