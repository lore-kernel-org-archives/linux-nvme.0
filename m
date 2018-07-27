From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 27 Jul 2018 09:38:02 -0400
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <80e32c95-e468-3a79-51db-a344895b0c81@suse.de>
References: <20180726153505.4153-1-hch@lst.de>
 <20180726153505.4153-6-hch@lst.de>
 <20180726172056.GA15917@redhat.com>
 <80e32c95-e468-3a79-51db-a344895b0c81@suse.de>
Message-ID: <20180727133802.GB21680@redhat.com>

On Fri, Jul 27 2018 at  9:20am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 07/26/2018 07:20 PM, Mike Snitzer wrote:
> [ .. ]
> > 
> > I'm at a loss as to why ANA code in host core needs to be wrapped by
> > CONFIG_NVME_MULTIPATH (or why the mechanics of ANA support cannot be
> > decoupled from multipath.c).  I mean it may keep things clearer for this
> > particular implementation but it obviously prevents any more generic ANA
> > handling (decoupled from all the CONFIG_NVME_MULTIPATH code).  That is
> > likely very much by design.
> > 
> > Just seems unecessary but yet inkeeping with one NVMe multipath to rule
> > them all.  Unfortunate.  Especially in that I thought Hannes had a
> > vision for how to keep ANA more analogous to scsi_dh_alua -- meaning
> > capabilties are added to influence behavior of NVMe if the NVMe device
> > advertises support for those capabilities.
> > 
> > Making it all so tightly coupled to the CONFIG_NVME_MULTIPATH code is
> > obviously easier to reason through and may be appropriate for now (just
> > to get it all working).  I just see it as artificially limiting and
> > frankly wrong.
> > 
> I will be checking if ANA support works even though nvme multipathing is
> disabled on the kernel commandline.
> It really should, given the ANA is property of the target and not
> something we can influence.

Right thanks for that.

> But making ANA conditional on whether CONFIG_NVME_MULTIPATH is set I
> don't have a problem with; after all, this option is for cutting down on
> the kernel size, so functionality is allowed to suffer here.

Think it would be better to split it out as a seperate Kconfig option.
