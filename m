From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 8 Jul 2016 08:51:48 -0500
Subject: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
In-Reply-To: <1467809752-31320-5-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
 <1467809752-31320-5-git-send-email-hch@lst.de>
Message-ID: <003a01d1d91f$df60ed60$9e22c820$@opengridcomputing.com>

> This patch implements the RDMA transport for the NVMe over Fabrics target,
> which allows exporting NVMe over Fabrics functionality over RDMA fabrics
> (Infiniband, RoCE, iWARP).
> 
> All NVMe logic is in the generic target and this module just provides a
> small glue between it and the generic code in the RDMA subsystem.
> 
> Signed-off-by: Armen Baloyan <armenx.baloyan at intel.com>,
> Signed-off-by: Jay Freyensee <james.p.freyensee at intel.com>
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
