From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:43:25 +0100
Subject: [PATCH for-4.5 11/13] NVMe: Dead namespace handling
In-Reply-To: <1455128250-5984-12-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-12-git-send-email-keith.busch@intel.com>
Message-ID: <20160211124325.GK27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:28AM -0700, Keith Busch wrote:
> This adds a "dead" state to a namespace and revalidates such a namespace
> to 0 capacity. This will force buffered writers to stop writing pages
> that can't be synced, and ends requests in failure if any is submitted
> to such a namespace.
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
