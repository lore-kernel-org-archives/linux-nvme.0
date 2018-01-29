From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jan 2018 09:01:46 -0700
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180129160145.GA25515@localhost.localdomain>

On Mon, Jan 29, 2018@11:07:35AM +0800, Jianchao Wang wrote:
> nvme_set_host_mem will invoke nvme_alloc_request without NOWAIT
> flag, it is unsafe for nvme_dev_disable. The adminq driver tags
> may have been used up when the previous outstanding adminq requests
> cannot be completed due to some hardware error. We have to depend
> on the timeout path to complete the previous outstanding adminq
> requests and free the tags.
> However, nvme_timeout will invoke nvme_dev_disable and try to
> get the shutdown_lock which is held by another context who is
> sleeping to wait for the tags to be freed by timeout path. A
> deadlock comes up.
> 
> To fix it, let nvme_set_host_mem use NOWAIT flag.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Thanks for the fix. It looks like we still have a problem, though.
Commands submitted with the "shutdown_lock" held need to be able to make
forward progress without relying on a completion, but this one could
block indefinitely.


>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6fe7af0..9532529 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1736,7 +1736,8 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
>  	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
>  	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
>  
> -	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
> +	ret = __nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0, 0,
> +			NVME_QID_ANY, 0, BLK_MQ_REQ_NOWAIT);
>  	if (ret) {
>  		dev_warn(dev->ctrl.device,
>  			 "failed to set host mem (err %d, flags %#x).\n",
> -- 
