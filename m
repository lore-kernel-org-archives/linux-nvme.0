From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 19 Oct 2016 09:27:22 +0200
Subject: [PATCH 4/6] nvme-fabrics: Fix a memory leak in an
 nvmf_create_ctrl() error path
In-Reply-To: <2c9d4e7b-1c48-619c-4f48-9c968747663a@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <2c9d4e7b-1c48-619c-4f48-9c968747663a@sandisk.com>
Message-ID: <20161019072722.enlspah2xafzurmp@linux-x5ow.site>

On Tue, Oct 18, 2016@01:11:03PM -0700, Bart Van Assche wrote:
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
