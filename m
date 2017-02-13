From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 13 Feb 2017 11:33:17 +0100
Subject: [PATCH 3/5] nvme/core: Fix race kicking freed request_queue
In-Reply-To: <1486768553-13738-4-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-4-git-send-email-keith.busch@intel.com>
Message-ID: <fcb8de0c-4f39-0b6d-7a7e-a9aebb5b5311@suse.de>

On 02/11/2017 12:15 AM, Keith Busch wrote:
> If a namespace has already been marked dead, we don't want to kick the
> request_queue again since we may have just freed it from another thread.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
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
