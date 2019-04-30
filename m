From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 30 Apr 2019 21:30:26 +0000
Subject: [PATCH 1/2] nvme: move command size checks to the core
References: <20190430153833.9011-1-hch@lst.de>
Message-ID: <SN6PR04MB45274A0053D67600108FA903863A0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good. Just one question about _nvme_check_size(), is there any 
significance for one _ over __ ?

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 4/30/19 8:39 AM, Christoph Hellwig wrote:
> Most command aren't PCIe specific, so move the size checking for them
> to core.c
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
>   drivers/nvme/host/pci.c  | 31 +++----------------------------
>   2 files changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3dd043aa6d1f..e970c5adee28 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3879,10 +3879,37 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>   
> +/*
> + * Check we didn't inadvertently grow the command structure sizes:
> + */
> +static inline void _nvme_check_size(void)
> +{
> +	BUILD_BUG_ON(sizeof(struct nvme_common_command) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_identify) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
> +	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
> +}
> +
> +
>   int __init nvme_core_init(void)
>   {
>   	int result = -ENOMEM;
>   
> +	_nvme_check_size();
> +
>   	nvme_wq = alloc_workqueue("nvme-wq",
>   			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
>   	if (!nvme_wq)
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9b02c4576591..1c4da31a97c2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -226,33 +226,6 @@ struct nvme_iod {
>   	struct scatterlist *sg;
>   };
>   
> -/*
> - * Check we didin't inadvertently grow the command struct
> - */
> -static inline void _nvme_check_size(void)
> -{
> -	BUILD_BUG_ON(sizeof(struct nvme_common_command) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_identify) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
> -	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
> -	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
> -	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
> -	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
> -}
> -
>   static unsigned int max_io_queues(void)
>   {
>   	return num_possible_cpus() + write_queues + poll_queues;
> @@ -2981,6 +2954,9 @@ static struct pci_driver nvme_driver = {
>   
>   static int __init nvme_init(void)
>   {
> +	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
>   	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
>   	return pci_register_driver(&nvme_driver);
>   }
> @@ -2989,7 +2965,6 @@ static void __exit nvme_exit(void)
>   {
>   	pci_unregister_driver(&nvme_driver);
>   	flush_workqueue(nvme_wq);
> -	_nvme_check_size();
>   }
>   
>   MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
> 
