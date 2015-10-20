From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:04:53 +0300
Subject: [PATCH 02/18] nvme: move struct nvme_iod to pci.c
In-Reply-To: <1444975128-8768-3-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-3-git-send-email-hch@lst.de>
Message-ID: <562611C5.4080402@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> This structure is specific to the PCIe driver internals and should be moved
> to pci.c.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Keith Busch <keith.busch at intel.com>

looks good to me:

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
