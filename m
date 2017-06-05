From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 10:19:15 +0200
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <20170601131352.GA2895@localhost.localdomain>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
 <20170528094152.GB14199@lst.de> <20170530142057.GA2845@localhost.localdomain>
 <20170601125023.GB28652@lst.de> <20170601131352.GA2895@localhost.localdomain>
Message-ID: <20170605081915.GB22122@lst.de>

On Thu, Jun 01, 2017@09:13:53AM -0400, Keith Busch wrote:
> On Thu, Jun 01, 2017@02:50:23PM +0200, Christoph Hellwig wrote:
> > On Tue, May 30, 2017@10:20:57AM -0400, Keith Busch wrote:
> > > I am hoping to get this in this round since it would quiet a lot of
> > > errors I'm frequently pinged on: a non-posted request during a hotremove
> > > downstream a switch creates a lot of problems for hardware if you don't
> > > have DPC enabled.
> > 
> > With this round do you mean 4.12-rc or 4.13?
> 
> Was hoping 4.12 simply only the problems from doing this are recently
> becomming more clear, but I guess no rush at this point.

Given that we don't have an actual bug report caused by it yet I'd
be tempted to leave it for 4.13.  Otherwise we're going to run into
Jens or worse Linus screaming at us.
