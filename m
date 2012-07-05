From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Thu, 5 Jul 2012 19:28:15 +0000
Subject: NVMe driver behaviour on LBA Range - new Proposal
In-Reply-To: <82C9F782B054C94B9FC04A331649C77A028EAB4F@FMSMSX106.amr.corp.intel.com>
References: <05CD7821AE397547A01AC160FBC2314704A798@corpmail1.na.ads.idt.com>
 <82C9F782B054C94B9FC04A331649C77A028E95CC@FMSMSX106.amr.corp.intel.com>
 <05CD7821AE397547A01AC160FBC2314704A8AA@corpmail1.na.ads.idt.com>
 <B58D82457FDA0744A320A2FC5AC253B90D42B9E6@FMSMSX105.amr.corp.intel.com>
 <05CD7821AE397547A01AC160FBC2314704A8CD@corpmail1.na.ads.idt.com>
 <82C9F782B054C94B9FC04A331649C77A028E9A5B@FMSMSX106.amr.corp.intel.com>
 <05CD7821AE397547A01AC160FBC2314704ACD5@corpmail1.na.ads.idt.com>
 <82C9F782B054C94B9FC04A331649C77A028EAB4F@FMSMSX106.amr.corp.intel.com>
Message-ID: <05CD7821AE397547A01AC160FBC2314704B4C3@corpmail1.na.ads.idt.com>

All,

I have reviewed the NVMe working group meeting minutes and have more discussions on the usage of LBA Range with others.

I believe this is the direction from the NVMe WG based on the discussion on 12-15-11 and ECN 25.

Here is ECN 25:

"The host storage driver should expose all LBA ranges that are not set 
to be hidden from the OS / EFI / BIOS in the Attributes field.  All LBA ranges that follow a 
hidden range shall also be hidden; the host storage driver should not expose subsequent LBA ranges that 
follow a hidden LBA range"


1.	A NVMe driver is not going to look at the LAB Range type (i.e. "Filesystem", "RAID" or "Cache" ...etc).
	It is expected that the layer above the NVMe driver may use the LBA Range type.

	i.e. A "RAID" driver or "Cache" driver may sit above the NVMe driver. A "Cache" driver may use the LBA Range type
	to decide how much space it can use for the caching function.  How this is implemented is beyond the scope of the NVMe Spec.

2.	A NVMe driver only looks at the attributes. If a range is "hidden", the NVMe drier should not expose this range to 
	the OS/EFI/BIOS. All LBA ranges that follow a hidden range shall also be hidden.

3.	A NVMe driver exposes all Read only (area should not be overwritten) LBA Ranges to the OS/EFI/BIOS but marks these
	areas as read only in the NVMe driver. NVMe driver returns an error when a write request is received with the LBA range 
	that is within the read only area.

4.	A NVMe driver exposes the total namespace size "NSZE" as reported by Identify Namespace minus the hidden LBA ranges to the
	OS/EFI/BIOS.

5.	When there are overlapping LBA ranges, the most restrictive attribute wins. 
	- Check for hidden LBA ranges
	- Check for Read only LBA ranges for those LBA ranges that are not hidden
	- The remaining LBA ranges are read/writeable

6.	This is very simple for the NVMe driver to implement. It matches the NVMe spec and ECN 25.


Please let me know if you have any comment or different understanding of the NVMe spec and ECN 25.


We need an agreement from the Windows driver team (Windows driver) and Matthew (Linux driver) before we can add the support of LBA Range to the NVMe drivers.

Thanks

-Kwok

We can set up a call to discuss this and reach an agreement.
