From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 11 Apr 2019 22:54:11 +0000
Subject: [PATCH 2/2] nvme: pci: Make sure command struct size fixed
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
 <20190411151832.26481-3-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB452756EC40F44F0D939D42CA862F0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good,

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 4/11/19 8:19 AM, Minwoo Im wrote:
> All the NVMe command has 64bytes fixed size so that it has been assured
> with BUILD_BUG_ON().  The remaining command structures in linux/nvme.h
> also need to be checked here.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c1eecde6b853..fd43d1a7bd16 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -231,19 +231,26 @@ struct nvme_iod {
>    */
>   static inline void _nvme_check_size(void)
>   {
> +	BUILD_BUG_ON(sizeof(struct nvme_common_command) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_identify) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
>   	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
>   	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
>   }
>   

>   static unsigned int max_io_queues(void)
> 
