From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 11:26:53 +0200
Subject: [PATCH] nvme_fc: stop queues on error detection
In-Reply-To: <20170425223201.3835-1-jsmart2021@gmail.com>
References: <20170425223201.3835-1-jsmart2021@gmail.com>
Message-ID: <ff3f6b93-9bd4-dfcc-0a62-289f66f4e65b@suse.de>

On 04/26/2017 12:32 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Per the recommendation by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Rather than waiting for reset work thread to stop queues and abort the ios,
> immediately stop the queues on error detection. Reset thread will restop
> the queues (as it's called on other paths), but it does not appear to have
> a side effect.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
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
