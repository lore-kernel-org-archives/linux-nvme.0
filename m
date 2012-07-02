From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Mon, 2 Jul 2012 21:35:47 +0000
Subject: NVMe driver behaviour on LBA Range
In-Reply-To: <82C9F782B054C94B9FC04A331649C77A028E9A5B@FMSMSX106.amr.corp.intel.com>
References: <05CD7821AE397547A01AC160FBC2314704A798@corpmail1.na.ads.idt.com>
 <82C9F782B054C94B9FC04A331649C77A028E95CC@FMSMSX106.amr.corp.intel.com>
 <05CD7821AE397547A01AC160FBC2314704A8AA@corpmail1.na.ads.idt.com>
 <B58D82457FDA0744A320A2FC5AC253B90D42B9E6@FMSMSX105.amr.corp.intel.com>
 <05CD7821AE397547A01AC160FBC2314704A8CD@corpmail1.na.ads.idt.com>
 <82C9F782B054C94B9FC04A331649C77A028E9A5B@FMSMSX106.amr.corp.intel.com>
Message-ID: <05CD7821AE397547A01AC160FBC2314704A8F7@corpmail1.na.ads.idt.com>

Sure.

-Kwok

-----Original Message-----
From: Luse, Paul E [mailto:paul.e.luse@intel.com] 
Sent: Monday, July 02, 2012 2:11 PM
To: Kong, Kwok; Busch, Keith; Matthew Wilcox
Cc: nvmewin at lists.openfabrics.org; linux-nvme at lists.infradead.org
Subject: RE: NVMe driver behaviour on LBA Range

I'm thinking email is going to be a pretty inefficient way to handle this now that we've traded a few.  Kwok, maybe you can write up a list of use cases along with a section/column for spec interpretation and one for expected behavior of the standard drivers.  Then we can setup a call to discuss each one as there will be lots of discussion on each item that really requires real time conversation I think.

Thx
Paul

-----Original Message-----
From: Kong, Kwok [mailto:Kwok.Kong@idt.com] 
Sent: Monday, July 02, 2012 2:09 PM
To: Busch, Keith; Luse, Paul E; Matthew Wilcox
Cc: nvmewin at lists.openfabrics.org; linux-nvme at lists.infradead.org
Subject: RE: NVMe driver behaviour on LBA Range

Keith,

I agree that overlapping LBA ranges would be a spec violation and is an error.  
What should the driver do when there are overlapping LBA ranges ?


-Kwok

-----Original Message-----
From: Busch, Keith [mailto:keith.busch@intel.com] 
Sent: Monday, July 02, 2012 2:04 PM
To: Kong, Kwok; Luse, Paul E; Matthew Wilcox
Cc: nvmewin at lists.openfabrics.org; linux-nvme at lists.infradead.org
Subject: RE: NVMe driver behaviour on LBA Range

KK>  I think the LBA Range causes a lot of confusions.  What happen if there are multiple ranges and the ranges overlaps ?

Overlapping LBA ranges would be a spec violation.

