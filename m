From: don.brace@microsemi.com (Don Brace)
Date: Wed, 28 Mar 2018 14:48:46 +0000
Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
References: <20180327153908.3732-1-keith.busch@intel.com>
Message-ID: <d7482679138342c08e5efb5c461f7536@microsemi.com>

> -----Original Message-----
> From: linux-scsi-owner at vger.kernel.org [mailto:linux-scsi-
> owner at vger.kernel.org] On Behalf Of Keith Busch
> Sent: Tuesday, March 27, 2018 10:39 AM
> To: Linux NVMe <linux-nvme at lists.infradead.org>; Linux Block <linux-
> block at vger.kernel.org>
> Cc: Christoph Hellwig <hch at lst.de>; Sagi Grimberg <sagi at grimberg.me>;
> Jianchao Wang <jianchao.w.wang at oracle.com>; Ming Lei
> <ming.lei at redhat.com>; Jens Axboe <axboe at kernel.dk>; Keith Busch
> <keith.busch at intel.com>; Don Brace <don.brace at microsemi.com>; qla2xxx-
> upstream at qlogic.com; linux-scsi at vger.kernel.org
> Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
> 
> EXTERNAL EMAIL
> 
> 
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0; a driver may allocate pre_vectors for special use. This
> patch adds an offset parameter so blk-mq may find the intended affinity
> mask and updates all drivers using this API accordingly.
> 
> Cc: Don Brace <don.brace at microsemi.com>
> Cc: <qla2xxx-upstream at qlogic.com>
> Cc: <linux-scsi at vger.kernel.org>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1 -> v2:
> 
>   Update blk-mq API directly instead of chaining a default parameter to
>   a new API, and update all drivers accordingly.
> 
>  block/blk-mq-pci.c                    | 6 ++++--
>  drivers/nvme/host/pci.c               | 2 +-
>  drivers/scsi/qla2xxx/qla_os.c         | 2 +-
>  drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>  include/linux/blk-mq-pci.h            | 3 ++-
>  5 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c
> b/drivers/scsi/smartpqi/smartpqi_init.c
> index b2880c7709e6..10c94011c8a8 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -5348,7 +5348,7 @@ static int pqi_map_queues(struct Scsi_Host *shost)
>  {
>         struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
> 
> -       return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev);
> +       return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev, 0);
>  }
> 

Acked-by: Don Brace <don.brace at microsemi.com>
