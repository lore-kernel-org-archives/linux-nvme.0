From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 14 Feb 2019 00:30:47 -0800
Subject: KXG60ZNV256G not recognized
In-Reply-To: <20190213212253.GA8027@localhost.localdomain>
References: <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
 <20190213181838.GA7852@localhost.localdomain>
 <e970bfdcf6fb403ebdd395cc87bde80a@ausx13mpc120.AMER.DELL.COM>
 <20190213190012.GA8898@infradead.org>
 <4bd15523d31948328c2c50693a08bd2c@ausx13mpc120.AMER.DELL.COM>
 <20190213212253.GA8027@localhost.localdomain>
Message-ID: <20190214083047.GA24653@infradead.org>

On Wed, Feb 13, 2019@02:22:53PM -0700, Keith Busch wrote:
> To the best of my knowledge, the hardware mode is working around a
> software limitation that doesn't apply to Linux.

More correctly it works around a business model limitation that allows
Intel to sell an "integrated" fake raid driver.  Even more importantly
it works around that business model limitation in a completely gross
way, unlike the vmd solution to the same problem in another intel
division, which at least allows to recover from that workaround.

> > As such, I don't think that disdaining the technology will get Intel to change it.
> > So I'm hoping we can constructively come up with something that works in the confines
> > of its existence to make it a better experience at least.
> 
> I assumed Chritoph's comment was directed toward said software that runs
> on the majority of the client PC market, leaving hardware vendors to
> think up "creative" work-arounds to its quirks to the detriment of other
> software environments. :(

It affects everyone but Intel, that is vendors of non-Intel NVMe SSDs
that have no control on what windows driver is used for their devices,
and it includes any OS that does not have an Intel driver that knows
how to deal with the magic intel AHCI device, which is entirely Intel
private.

Even with the patches from Dan we can't properly use the NVMe device:

 - there is no support for MSI/MSI-X and thus no support for per-queue
   interrupts, thus severly limiting performance
 - there is no support for PCI ID based quirks, which we require
   to support various devices properly
 - there is no way to make SR-IOV work
 - there is no way to make PCI-level FLRs work, or to unbind the
   device in case of a fatal failure

All in all Intel is using their domniance of the CPU and shipset
business to harm various other parties.
