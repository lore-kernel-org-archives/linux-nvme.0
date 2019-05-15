From: kbusch@kernel.org (Keith Busch)
Date: Wed, 15 May 2019 11:03:20 -0600
Subject: [PATCH 2/2] nvme-pci: support thermal zone
In-Reply-To: <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190515170320.GA21663@localhost.localdomain>

On Thu, May 16, 2019@12:17:17AM +0900, Akinobu Mita wrote:
> This enables to use thermal zone interfaces for NVMe
> temperature sensors.
> 
> Cc: Zhang Rui <rui.zhang at intel.com>
> Cc: Eduardo Valentin <edubezval at gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fad5395..88a25dc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  	if (dev->ctrl.admin_q)
>  		blk_put_queue(dev->ctrl.admin_q);
>  	kfree(dev->queues);
> +	nvme_thermal_zones_unregister(&dev->ctrl);

This unregister should probably go in the nvme_remove() rather than in
the last reference release.
