From: keith.busch@intel.com (Keith Busch)
Date: Tue, 25 Apr 2017 14:58:13 -0400
Subject: [PATCH] nvme-scsi: remove nvme_trans_security_protocol
In-Reply-To: <20170425170056.15735-1-hch@lst.de>
References: <20170425170056.15735-1-hch@lst.de>
Message-ID: <20170425185812.GB8927@localhost.localdomain>

On Tue, Apr 25, 2017@07:00:56PM +0200, Christoph Hellwig wrote:
> This function just returns the same error code and sense data as
> the default statement in the switch in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
