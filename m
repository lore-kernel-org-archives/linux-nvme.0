From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 5 Dec 2016 12:38:43 +0100
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <1480936146-6406-3-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
Message-ID: <20161205113843.GG8481@linux-x5ow.site>

On Mon, Dec 05, 2016@01:09:05PM +0200, Sagi Grimberg wrote:
> We usually log the cntlid which is confusing in case
> we have multiple subsystems each with it's own cntlid ida.
> Instead make cntlid ida globally unique and log the initial
> association.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
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
