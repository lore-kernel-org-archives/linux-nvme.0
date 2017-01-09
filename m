From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 9 Jan 2017 16:03:42 +0100
Subject: [PATCH] nvmet_fc: Clear SG list to avoid double frees
In-Reply-To: <585eb482.c+IlMeE1LJXQhHJk%jsmart2021@gmail.com>
References: <585eb482.c+IlMeE1LJXQhHJk%jsmart2021@gmail.com>
Message-ID: <20170109150342.GI3711@linux-x5ow.site>

On Sat, Dec 24, 2016@09:46:42AM -0800, James Smart wrote:
> 
> Clear SG list to avoid double frees of payload page list
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
