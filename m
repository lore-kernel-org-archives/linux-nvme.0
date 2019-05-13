From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 15:34:15 +0000
Subject: [PATCH v3 4/7] nvme: add basic facility to get telemetry log page
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/12/2019 08:55 AM, Akinobu Mita wrote:
> This adds the required definisions to get telemetry log page.
s/definisions/definitions/
> The telemetry log page structure and identifier are copied from nvme-cli.
>
> We also need a facility to check log page attributes in order to know
> the controller supports the telemetry log pages and log page offset field
> for the Get Log Page command.  The telemetry data area could be larger
> than maximum data transfer size, so we may need to split into multiple
> transfers with incremental page offset.
>
> Cc: Johannes Berg <johannes at sipsolutions.net>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke at intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
> * v3
> - Merge 'add telemetry log page definisions' patch and 'add facility to
>    check log page attributes' patch
> - Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli
> - Add BUILD_BUG_ON for the size of struct nvme_telemetry_log_page_hdr
>
>   drivers/nvme/host/core.c |  2 ++
>   drivers/nvme/host/nvme.h |  1 +
>   include/linux/nvme.h     | 17 +++++++++++++++++
>   3 files changed, 20 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a6644a2..0cea2a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2585,6 +2585,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	} else
>   		ctrl->shutdown_timeout = shutdown_timeout;
>
> +	ctrl->lpa = id->lpa;
>   	ctrl->npss = id->npss;
>   	ctrl->apsta = id->apsta;
>   	prev_apst_enabled = ctrl->apst_enabled;
> @@ -3898,6 +3899,7 @@ static inline void _nvme_check_size(void)
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
>   	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_telemetry_log_page_hdr) != 512);
>   	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
>   	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5ee75b5..7f6f1fc 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -195,6 +195,7 @@ struct nvme_ctrl {
>   	u32 vs;
>   	u32 sgls;
>   	u16 kas;
> +	u8 lpa;
>   	u8 npss;
>   	u8 apsta;
>   	u32 oaes;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c40720c..8c0b29d 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -294,6 +294,8 @@ enum {
>   	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
>   	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
>   	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
> +	NVME_CTRL_LPA_EXTENDED_DATA		= 1 << 2,
> +	NVME_CTRL_LPA_TELEMETRY_LOG		= 1 << 3,
>   };
>
>   struct nvme_lbaf {
> @@ -396,6 +398,20 @@ enum {
>   	NVME_NIDT_UUID		= 0x03,
>   };
>
> +struct nvme_telemetry_log_page_hdr {
> +	__u8    lpi; /* Log page identifier */
> +	__u8    rsvd[4];
> +	__u8    iee_oui[3];
> +	__le16  dalb1; /* Data area 1 last block */
> +	__le16  dalb2; /* Data area 2 last block */
> +	__le16  dalb3; /* Data area 3 last block */
> +	__u8    rsvd1[368];
> +	__u8    ctrlavail; /* Controller initiated data avail?*/
> +	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> +	__u8    rsnident[128];
> +	__u8    telemetry_dataarea[0];
> +};
> +

nit:- Thanks for adding the comments, can you please align all the above 
comments like :-

+struct nvme_telemetry_log_page_hdr {
+       __u8    lpi;            /* Log page identifier */
+       __u8    rsvd[4];
+       __u8    iee_oui[3];
+       __le16  dalb1;          /* Data area 1 last block */
+       __le16  dalb2;          /* Data area 2 last block */
+       __le16  dalb3;          /* Data area 3 last block */
+       __u8    rsvd1[368];
+       __u8    ctrlavail;      /* Controller initiated data avail?*/
+       __u8    ctrldgn;        /* Controller initiated telemetry Data 
Gen # */
+       __u8    rsnident[128];
+       __u8    telemetry_dataarea[0];
+};
+


>   struct nvme_smart_log {
>   	__u8			critical_warning;
>   	__u8			temperature[2];
> @@ -832,6 +848,7 @@ enum {
>   	NVME_LOG_FW_SLOT	= 0x03,
>   	NVME_LOG_CHANGED_NS	= 0x04,
>   	NVME_LOG_CMD_EFFECTS	= 0x05,
> +	NVME_LOG_TELEMETRY_CTRL	= 0x08,
>   	NVME_LOG_ANA		= 0x0c,
>   	NVME_LOG_DISC		= 0x70,
>   	NVME_LOG_RESERVATION	= 0x80,
>
