From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 01:58:34 -0700
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
Message-ID: <20161012085834.GD12972@infradead.org>

On Fri, Oct 07, 2016@04:09:04PM -0700, James Smart wrote:
> 
> nvme-fabrics: Add FC transport FC-NVME definitions:

FYI, all the patches seem to have this duplicate of the subject in
the mail body.

> - cmd_iu changed in T11. The 2 reserved words, previous at words
>   2 and 3, were moved to after the sqe.
> - Modifications from prior reviews:
> -  FC-transport-specific error codes moved to include/linux/nvme.h
> -  Removed 0x28 type declaration to include/uapi/scsi/fc/fc_fs.h
> -  Removed Reject reasons and explanations. ELS values are to be used.

This should go either into the cover letter, or below the "---" line
so that it doesn't show up in the commit message.

> +/* fills in length of a descriptor. Struture minus descriptor header */
> +#define FCNVME_LSDESC_LEN(lsdesc) \
> +		cpu_to_be32(sizeof(lsdesc) - (2*(sizeof(u32))))

Make this an inline function and use spaces between the operators,
please.


Except for these nitpicks the patch looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
