From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Sep 2017 16:11:32 -0400
Subject: [PATCH 4/4] nvme-pci: implement the HMB entry number and size
 limitations
In-Reply-To: <20170906135532.21358-5-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
 <20170906135532.21358-5-hch@lst.de>
Message-ID: <20170906201131.GE17331@localhost.localdomain>

On Wed, Sep 06, 2017@03:55:32PM +0200, Christoph Hellwig wrote:
> Adds support for the new Host Memory Buffer Minimum Descriptor Entry Size
> and Host Memory Maximum Descriptors Entries field that were added in
> TP 4002 HMB Enhancements.  These allow the controller to advertise
> limits for the usual number of segments in the host memory buffer, as
> well as a minimum usable per-segment size.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
