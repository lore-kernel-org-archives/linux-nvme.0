From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:57:10 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190516144017.GA23372@localhost.localdomain>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <20190516144017.GA23372@localhost.localdomain>
Message-ID: <20190516145710.GA23416@localhost.localdomain>

On Thu, May 16, 2019@08:40:17AM -0600, Keith Busch wrote:
> On Wed, May 15, 2019@11:46:51PM -0700, Christoph Hellwig wrote:
> > On Wed, May 15, 2019@03:33:51PM -0600, Keith Busch wrote:
> > > So here's a solution that no one will like: pull subsystem and controller
> > > instances from the same IDA so that there won't be any namespace block
> > > devices with a matching controller handle name. While this does nothing
> > > to clear up device relationships, this will force the user to think
> > > really hard about what they're doing and avoid such mistakes.
> > 
> > Hmm.  So we'll get:
> > 
> > /dev/nvme0
> >  - chardev subsys X ctl 1
> > 
> > /dev/nvme1n1
> > /dev/nvme1n2
> >  - namespaces for subsys X
> > 
> > /dev/nvme2
> >  - chardev subsys X ctl 2
> > 
> > /dev/nvme3
> >  - chardev subsys Y ctl 1
> > 
> > ...
> > 
> > This should work.  Not sure it really buys us so much, though.
> 
> Right, it's not much. The only thing I want accomplish with this is to remove any excuse for
> sending commands to the wrong handle. We can insist that it's wrong 

[finishing the sentence]

We can insist that it's wrong for anyone to have assumed a chardev is the
controller of a specific blkdev, but amount of feedback I've received
indicates the current naming is a little too easy for people to shoot
themselves in the foot. This new naming will put a stop to such mistakes
without breaking anything.
