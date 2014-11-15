From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Nov 2014 21:44:23 -0700
Subject: [PATCH] NVMe: Defer namespace add_disk() until after char device
 creation
In-Reply-To: <54596CBE.5070501@micron.com>
References: <54596CBE.5070501@micron.com>
Message-ID: <5466DA27.6000707@kernel.dk>

On 2014-11-04 17:18, Sam Bradshaw wrote:
> In the current probe flow, each namespace gets an add_disk() then the
> char device for the controller is registered.  For misbehaving devices
> or namespace(s) that are not yet ready when add_disk() is called (eg.
> namespace accesses that return NVME_SC_NS_NOT_READY and are requeued),
> it can take time to disposition all the accesses.
>
> This change moves add_disk() after the char device is created to give
> manageability stacks an interface to query as IO flushes out.
>
> (I also considered deferring the nvme_ns_add() to an async context but
> that requires some sort of mutex between probe and remove to handle the
> surprise remove during add_disk condition and was messier than this
> patch)

I'd love to see this get added. You need the control char dev to fixup 
such bad situations, and it may never get created if we get stuck on 
trying to setup and probe the block parts.

Acked-by: Jens Axboe <axboe at fb.com>

-- 
Jens Axboe
