From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 1 Jun 2016 09:21:32 +0200
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160601072132.x5ehityotpi5if3x@c203.arch.suse.de>

On Tue, May 31, 2016@03:25:27PM -0600, Keith Busch wrote:
> All resets now must be submitted through the new state. This makes it
> easier to coordinate controller tasks and simplifies the reset logic.
> 
> Since all resets go through the same state machine, and most of these
> don't want to block for the reset to complete, this patch makes user
> initiated resets asynchronous as well. Making user resets block until
> complete wasn't necessary in the first place.
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
