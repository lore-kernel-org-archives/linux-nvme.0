From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 10:37:09 +0100
Subject: [PATCH-4.5-v3 1/5] NVMe: Add controller removing state
In-Reply-To: <1455734215-20396-2-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160218093709.GR18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@11:36:51AM -0700, Keith Busch wrote:
> The patch is preparing for reducing the scope of the namespace mutex. It
> adds a removing state the namespace scan work uses to know if it is safe
> to proceed. The scan work is flushed after setting the device state so
> the removal path can safely walk the namespace list without locking it.
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
