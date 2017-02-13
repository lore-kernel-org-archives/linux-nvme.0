From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 13 Feb 2017 11:18:58 +0100
Subject: [PATCH 1/5] nvme/pci: Disable on removal when disconnected
In-Reply-To: <1486768553-13738-2-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-2-git-send-email-keith.busch@intel.com>
Message-ID: <fd836369-7662-c9ef-699d-df2478ef7fa1@suse.de>

On 02/11/2017 12:15 AM, Keith Busch wrote:
> If the device is not present, the driver should disable the queues
> immediately. Prior to this, the driver was relying on the watchdog timer
> to kill the queues if requests were outstanding to the device, and that
> just delays removal up to one second.
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
