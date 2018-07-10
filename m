From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Jul 2018 13:32:16 +0200
Subject: [PATCH v2 0/2] release /dev/nvmeX if nvme_probe failed
In-Reply-To: <cover.1530548893.git.zhangweiping@didichuxing.com>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
Message-ID: <20180710113216.GA32688@lst.de>

Jens, Keith: any opinion on these?  They seems to look fine to me,
so I'd be tempted to merge them for 4.18.

On Tue, Jul 03, 2018@12:35:07AM +0800, Weiping Zhang wrote:
> 
> Changes since V1:
> * drop patch of remove whitespace
> * release iomap and prp_pools in nvme_pci_free_ctrl
> * direct use nvme_put_ctrl to release resource if failed after
> nvme_init_ctrl in nvme_probe.
> 
> Weiping Zhang (2):
>   nvme-pci: release iomap and prp_pools in nvme_pci_free_ctrl
>   nvme-pci: release nvme_ctrl if failed to alloc memory in nvme_probe
> 
>  drivers/nvme/host/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.14.1
---end quoted text---
