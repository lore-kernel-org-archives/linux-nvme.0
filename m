From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 13 Feb 2019 18:04:39 +0000
Subject: KXG60ZNV256G not recognized
In-Reply-To: <20190213180050.GA26226@infradead.org>
References: <19873dbf-4c19-5cab-d5fb-c63f6cb72101@uni-siegen.de>
 <facf2124-d29c-2151-2419-db9b0776f3cd@suse.de>
 <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
 <ef3bbe97-8d3b-89bc-4149-60673b1da388@suse.de>
 <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
 <1a626bba-4e02-426b-182e-2e863c6a5f77@uni-siegen.de>
 <05361ecc-7a7d-1a31-1c72-dac670badc24@suse.de>
 <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
Message-ID: <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>

> -----Original Message-----
> From: Christoph Hellwig <hch at infradead.org>
> Sent: Wednesday, February 13, 2019 12:01 PM
> To: Limonciello, Mario; Gerd Pokorra
> Cc: Johannes Thumshirn; linux-nvme at lists.infradead.org
> Subject: Re: KXG60ZNV256G not recognized
> 
> 
> [EXTERNAL EMAIL]
> 
> Mario,
> 
> any idea how to turn off the Intel anti-competitive fake RAID mode
> for NVMe for the Dell Presision 7730?

If you go into BIOS setup and choose SATA mode change from 
"RAID ON" to "AHCI".

I know it's an NVME disk, and you're changing SATA mode, but it adjusts
relevant settings on the PCH whether you were using a SATA disk or NVME.

Systems shipped with Linux have it set properly and it should persist
even when BIOS is reset to factory defaults.

> 
> On Wed, Feb 13, 2019@03:29:53PM +0100, Gerd Pokorra wrote:
> > Hello Johannes,
> >
> > it is a Dell Presision 7730.
> >
> > -- Gerd
> >
> >
> > Am 13.02.2019 um 15:04 schrieb Johannes Thumshirn:
> > > On 13/02/2019 14:58, Gerd Pokorra wrote:
> > > > Hello Johannes,
> > > >
> > > > after setting it to 'Disabled' I see no hard disks of the laptop any
> > > > more with linux and an existing Windows installation is wrecked.
> > > >
> > > > Setting the BIOS to the 'Factory Defaults' bring the Windows
> > > > Installation back. It will be hard to install an Linux on this Laptop.
> > > Yes this is exactly what I expected TBH.
> > >
> > > There's not really a lot we can do about without any specs for the AHCI
> > > remapped NVMe thingy.
> > >
> > > Lenovo used to have an different BIOS built for Linux on the Yoga series
> > > some years ago if I remember correctly.
> > >
> > > Byte,
> > > 	Johannes
> >
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> ---end quoted text---
