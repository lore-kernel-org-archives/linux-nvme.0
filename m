From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:34:02 +0100
Subject: [PATCH for-4.5 10/13] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1455128250-5984-11-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-11-git-send-email-keith.busch@intel.com>
Message-ID: <20160211123402.GJ27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:27AM -0700, Keith Busch wrote:
> This moves the dead queue handling out of the namespace removal path
> and into the reset failure path. It fixes a deadlock condition if the
> controller fails or link down during del_gendisk.
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
