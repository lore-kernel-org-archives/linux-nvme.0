From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 20 Feb 2018 11:13:11 +0100
Subject: how can one drain MQ request queue ?
In-Reply-To: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
References: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
Message-ID: <20180220101311.aoe7m57kwm5ejb2a@linux-x5ow.site>

On Tue, Feb 20, 2018@11:56:07AM +0200, Max Gurtovoy wrote:
> hi all,
> is there a way to drain a blk-mq based request queue (similar to
> blk_drain_queue for non MQ) ?

I _think_ you can do a echo run >
/sys/kernel/debug/block/nvmeXnX/hctxX/state and that should trigger
it.

Hope that helps.

Byte,
     Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
