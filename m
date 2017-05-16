From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:33:36 +0200
Subject: [PATCH v2 03/10] nvme_fc: replace ioabort msleep loop with
 completion
In-Reply-To: <20170516001024.5281-4-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-4-jsmart2021@gmail.com>
Message-ID: <96e3cab7-0bcb-cdff-cb11-2d81777749c0@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
> Per the recommendation by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Wait for io aborts to complete wait converted from msleep look to
> using a struct completion.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> ---

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
