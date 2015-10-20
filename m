From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:08:01 +0300
Subject: [PATCH 04/18] nvme: add a vendor field to struct nvme_dev
In-Reply-To: <1444975128-8768-5-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-5-git-send-email-hch@lst.de>
Message-ID: <56261281.8080904@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> The SCSI translation layer currently has to poke into the PCI device
> structure to find a vendor ID for the device identification fallback.
> We won't nessecarily have a PCI device behind the device structure in
> the future, so add a new vendor field that can be filled out by the
> PCIe driver instead.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Keith Busch <keith.busch at intel.com>

looks good to me,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
