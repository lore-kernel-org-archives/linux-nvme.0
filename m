From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 30 Dec 2015 22:42:12 +0200
Subject: [PATCH 3/5] NVMe: Remove queue freezing on resets
In-Reply-To: <1451496471-29370-4-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-4-git-send-email-keith.busch@intel.com>
Message-ID: <568441A4.3030007@dev.mellanox.co.il>


> NVMe submits all commands through the block layer now. This means we
> can let requests queue at the blk-mq hardware context since there is no
> path that bypasses this anymore. This means we don't need to freeze the
> queues anymore and simply stop the h/w queues from running during a reset.

Does this have any dependencies? I tried this at some point but it
didn't work as I expected it to.

> This also fixes a WARN in percpu_ref_reinit when the queue was unfrozen
> with requeued requests.

Oh yes, I've seen this one too! I'll test it for sure.
