From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:14:30 +0100
Subject: [PATCH for-4.5 02/13] NVMe: Fix io incapable return values
In-Reply-To: <1455128250-5984-3-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160211121430.GD27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:19AM -0700, Keith Busch wrote:
> The function returns true when the controller can't handle IO.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
> Acked-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
