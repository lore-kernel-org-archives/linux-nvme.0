From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:26:03 +0100
Subject: [PATCH for-4.5 08/13] NVMe: Poll device while still active
 during remove
In-Reply-To: <1455128250-5984-9-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-9-git-send-email-keith.busch@intel.com>
Message-ID: <20160211122602.GH27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:25AM -0700, Keith Busch wrote:
> A device failure or link down wouldn't have been detected during namespace
> removal. This patch keeps the device in the list for polling so that the
> thread may see such failure and initiate a reset. The device is removed
> from the list after disable, so we can safely flush the reset work as
> it can't be requeued when disable completes.
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
