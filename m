From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Nov 2016 20:39:56 +0100
Subject: rework NVMe command passthrough
In-Reply-To: <1477411779-2993-1-git-send-email-hch@lst.de>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
Message-ID: <20161109193956.GA29228@lst.de>

Jens, Keith:

any opinion on this series?  I'd really prefer to have something
like this in before merging the NVMe FC support.

On Tue, Oct 25, 2016@06:09:37PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series started out as part of my attempt to get rid of the SCSI
> passthrough fields in struct request, but reviewing the NVMe FC patches
> and subsequent discussion with James gave them additional priority.
> 
> This series introduce? a nvme nvme_request structure common to all
> transports, which allows us to stop abusing the SCSI passthrough fields
> in struct request, and also allows us to stop passing the full CQE
> up to the callers of the request interface which is rather painful
> for FC.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
