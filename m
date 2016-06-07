From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 10:47:54 -0400
Subject: [PATCH 5/5] nvme-rdma: add a NVMe over Fabrics RDMA host driver
In-Reply-To: <1465248215-18186-6-git-send-email-hch@lst.de>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-6-git-send-email-hch@lst.de>
Message-ID: <20160607144753.GA28414@localhost.localdomain>

On Mon, Jun 06, 2016@11:23:35PM +0200, Christoph Hellwig wrote:
> To connect to all NVMe over Fabrics controller reachable on a given taget
> port using RDMA/CM use the following command:
> 
> 	nvme connect-all -t rdma -a $IPADDR
> 
> This requires the latest version of nvme-cli with Fabrics support.

Is there a public fork or patch set available for the user tools? I'd
be happy to merge that in.

Overall, this whole series is looking really good. I'll try this out on
some machines today.
