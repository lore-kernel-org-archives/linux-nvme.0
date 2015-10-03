From: hch@lst.de (Christoph Hellwig)
Date: Sat, 3 Oct 2015 12:03:57 +0200
Subject: [PATCH 7/7] nvme: remove failed controllers directly from
 probe/reset context
In-Reply-To: <alpine.LNX.2.00.1510022146590.23840@localhost.lm.intel.com>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-8-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510022146590.23840@localhost.lm.intel.com>
Message-ID: <20151003100357.GD851@lst.de>

On Fri, Oct 02, 2015@09:54:20PM +0000, Keith Busch wrote:
> On Fri, 2 Oct 2015, Christoph Hellwig wrote:
>> Now that all probing and resets happen from workqueue context we can remove
>> the controller directly without any risk of deadlocking.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>
> I don't know about this one. If you call pci_stop_and_remove_bus_device(),
> that will get to the driver's ->remove() callback in the same context. The
> first thing this driver does is flush the probe and reset work, and
> I don't think a work queue can flush itself.

True.  I actually had another patch that ensures shutdown always run in
nvme_wq when I developed this patch, but I dropped it due to conflicts.

I'll drop this patch for now.
