From: axboe@fb.com (Jens Axboe)
Date: Mon, 2 May 2016 09:10:27 -0600
Subject: [PATCH] NVMe: Fix check_flush_dependency warning
In-Reply-To: <1461793878-14732-1-git-send-email-keith.busch@intel.com>
References: <1461793878-14732-1-git-send-email-keith.busch@intel.com>
Message-ID: <57276DE3.8000306@fb.com>

On 04/27/2016 03:51 PM, Keith Busch wrote:
> If the controller fails and is degraded after a reset, we need to kill
> off all requests queues before removing the inaccessble namespaces. This
> will prevent del_gendisk from syncing dirty data, which we can't due
> from a WQ_MEM_RECLAIM work queue.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Applied for 4.7.

-- 
Jens Axboe
