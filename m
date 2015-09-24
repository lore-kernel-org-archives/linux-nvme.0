From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Sep 2015 15:38:50 +0200
Subject: [PATCH 2/7] nvme: switch AEN processing to use
 blk_execute_rq_nowait
In-Reply-To: <alpine.LNX.2.00.1509232128470.23840@localhost.lm.intel.com>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
 <1442860853-26447-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509232128470.23840@localhost.lm.intel.com>
Message-ID: <20150924133850.GA6350@lst.de>

On Wed, Sep 23, 2015@11:16:06PM +0000, Keith Busch wrote:
> AEN needs to release the request immediately. That's why it uses
> a "reserved" tag because it is tracked by the driver instead of
> the block layer: there is no guarantee the controller will ever
> return it, which deadlocks blk-mq's hot cpu notification. See
> 1efccc9ddb98fd533169669160201b027562af7e for details.
>
> Other than that, love the rest of the series.

Unfortunately we really need to keep the struct request around to
avoid special casing AENs in the completion path.

Yigal, is there a nice easy way to trigger the CPU hotplug migration
through sysfs or another userspace interface?  I think I can solve
this without freeing the AEN early with a little more thought.
