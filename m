From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 13 Feb 2019 20:37:37 +0000
Subject: KXG60ZNV256G not recognized
In-Reply-To: <20190213190012.GA8898@infradead.org>
References: <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
 <1a626bba-4e02-426b-182e-2e863c6a5f77@uni-siegen.de>
 <05361ecc-7a7d-1a31-1c72-dac670badc24@suse.de>
 <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
 <20190213181838.GA7852@localhost.localdomain>
 <e970bfdcf6fb403ebdd395cc87bde80a@ausx13mpc120.AMER.DELL.COM>
 <20190213190012.GA8898@infradead.org>
Message-ID: <4bd15523d31948328c2c50693a08bd2c@ausx13mpc120.AMER.DELL.COM>

> What we really need is Intel stopping to do amazingly stupid things like
> this.  Hiding PCIe devices from their drivers is anti-competitive
> behavior from a company controlling much of the PC market.
> 

My take on this is that the way this thing works and the things it does makes a lot more
sense in the Windows kernel driver model than it does for Linux.  I've heard there are
quantifiable tangible benefits to using this technology on Windows.

Given its been around now for at least 4 generations of Intel silicon (maybe more if
I'm miscounting), I really don't think its going to away from the PC market any time soon.

As such, I don't think that disdaining the technology will get Intel to change it.
So I'm hoping we can constructively come up with something that works in the confines
of its existence to make it a better experience at least.

> And at the very least we need a way to disable this behavior from the
> OS.

At least on Dell I could offer a way to accomplish this with SMM today with a small kernel
patch, but it will require a reboot to be effective.

An idea of how it could look:
# cat /sys/platform/devices/dell-laptop/current-sata-mode
ahci [raid] needs-reboot
# echo ahci > /sys/platform/devices/dell-laptop/current-sata-mode
# cat /sys/platform/devices/dell-laptop/current-sata-mode
ahci raid [needs-reboot]
(reboot)
# cat /sys/platform/devices/dell-laptop/current-sata-mode
[ahci] raid needs-reboot

It's not pretty, but maybe it's an improvement?  At least on Dell systems the
distro installers could probe that sysfs node and warn people/fix it across a reboot cycle.

If the relevant Intel PCH registers that are affected were documented, I would think something
similar could be done by kernel PCH initialization code,  but the PCH might need to be reset after
writing them.  That could make the BIOS setting effectively ignored on Linux.
Keith, what do you think on this?
