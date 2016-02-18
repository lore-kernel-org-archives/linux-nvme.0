From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 10:45:08 +0100
Subject: [PATCH-4.5-v3 5/5] NVMe: Don't unmap controller registers on reset
In-Reply-To: <1455734215-20396-6-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-6-git-send-email-keith.busch@intel.com>
Message-ID: <20160218094508.GU18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@11:36:55AM -0700, Keith Busch wrote:
> Unmapping the registers on reset or shutdown is not necessary. Keeping
> the mapping simplifies reset handling.
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
