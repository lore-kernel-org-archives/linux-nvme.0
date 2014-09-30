From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Sep 2014 11:42:34 -0600 (MDT)
Subject: [PATCH v13] NVMe: Convert to blk-mq
In-Reply-To: <1412098195-30133-2-git-send-email-m@bjorling.me>
References: <1412098195-30133-1-git-send-email-m@bjorling.me>
 <1412098195-30133-2-git-send-email-m@bjorling.me>
Message-ID: <alpine.LRH.2.03.1409301134580.4688@AMR>

On Tue, 30 Sep 2014, Matias Bj?rling wrote:
> @@ -1967,27 +1801,30 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
> {
...
> -	ns->queue->queue_flags = QUEUE_FLAG_DEFAULT;
> +	queue_flag_set_unlocked(QUEUE_FLAG_DEFAULT, ns->queue);

Instead of the above, you want

+	ns->queue->queue_flags |= QUEUE_FLAG_DEFAULT;

I only caught it because of the fun dm-mpath attempt with nvme and
blk-mq. Or maybe we don't want to include "QUEUE_FLAG_STACKABLE" right
now (part of the default flags) because it will kernel crash if you're
using dm-multipath with a blk-mq driver today.

Otherwise, looks great!
