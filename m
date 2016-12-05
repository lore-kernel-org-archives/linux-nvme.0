From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 5 Dec 2016 12:39:07 +0100
Subject: [PATCH 1/3] nvmet: delete controllers deletion upon subsystem
 release
In-Reply-To: <1480936146-6406-2-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-2-git-send-email-sagi@grimberg.me>
Message-ID: <20161205113907.GH8481@linux-x5ow.site>

On Mon, Dec 05, 2016@01:09:04PM +0200, Sagi Grimberg wrote:
> No reason for them to be kept around if we are
> deleting the subsystem, so instead of passively
> wait for the host to disconnect, actively delete
> the controllers.
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
