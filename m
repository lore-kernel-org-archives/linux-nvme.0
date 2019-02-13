From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Feb 2019 14:22:53 -0700
Subject: KXG60ZNV256G not recognized
In-Reply-To: <4bd15523d31948328c2c50693a08bd2c@ausx13mpc120.AMER.DELL.COM>
References: <05361ecc-7a7d-1a31-1c72-dac670badc24@suse.de>
 <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
 <20190213181838.GA7852@localhost.localdomain>
 <e970bfdcf6fb403ebdd395cc87bde80a@ausx13mpc120.AMER.DELL.COM>
 <20190213190012.GA8898@infradead.org>
 <4bd15523d31948328c2c50693a08bd2c@ausx13mpc120.AMER.DELL.COM>
Message-ID: <20190213212253.GA8027@localhost.localdomain>

On Wed, Feb 13, 2019@08:37:37PM +0000, Mario.Limonciello@dell.com wrote:
> > What we really need is Intel stopping to do amazingly stupid things like
> > this.  Hiding PCIe devices from their drivers is anti-competitive
> > behavior from a company controlling much of the PC market.
> 
> My take on this is that the way this thing works and the things it does makes a lot more
> sense in the Windows kernel driver model than it does for Linux.  I've heard there are
> quantifiable tangible benefits to using this technology on Windows.

To the best of my knowledge, the hardware mode is working around a
software limitation that doesn't apply to Linux.
 
> Given its been around now for at least 4 generations of Intel silicon (maybe more if
> I'm miscounting), I really don't think its going to away from the PC market any time soon.

That might depend on if said software overcomes those limitations, but I'm
out of the loop to know if that's going to change any time soon, if ever.

> As such, I don't think that disdaining the technology will get Intel to change it.
> So I'm hoping we can constructively come up with something that works in the confines
> of its existence to make it a better experience at least.

I assumed Chritoph's comment was directed toward said software that runs
on the majority of the client PC market, leaving hardware vendors to
think up "creative" work-arounds to its quirks to the detriment of other
software environments. :(

> At least on Dell I could offer a way to accomplish this with SMM today with a small kernel
> patch, but it will require a reboot to be effective.

Pre-boot settings like you already have are preferable, right? Otherwise
it's a little more difficult to use the NVMe as your boot drive.

> It's not pretty, but maybe it's an improvement?  At least on Dell systems the
> distro installers could probe that sysfs node and warn people/fix it across a reboot cycle.
> 
> If the relevant Intel PCH registers that are affected were documented, I would think something
> similar could be done by kernel PCH initialization code,  but the PCH might need to be reset after
> writing them.  That could make the BIOS setting effectively ignored on Linux.
> Keith, what do you think on this?

I think the recommended Linux implementation would treat this like a host
bridge and expose the PCI device to the OS without changing any hardware
settings.

But as far as I know, the Intel group that owns this mode has not reached
out to the Linux enabling with hardware specs that we can make public.
The OEMS are probably in a better position to compel this to change than
I am.
