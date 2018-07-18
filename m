From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 18 Jul 2018 15:17:11 -0600
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
References: <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
Message-ID: <20180718211711.GB32160@localhost.localdomain>

On Wed, Jul 18, 2018@08:58:48PM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18@14:53 -0600, Keith Busch wrote:
> > If scsi needs this behavior, why not just put that behavior in scsi? It
> > can set the state to complete and then everything can play out as
> > before.
> > [ ... ]
> 
> There may be other drivers that need the same protection the SCSI core needs
> so I think the patch at the end of your previous e-mail is a step in the wrong
> direction.
> 
> Bart.

And there may be other drivers that don't want their completions
ignored, so breaking them again is also a step in the wrong direction.

There are not that many blk-mq drivers, so we can go through them all.

Most don't even implement .timeout, so they never know that condition
ever happened. Others always return BLK_EH_RESET_TIMER without doing
anythign else, so the 'new' behavior would have to be better for those,
too.

The following don't implement .timeout:

  loop, rdb, virtio, xen, dm, ubi, scm

The following always return RESET_TIMER:

  null, skd

The following is safe to the new way:

  mtip

And now ones I am not sure about:

  ndb, mmc, dasd

I don't know, reverting looks worse than just fixing the drivers.
