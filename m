From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 2 Jul 2018 12:53:56 +0300
Subject: [PATCH 2/2] nvme-pci: release nvme_ctrl if failed to alloc memory
 in nvme_probe
In-Reply-To: <4c6892da67db3aada7ee4ca5087b44fcb8dde30c.1530457943.git.zhangweiping@didichuxing.com>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
 <4c6892da67db3aada7ee4ca5087b44fcb8dde30c.1530457943.git.zhangweiping@didichuxing.com>
Message-ID: <ae68b07d-9b30-a85e-61e5-b76f4e1a2937@grimberg.me>


> +release_ctrl:
> +	nvme_uninit_ctrl(&dev->ctrl);
> +	nvme_put_ctrl(&dev->ctrl);

Hmm, put_ctrl would trigger nvme_pci_free_ctrl which will
do some of what you fallthru down here, won't that cause
double free/put?

>   release_pools:
>   	nvme_release_prp_pools(dev);
>   unmap:
> 
