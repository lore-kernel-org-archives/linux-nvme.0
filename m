From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 13 Feb 2017 11:25:31 +0100
Subject: [PATCH 2/5] nvme/pci: Cancel work after watchdog disabled
In-Reply-To: <1486768553-13738-3-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-3-git-send-email-keith.busch@intel.com>
Message-ID: <b9b0706c-a1f4-fcc3-034d-7f03bd1f90cb@suse.de>

On 02/11/2017 12:15 AM, Keith Busch wrote:
> The driver had been flushing the work prior to uninitializing the
> controller, hoping the work would not get restarted. If controller
> failure or IO time occurs when tearing down the request queues, the
> watchdog timer may queue another reset.
> 
> We want to make sure that reset work is not running to prevent use after
> free errors accessing the device being torn down, so this patch cancels
> the reset work only after we know it can never be started again.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
