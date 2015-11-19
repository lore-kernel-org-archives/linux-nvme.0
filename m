From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Nov 2015 14:24:35 -0800
Subject: [PATCH] nvme: allow queues the chance to quiesce after freezing
 them
In-Reply-To: <20151119222012.GB22690@localhost.localdomain>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
 <20151119214156.GA22690@localhost.localdomain>
 <20151119215311.GA19302@infradead.org>
 <20151119222012.GB22690@localhost.localdomain>
Message-ID: <20151119222435.GA8800@infradead.org>

On Thu, Nov 19, 2015@10:20:12PM +0000, Keith Busch wrote:
> I don't see how we can disable the controller to forcefully end commands
> with merged probe and reset work, and thinking these need to be kept
> separate. Timeouts are done in a workqueue now, so can we do controller
> shutdown inline with the timeout handler?

That's one of the two options I'm exploring.  The other is a new request
flag that tells the block later not to reuse the tag after a return from
the timeout handler.
