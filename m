From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Sep 2015 14:35:10 +0000 (UTC)
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <20150928142317.GA29320@infradead.org>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
 <20150927063950.GA18398@infradead.org>
 <alpine.LNX.2.00.1509281345370.23840@localhost.lm.intel.com>
 <20150928142317.GA29320@infradead.org>
Message-ID: <alpine.LNX.2.00.1509281427490.23840@localhost.lm.intel.com>

On Mon, 28 Sep 2015, Christoph Hellwig wrote:
> On Mon, Sep 28, 2015@01:50:23PM +0000, Keith Busch wrote:
>> A resume from S3/S4 will deadlock if we try to delete inaccessible
>> disks from the resume context, so using the work queue instead. There
>> is probably a better way to do this now that we probe asynchronously,
>> we can resume the same way.
>
> Is this still the case with the nvme_io_incapable check in place?  What
> are the symptoms?  Unfortunately I can't test PM easily on my test
> systems with NVMe cards as they are all remotely managed server class
> systems.

Good point, I think that will work. I don't recall the exact sympotoms
(it's been two years), but I believe related to the same deadlock.
I'll try this out on a desktop system.
