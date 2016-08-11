From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Aug 2016 14:24:06 -0700
Subject: [PATCH 0/3] nvme-fabrics: Add NVME FC Transport support to lpfc
In-Reply-To: <5792b920.7v71BUERlAKN8sK4%james.smart@broadcom.com>
References: <5792b920.7v71BUERlAKN8sK4%james.smart@broadcom.com>
Message-ID: <20160811212406.GI18013@infradead.org>

On Fri, Jul 22, 2016@05:24:00PM -0700, James Smart wrote:
> 
> This patchset adds NVME support to the lpfc FC driver.  It reworks
> the core driver for both NVME and SCSI protocol support, then adds the
> nvme-over-fabrics host and target interfaces which connect to the 
> NVME FC transport lower-level api.
> 
> Patches are cut against the linux-nvme for-4.8/drivers branch

Before reviewing the details:  what's the plan for merging this as we'll
have dependencies on both the SCSI and the block tree?
