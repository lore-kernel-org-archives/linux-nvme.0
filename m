From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 8 Jul 2016 08:53:59 -0500
Subject: [PATCH 5/5] nvme-rdma: add a NVMe over Fabrics RDMA host driver
In-Reply-To: <1467809752-31320-6-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
 <1467809752-31320-6-git-send-email-hch@lst.de>
Message-ID: <003c01d1d920$2d5c0040$881400c0$@opengridcomputing.com>

> This patch implements the RDMA host (initiator in SCSI speak) driver.  It
> can be used to connect to remote NVMe over Fabrics controllers over
> Infiniband, RoCE or iWarp, and uses the existing NVMe core driver as well
> a the new fabrics library.
> 
> To connect to all NVMe over Fabrics controller reachable on a given taget
> port using RDMA/CM use the following command:
> 
> 	nvme connect-all -t rdma -a $IPADDR
> 
> This requires the latest version of nvme-cli with Fabrics support.
> 
> Signed-off-by: Jay Freyensee <james.p.freyensee at intel.com>
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks fine.

Reviewed by: Steve Wise <swise at opengridcomputing.com>
