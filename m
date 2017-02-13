From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 09:29:37 +0100
Subject: [PATCH v3 02/16] lpfc: use pci_irq_alloc_vectors and
 pci_irq_free_vectors
In-Reply-To: <58a0d91a.9n5crfX+63xwYfdj%jsmart2021@gmail.com>
References: <58a0d91a.9n5crfX+63xwYfdj%jsmart2021@gmail.com>
Message-ID: <041a559d-036b-0782-dafc-159872cc7940@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> From: Christoph Hellwig <hch at lst.de>
> 
> This avoids having to store the msix_entries array and simpliefies the
> shutdown and cleanup path a lot.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
