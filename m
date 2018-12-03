From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 3 Dec 2018 15:44:48 +0800
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <20181201164804.GB19557@lst.de>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
Message-ID: <CACVXFVMv1yT44=rGwyXxY+GKGLCzVH8-+A11wBTQMcaZOq5K9Q@mail.gmail.com>

On Sun, Dec 2, 2018@12:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Nov 30, 2018@01:36:09PM -0700, Jens Axboe wrote:
> > On 11/30/18 1:26 PM, Keith Busch wrote:
> > > A driver may wish to iterate every tagged request, not just ones that
> > > satisfy blk_mq_request_started(). The intended use is so a driver may
> > > terminate entered requests on quiesced queues.
> >
> > How about we just move the started check into the handler passed in for
> > those that care about it? Much saner to make the interface iterate
> > everything, and leave whatever state check to the callback.
>
> So we used to do that, and I changed it back in May to test for
> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
> blk_mq_request_started.  So this is clearly a minefield of sorts..

The change to blk_mq_request_started() is for just fixing SCSI's boot
hang issue.

>
> Note that at least mtip32xx, nbd, skd and the various nvme transports
> want to use the function to terminate all requests in the error
> path, and it would be great to have one single understood, documented
> and debugged helper for that in the core, so this is a vote for moving
> more of the logic in your second helper into the core code.  skd
> will need actually use ->complete to release resources for that, though
> and mtip plays some odd abort bits.  If it weren't for the interesting
> abort behavior in nvme-fc that means we could even unexport the
> low-level interface.

Agree, and especially SCSI's use should be understood given
SCSI is so widely deployed in product system.

thanks,
Ming Lei
