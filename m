From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 11:28:30 +0200
Subject: [PATCH] nvme_fc: replace ioabort msleep loop with completion
In-Reply-To: <20170425223212.3876-1-jsmart2021@gmail.com>
References: <20170425223212.3876-1-jsmart2021@gmail.com>
Message-ID: <3831a9bf-97cc-0a60-c943-c53dca712812@suse.de>

On 04/26/2017 12:32 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Per the recommendation by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Wait for io aborts to complete wait converted from msleep look to
> using a struct completion.
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
