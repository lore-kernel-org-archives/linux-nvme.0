From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 13 Feb 2019 18:51:41 +0000
Subject: KXG60ZNV256G not recognized
In-Reply-To: <20190213181838.GA7852@localhost.localdomain>
References: <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
 <ef3bbe97-8d3b-89bc-4149-60673b1da388@suse.de>
 <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
 <1a626bba-4e02-426b-182e-2e863c6a5f77@uni-siegen.de>
 <05361ecc-7a7d-1a31-1c72-dac670badc24@suse.de>
 <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
 <20190213181838.GA7852@localhost.localdomain>
Message-ID: <e970bfdcf6fb403ebdd395cc87bde80a@ausx13mpc120.AMER.DELL.COM>

> -----Original Message-----
> From: Keith Busch <keith.busch at intel.com>
> Sent: Wednesday, February 13, 2019 12:19 PM
> To: Limonciello, Mario
> Cc: hch at infradead.org; pokorra at uni-siegen.de; linux-nvme at lists.infradead.org;
> jthumshirn at suse.de
> Subject: Re: KXG60ZNV256G not recognized
> 
> 
> [EXTERNAL EMAIL]
> 
> On Wed, Feb 13, 2019@06:04:39PM +0000, Mario.Limonciello@dell.com wrote:
> >
> > If you go into BIOS setup and choose SATA mode change from
> > "RAID ON" to "AHCI".
> >
> > I know it's an NVME disk, and you're changing SATA mode, but it adjusts
> > relevant settings on the PCH whether you were using a SATA disk or NVME.
> 
> Right, "RAID" mode has the PCH compbine multiple devices into one. AHCI
> mode doesn't capture other devices behind the SATA controller, so the
> NVMe device is visible.

> the Intel anti-competitive fake RAID mode

Chris Hellwig,

I am aware there was a patch series submitted at one point for this
technology that was rejected. From your perspective is there (realistically) anything
that Intel can do here for the kernel?  The particular PCH functionality referred above
has been in the industry from Intel silicon for a while now, and is going to continue to
be a barrier to entry for anyone who purchases a machine "with Windows" and tries to
load Linux.
