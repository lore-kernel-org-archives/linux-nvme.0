From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 7 Mar 2016 09:46:56 +0100
Subject: [PATCHv2] NVMe: Create discard zero quirk white list
In-Reply-To: <1457122517-18658-1-git-send-email-keith.busch@intel.com>
References: <1457122517-18658-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160307084656.GA3302@c203.arch.suse.de>

On Fri, Mar 04, 2016@01:15:17PM -0700, Keith Busch wrote:
> The NVMe specification does not require discarded blocks return zeroes on
> read, but provides that behavior as a possibility. Some applications more
> efficiently use an SSD if reads on discarded blocks were deterministically
> zero, based on the "discard_zeroes_data" queue attribute.
> 
> There is no specification defined way to determine device behavior on
> discarded blocks, so the driver always left the queue setting disabled. We
> can only know behavior based on individual device models, so this patch
> adds a flag to the NVMe "quirk" list that vendors may set if they know
> their controller works that way. The patch also sets the new flag for one
> such known device.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
