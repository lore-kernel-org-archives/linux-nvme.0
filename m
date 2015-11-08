From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 8 Nov 2015 12:54:12 +0200
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <1446915643-21175-9-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
Message-ID: <563F29D4.5030801@dev.mellanox.co.il>


> +static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
> +
> +	list_del(&ctrl->list);

This should be list_del_init so that cleanup_module
list_empty() check will be correct. unloading nvme-loop
with active controllers is getting a list corruption.
