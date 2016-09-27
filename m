From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 27 Sep 2016 09:51:48 +0200
Subject: [PATCH 6/9] block: Rename mq_freeze_wq and mq_freeze_depth
In-Reply-To: <129b2a52-1ff7-7048-dfa3-89416ea42dd2@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <129b2a52-1ff7-7048-dfa3-89416ea42dd2@sandisk.com>
Message-ID: <20160927075148.6vrdr44eb34g2ccf@linux-x5ow.site>

On Mon, Sep 26, 2016@11:28:08AM -0700, Bart Van Assche wrote:
> Since these two structure members are now used in blk-mq and !blk-mq
> paths, remove the mq_prefix. This patch does not change any
> functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
