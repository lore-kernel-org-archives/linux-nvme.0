From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 09:38:15 +0100
Subject: [PATCH v2 for-4.6 3/3] blk-mq: Make blk_mq_all_tag_busy_iter
 static
In-Reply-To: <1457544184-2838-4-git-send-email-sagig@mellanox.com>
References: <1457544184-2838-1-git-send-email-sagig@mellanox.com>
 <1457544184-2838-4-git-send-email-sagig@mellanox.com>
Message-ID: <20160310083815.GM3464@c203.arch.suse.de>

On Wed, Mar 09, 2016@07:23:04PM +0200, Sagi Grimberg wrote:
> No caller outside the blk-mq code so we can settle
> with it static.
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>

With the mtip32xx changes
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
