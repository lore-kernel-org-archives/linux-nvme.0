From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Feb 2017 04:49:35 -0800
Subject: [PATCH v2 02/18] lpfc: use pci_irq_alloc_vectors and
 pci_irq_free_vectors
In-Reply-To: <58990203.ANy3k+SskRqjvxSM%jsmart2021@gmail.com>
References: <58990203.ANy3k+SskRqjvxSM%jsmart2021@gmail.com>
Message-ID: <20170208124935.GC23225@infradead.org>

On Mon, Feb 06, 2017@03:08:51PM -0800, James Smart wrote:
> 
> I replaced the v1 patch with Christoph's original
> 
>   james
> 
> From: Christoph Hellwig <hch at lst.de>

Everything above this from line should not go into the mail sent
to the list.  Note that git-send-email will automatically do the right
thing for you as long as the patch has been properly applied to your
local tree.
