From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Mar 2017 14:57:44 +0100
Subject: [PATCH rfc 01/10] nvme-pci: Split __nvme_process_cq to poll and
 handle
In-Reply-To: <1489065402-14757-2-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-2-git-send-email-sagi@grimberg.me>
Message-ID: <872aed98-0974-820d-c8fc-0300e40c8fcb@suse.de>

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> Just some rework to split the logic and make it slightly
> more readable. This will help us to easily add the irq-poll
> logic.
> 
> Also, introduce nvme_ring_cq_doorbell helper to mask out the
> cq_vector validity check.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
