From: hch@lst.de (hch@lst.de)
Date: Thu, 19 Jul 2018 18:29:24 +0200
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180719162240.GH32160@localhost.localdomain>
References: <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <20180719131903.GB13129@lst.de>
 <20180719145931.GF32160@localhost.localdomain>
 <20180719155616.GG32160@localhost.localdomain>
 <7239f833438701fb6ce21d819bc7042af1bc1f8a.camel@wdc.com>
 <20180719162240.GH32160@localhost.localdomain>
Message-ID: <20180719162924.GA23917@lst.de>

On Thu, Jul 19, 2018@10:22:40AM -0600, Keith Busch wrote:
> On Thu, Jul 19, 2018@04:04:46PM +0000, Bart Van Assche wrote:
> > On Thu, 2018-07-19@09:56 -0600, Keith Busch wrote:
> > > Even some scsi drivers are susceptible to losing their requests with the
> > > reverted behavior: take virtio-scsi for example, which returns RESET_TIMER
> > > from it's timeout handler. With the behavior everyone seems to want,
> > > a natural completion at or around the same time is lost forever because
> > > it was blocked from completion with no way to recover.
> > 
> > The patch I had posted handles a completion that occurs while a timeout is
> > being handled properly. From https://www.mail-archive.com/linux-block at vger.kernel.org/msg22196.html:
> 
> Sounds like a win-win to me.

How do we get a fix into 4.18 at this part of the cycle?  I think that
is the most important prirority right now.
