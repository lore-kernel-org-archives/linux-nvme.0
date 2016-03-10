From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 09:33:55 +0100
Subject: [PATCH v2 for-4.6 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <1457544184-2838-3-git-send-email-sagig@mellanox.com>
References: <1457544184-2838-1-git-send-email-sagig@mellanox.com>
 <1457544184-2838-3-git-send-email-sagig@mellanox.com>
Message-ID: <20160310083355.GL3464@c203.arch.suse.de>

On Wed, Mar 09, 2016@07:23:03PM +0200, Sagi Grimberg wrote:
> blk-mq offers a tagset iterator so let's use that
> instead of using nvme_clear_queues.
> 
> Note, we changed nvme_queue_cancel_ios name to nvme_cancel_io
> as there is no concept of a queue now in this function (we
> also lost the print).
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
