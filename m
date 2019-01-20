From: james.smart@broadcom.com (James Smart)
Date: Sun, 20 Jan 2019 08:38:59 -0800
Subject: [PATCH] nvme-fc: use pci device as parent for nvme controller
In-Reply-To: <20190117074241.40672-1-hare@suse.de>
References: <20190117074241.40672-1-hare@suse.de>
Message-ID: <4aa44211-8305-7474-9ff4-2f21e620ee21@broadcom.com>



On 1/16/2019 11:42 PM, Hannes Reinecke wrote:
> To allow system tools to figure out which pci device provides a
> given NVMe controller this patch moves the nvme controller sysfs
> entry as a child of the PCI device.
>
> With this tools like dracut can traverse the device hierarchy to figure
> out which modules to include.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index feb86b59170e..1ecdec6b8b4a 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3117,7 +3117,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	 * Defer this to the connect path.
>   	 */
>   
> -	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
> +	ret = nvme_init_ctrl(&ctrl->ctrl, ctrl->dev, &nvme_fc_ctrl_ops, 0);
>   	if (ret)
>   		goto out_cleanup_admin_q;
>   

So how do you solve this with rdma and tcp ??? I'm not sure I like 
deviating from them.? Did it pick up the fc-nvme and fabric modules too ?

I think this is one more reason the FC transport needs to be pulled out 
of scsi and layered under the pci device, then shared by scsi and nvme.

-- james
