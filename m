From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 16 Oct 2015 17:30:33 +0000
Subject: [PATCH 05/18] nvme: use offset instead of a struct for registers
In-Reply-To: <1444975128-8768-6-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-6-git-send-email-hch@lst.de>
Message-ID: <20151016173032.GA24702@localhost.localdomain>

On Fri, Oct 16, 2015@07:58:35AM +0200, Christoph Hellwig wrote:
> This makes life easier for future non-PCI drivers where access to the
> registers might be more complicated.  Note that Linux drivers are
> pretty evenly split between the two versions, and in fact the NVMe
> driver already uses offsets for the doorbells.

> +enum {
> +	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
> +	NVME_REG_VS	= 0x0008,	/* Version */
> +	NVME_REG_INTMS	= 0x000c,	/* Interrupt Mask Set */
> +	NVME_REG_INTMC	= 0x0010,	/* Interrupt Mask Set */
> +	NVME_REG_CC	= 0x0014,	/* Controller Configuration */
> +	NVME_REG_CSTS	= 0x001c,	/* Controller Status */
> +	NVME_REG_NSSR	= 0x0020,	/* NVM Subsystem Reset */
> +	NVME_REG_AQA	= 0x0024,	/* Admin Queue Attributes */
> +	NVME_REG_ASQ	= 0x0028,	/* Admin SQ Base Address */
> +	NVME_REG_ACQ	= 0x0030,	/* Admin SQ Base Address */
> +	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
> +	NVME_REG_CMBSZ	= 0x0040,	/* Controller Memory Buffer Size */
>  };

Darn, CMBSZ is offset 0x3c. Missed that in the first review; controllers
with this capability haven't made it to my sanity test machines yet...
