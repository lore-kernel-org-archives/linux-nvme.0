From: keith.busch@intel.com (Keith Busch)
Date: Sat, 22 Nov 2014 01:07:35 +0000 (UTC)
Subject: [PATCH] NVMe: Re-introduce nvmeq->q_suspended
In-Reply-To: <546FD7A2.2070305@micron.com>
References: <546FD7A2.2070305@micron.com>
Message-ID: <alpine.LNX.2.00.1411220053400.4225@localhost.lm.intel.com>

On Fri, 21 Nov 2014, Sam Bradshaw wrote:
> At some point in the blk-mq transition, q_suspended was removed.  This patch 
> adds it back to address two failure modes, both illustrated in the attached 
> snippet.  First, it protects the ioctl path from inadvertently dereferencing 
> invalid nvme_queue data structures during device shutdown/reset.  Second, it 
> protects against a double free_irq() if the shutdown/reset/resume sequence 
> doesn't recover a flaky controller.

I could have sworn there was a better way to suspend at the
request_queue level with blk-mq so we don't need this in the driver. The
blk_start/stop_queue is close, but doesn't work in the ioctl path. Maybe
I'm thinking blk-mq freeze, but that's not exported for drivers.
