From: axboe@fb.com (Jens Axboe)
Date: Wed, 16 Nov 2016 12:40:18 -0700
Subject: [PATCH] nvme/pci: Don't free queues on error
In-Reply-To: <1479243386-4383-1-git-send-email-keith.busch@intel.com>
References: <1479243386-4383-1-git-send-email-keith.busch@intel.com>
Message-ID: <bbc4dcb8-20ee-3657-5669-21cf2b758274@fb.com>

On 11/15/2016 01:56 PM, Keith Busch wrote:
> The nvme_remove function tears down all allocated resources in the correct
> order, so no need to free queues on error during initialization. This
> fixes possible use-after-free errors when queues are still associated
> with a blk-mq hctx.

Added for 4.9, thanks Keith.

-- 
Jens Axboe
