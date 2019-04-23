From: kbusch@kernel.org (Keith Busch)
Date: Tue, 23 Apr 2019 12:02:29 -0600
Subject: Controller memory buffer - P2PDMA question
In-Reply-To: <5979444b-1fbf-3471-ceb0-d90c705c40d7@intel.com>
References: <5979444b-1fbf-3471-ceb0-d90c705c40d7@intel.com>
Message-ID: <20190423180228.GA15382@localhost.localdomain>

On Tue, Apr 23, 2019@11:55:03AM -0600, Heitke, Kenneth wrote:
> For the controller memory buffer, the read-data (RDS) and write-data (WDS)
> support isn't required to symmetrical since there are individual bits for
> each. The code below requires that both be supported before the P2P memory
> will be published
> 
> nvme_map_cmb:nvme/host/pci.c
> 
>         if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
>                         (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
>                 pci_p2pmem_publish(pdev, true);
> 
> Would it make sense for P2PDMA to support the idea of directionality? Should
> a device be able to publish its controller memory buffer just for TO_DEVICE
> and/or FROM_DEVICE?

P2P needs both directions for registered device memory. It
indiscriminately selects peer destinations, which are later used as
sources.