-----Original Message-----
From: linux-nvme-bounces@lists.infradead.org [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Kong, Kwok
Sent: Monday, July 02, 2012 2:48 PM
To: Luse, Paul E; Matthew Wilcox
Cc: nvmewin at lists.openfabrics.org; linux-nvme at lists.infradead.org
Subject: RE: NVMe driver behaviour on LBA Range

Paul,

Please see below for my comment

-----Original Message-----
From: Luse, Paul E [mailto:paul.e.luse@intel.com] 
Sent: Monday, July 02, 2012 12:36 PM
To: Kong, Kwok; Matthew Wilcox
Cc: linux-nvme at lists.infradead.org; nvmewin at lists.openfabrics.org
Subject: RE: NVMe driver behaviour on LBA Range

Kwok-

See below for my thoughts

Thx
Paul

-----Original Message-----
From: Kong, Kwok [mailto:Kwok.Kong@idt.com] 
Sent: Monday, July 02, 2012 11:32 AM
To: Luse, Paul E; Matthew Wilcox
Cc: linux-nvme at lists.infradead.org; nvmewin at lists.openfabrics.org
Subject: NVMe driver behaviour on LBA Range

Paul and Matthew,


Both Windows and Linux driver should behave the same with LBA range data.  Before we add the support for the LBA range in Windows driver, I would like to get your opinion and agreement on what we should be doing in the driver.

PL>  For sure.  Currently I believe the windows driver is handling this incorrectly and am coincidentally (to your email) working on fixing that now and will propose a patch shortly (that can be discussed of course if we don't like where its heading).

This is my understanding and please let me know if you agree:

1.	By default (when a Set Feature - LBA Range has not been issued to a drive), a get feature - LBA range should return

	- Number of LBA Range (NUM) = 0 (means 1 entry)
	- Type = 0x00 (reserved)
	- Attributes - 0x01 (Read/writeable, not hidden from the OS)
	- Starting LBA = 0
	- Number of Logical Blocks (NLB) = total number of logical blocks in this namespace.
		- This should have the same size as the Namespace Size (NSZE) as returned by Identify Namespace.
	- Unique Identifier (GUID) = ??? what should this be ? Should the driver care ?

PL>  The definition of "by default" totally depends on the manufacturer of the device.  The case you mention above is what I would call the "reserved" case where the driver should not do anything with the LBA range.  It should not expose it to upper layers and it should not send any more commands to it.  At this point the manageability tools provided by whomever should be relied upon to have the smarts to use PT commands to determine that the LBA range needs to be configured and configure it accordingly.  Once that's done, the driver will see it as 'configured' the next time (whether the tool submits an IOCTL to rescan, requires a reboot, whatever). 

KK> My understanding is that the "standard" driver is not going to interpret the LBA type. It is not going to do anything special whether it is "Reserved", "Filesystem", "RAID" or others.  The standard driver only looks at the attributes for Read only or hidden.  I think the driver should export all ranges.

I think we probably should have allowed the device to report 0 entry before any set - LBA range command.  When there is no entry, the LBA range is not used.


2.	When the driver get the default LBA range, it "exports" "NSZE" of LBA to the OS.

PL> See above

3.	What happen if the total size LBA as reported by LBA range does not match the Namespace size as reported by Identify Namespace ?
	Should the driver "export" the size as reported by Identify Namespace (NSZE) or LBA Range ? 
	I think it should be "NSZE" and not as reported by LBA range. What do you think ?

PL>  I believe the correct driver operation is to report the size reported by the LBA range and not the NS.  The reason is because it (LBA range # blocks) refers to the actual LBA range and the NSZE refers to the entire NS.  Perhaps the vendor has a reason for not exposing the entire NSZE to the host and thus has defined an LBA range (single) that is smaller than the NSZE.

KK> I still think the driver should report the size "NSZE".


4.	When there are multiple entries in the LBA range, the driver still exports this namespace with size "NSZE" as 
	a single "LUN" with size as reported in "NSZE" except when there are ranges with "Hidden" attribute.

PL>  So I'm not quite sure what you are asking or proposing on this one.  Currently the windows driver doesn't support multiple ranges per NS.  If we want to change that it sounds like you are proposing (or the ECN is) that we report each LBA range as its own tgt or are you saying that all non-hidden LNUS should be exposed as a single tgt??  Sorry, I'm confused :)

KK> The driver should only export a single tgt for a Namespace. If there are multiple LBA ranges, then the driver still export a single tgt.
I understand that current Windows driver does not support multiple ranges per NS.  What should the driver do if there are multiple ranges ?

	ECN 25 describes the handling the hidden LBA.
	"The host storage driver should expose all LBA ranges that are not set to be hidden from the 
	OS / EFI / BIOS in the Attributes field.  All LBA ranges that follow a hidden range shall also be hidden; 
	the host storage driver should not expose subsequent LBA ranges that follow a hidden LBA range"

	The  number of logical blocks that are hidden from the OS must be deducted from "NSZE" before exporting this namespace to the OS.
	In this case, the size is smaller than "NSZE".

5.	When there are one or more ranges with attribute = 0 (Read Only), 
	the driver needs to keep track of these ranges internally.  The driver must return an error when there is a write request
	to these Read only LBA ranges.  

PL>  Agree


KK>  I think the LBA Range causes a lot of confusions.  What happen if there are multiple ranges and the ranges overlaps ?
I think we should set up a call to discuss this.  
Should we raise this in the NVMe WG to ask the expected behavior ?

I would also like to get Matthew's opinion such that both the Windows and Linux driver behave the same.



Please let me know what you think.

Thanks

-Kwok
	



	

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
