From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 Jun 2015 06:59:05 -0700
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <557C5787.3000608@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org>
 <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org>
 <557C5787.3000608@bjorling.me>
Message-ID: <20150617135905.GA17119@infradead.org>

On Sat, Jun 13, 2015@06:17:11PM +0200, Matias Bjorling wrote:
> > Note that for NVMe it might still make sense to implement this using
> > blk-mq and a struct request, but those should be internal similar to
> > how NVMe implements admin commands.
> 
> How about handling I/O merges? In the case where a block API is exposed
> with a global FTL, filesystems relies on I/O merges for improving
> performance. If using internal commands, merging has to implemented in
> the lightnvm stack itself, I rather want to use blk-mq and not duplicate
> the effort. I've kept the stacking model, so that I/Os go through the
> queue I/O path and then picked up in the device driver.

I don't think the current abuses of the block API are acceptable though.
The crazy deep merging shouldn't be too relevant for SSD-type devices
so I think you'd do better than trying to reuse the TYPE_FS level
blk-mq merging code.  If you want to reuse the request
allocation/submission code that's still doable.

As a start add a new submit_io method to the nvm_dev_ops, and add
an implementation similar to pscsi_execute_cmd in
drivers/target/target_core_pscsi.c for nvme, and a trivial no op
for a null-nvm driver replacing the null-blk additions.  This
will give you very similar behavior to your current code, while
allowing to drop all the hacks in the block code.  Note that simple
plugging will work just fine which should be all you'll need.
