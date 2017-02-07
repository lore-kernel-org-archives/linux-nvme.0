From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 Feb 2017 09:40:48 +0100
Subject: [PATCH v2 02/18] lpfc: use pci_irq_alloc_vectors and
 pci_irq_free_vectors
In-Reply-To: <58990203.ANy3k+SskRqjvxSM%jsmart2021@gmail.com>
References: <58990203.ANy3k+SskRqjvxSM%jsmart2021@gmail.com>
Message-ID: <e6adeb78-01ee-1394-4afc-69c95bda9276@suse.de>

On 02/07/2017 12:08 AM, James Smart wrote:
> 
> I replaced the v1 patch with Christoph's original
> 
>   james
> 
> From: Christoph Hellwig <hch at lst.de>
> 
> This avoids having to store the msix_entries array and simpliefies the
> shutdown and cleanup path a lot.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: James Smart <james.smart at broadcom.com>
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
