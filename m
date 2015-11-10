From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Nov 2015 16:03:45 +0000
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <20151110081357.GA21708@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
 <20151109185731.GB5386@localhost.localdomain>
 <20151109192518.GA10681@lst.de>
 <20151109201232.GC5386@localhost.localdomain>
 <20151110081357.GA21708@lst.de>
Message-ID: <20151110160344.GB31697@localhost.localdomain>

On Tue, Nov 10, 2015@09:13:57AM +0100, Christoph Hellwig wrote:
> Set Features for set_queue_count times out we'll call the reset handler,
> which because we are inside the probe handler will remove the device.
> How do we care about the return value in that case?
> 
> Can you write down a few sentences on why/how we care?  I'll volunteer
> to put them into the driver in comment form once we have all this sorted
> out so that anyone touching the driver in the future won't be as confused.

Perhaps I am thinking how probing serially worked before, and don't
understand how this works anymore. :)

You're right, we don't really care anymore if the reset handler unwinds
it. This path is then safe to see a fake error code.

But the reset handler is the same "work" as probe now, so it won't get
scheduled. Now I completely understand why we changed nvme_timeout()
to end the request with -EIO instead of waiting for the reset work to
cancel it. That's still unsafe since it frees the command for reuse
while the ID is still technically owned by the controller.
