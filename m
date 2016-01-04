From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Jan 2016 15:10:45 +0000
Subject: [PATCH 2/4] nvme: synchronize access to ctrl->namespaces
In-Reply-To: <1450967222-10404-3-git-send-email-hch@lst.de>
References: <1450967222-10404-1-git-send-email-hch@lst.de>
 <1450967222-10404-3-git-send-email-hch@lst.de>
Message-ID: <20160104151045.GE31375@localhost.localdomain>

On Thu, Dec 24, 2015@03:27:00PM +0100, Christoph Hellwig wrote:
> Currently traversal and modification of ctrl->namespaces happens completely
> unsynchronized, which can be fixed by the addition of a simple mutex.
> 
> Note: nvme_dev_ioctl will be handled in the next patch.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>

Looks good.

Acked-by: Keith Busch <keith.busch at intel.com>
