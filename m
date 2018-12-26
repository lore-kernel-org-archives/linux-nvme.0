From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 26 Dec 2018 18:23:16 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
Message-ID: <20181226102314.GA32113@ming.t460p>

On Fri, Dec 21, 2018@02:04:12PM +0800, Shan Hai wrote:
> The num_possible_cpus() number of io queues by default would cause
> irq vector shortage problem on a large system when hotplugging cpus,
> add a module parameter to set number of io queues according to the
> system configuration to fix the issue.
> 
> Signed-off-by: Shan Hai <shan.hai at oracle.com>
> ---
>  drivers/nvme/host/pci.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c33bb20..0d60451 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -64,6 +64,16 @@ MODULE_PARM_DESC(sgl_threshold,
>  		"Use SGLs when average request segment size is larger or equal to "
>  		"this size. Use 0 to disable SGLs.");
>  
> +static int io_queue_number_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops io_queue_number_ops = {
> +	.set = io_queue_number_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int io_queue_number = UINT_MAX;
> +module_param_cb(io_queue_number, &io_queue_number_ops, &io_queue_number, 0644);
> +MODULE_PARM_DESC(io_queue_number, "set io queue number, should >= 2");

I suggest to name it as 'default_queues', and 'queue_count_ops' can be
reused too.

Thanks,
Ming
