From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jun 2017 12:34:29 -0400
Subject: [PATCH 0/7] Few patches extracted from the centralization set
In-Reply-To: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170629163428.GE3110@localhost.localdomain>

On Thu, Jun 29, 2017@02:09:05PM +0300, Sagi Grimberg wrote:
> Feedback was that they made sense on their own.
> Plus also few patches that I came up with.
> 
> The repetition of patches seem to highlight the fact that we
> will benefit centralization of shared logic.
> 
> Sagi Grimberg (7):
>   nvme: move queue_count to the nvme_ctrl
>   nvme: move ctrl cap to struct nvme_ctrl
>   nvme-pci: rename to nvme_pci_configure_admin_queue
>   nvme-fc: don't override opts->nr_io_queues
>   nvme-rdma: update tagset nr_hw_queues after reconnecting/resetting
>   nvme-loop: update tagset nr_hw_queues after reconnecting/resetting
>   nvme-fc: update tagset nr_hw_queues after queues reinit

All of these look fine to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
