From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Oct 2017 08:05:26 -0600
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171005065124.h5t3gtufptevja4s@linux-x5ow.site>
References: <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
 <20171004071312.GA21143@lst.de> <yq1poa2wgd2.fsf@oracle.com>
 <20171005065124.h5t3gtufptevja4s@linux-x5ow.site>
Message-ID: <20171005140525.GB2384@localhost.localdomain>

On Thu, Oct 05, 2017@08:51:24AM +0200, Johannes Thumshirn wrote:
> On Wed, Oct 04, 2017@09:08:57PM -0400,  Martin K. Petersen  wrote:
> > 
> > Christoph,
> > 
> > > The only other option I could think of would be to turn names around:
> > > make /dev/nvmeX (chardev) and /dev/nvmeXnY the per-subsystem devices
> > > that are multipathed if available.  We'd then need new devices for the
> > > invdividual controllers.
> > 
> > I like that approach.
> 
> /me too

I can get on board with this approach for the namespaces, but the
controller char devs should stay as they are for compatibility and
existing tools. The IO commands (including reservations) are not
controller specific, so not knowing which path is used will okay for
namespaces. Most admin commands are controller specific, so we can't
just shift the controller handle to the subsystem level.
