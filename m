From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Aug 2019 11:34:20 -0700
Subject: [PATCH 1/2] nvme: skip namespaces which are about to be removed
In-Reply-To: <20190801071644.66690-2-hare@suse.de>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-2-hare@suse.de>
Message-ID: <00204bc9-2399-d919-2fd4-ddcf689373b7@grimberg.me>


> nvme_ns_remove() will only remove the namespaces from the list at
> the very last step, so we might run into situations where we iterate
> over namespaces which are about to be deleted.
> To avoid crashes we should be skipping all namespaces with the
> NVME_NS_REMOVING flag set.

Hannes,
Can you please attach the actual crash that this is fixing? I think
its much easier to review and provide feedback.

Also, I think that what I proposed is addressing what you describe here
but in a cleaner way. You only raised a concern about calling
blk_cleanup_queue on a quiesced request queue which should not be
a problem because nothing is blocking on blk_queue_enter so it will
make progress.

Did you attempt to apply my suggested patch? Or do you have a
reproducer?
