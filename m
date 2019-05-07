From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 7 May 2019 11:52:58 -0600
Subject: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
In-Reply-To: <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> Copy telemetry log page definisions from nvme-cli.
> 
> Cc: Johannes Berg <johannes at sipsolutions.net>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
> * v2
> - New patch in this version.
> 
>   include/linux/nvme.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c40720c..5217fe4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -396,6 +396,28 @@ enum {
>   	NVME_NIDT_UUID		= 0x03,
>   };
>   
> +/* Derived from 1.3a Figure 101: Get Log Page ? Telemetry Host
> + * -Initiated Log (Log Identifier 07h)
> + */

Is this Host Initiated or Controller Initiated? The comment says host
initiated but everything else seems to indicated controller initiated.
Is controller initiated even the correct choice because the controller
would have sent an AER to indicate that the host should pull the
telemetry data.


> +struct nvme_telemetry_log_page_hdr {
> +	__u8    lpi; /* Log page identifier */
> +	__u8    rsvd[4];
> +	__u8    iee_oui[3];
> +	__le16  dalb1; /* Data area 1 last block */
> +	__le16  dalb2; /* Data area 2 last block */
> +	__le16  dalb3; /* Data area 3 last block */
> +	__u8    rsvd1[368]; /* TODO verify */
> +	__u8    ctrlavail; /* Controller initiated data avail?*/
> +	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> +	__u8    rsnident[128];
> +	/* We'll have to double fetch so we can get the header,
> +	 * parse dalb1->3 determine how much size we need for the
> +	 * log then alloc below. Or just do a secondary non-struct
> +	 * allocation.
> +	 */
> +	__u8    telemetry_dataarea[0];
> +};
> +
>   struct nvme_smart_log {
>   	__u8			critical_warning;
>   	__u8			temperature[2];
> @@ -832,6 +854,7 @@ enum {
>   	NVME_LOG_FW_SLOT	= 0x03,
>   	NVME_LOG_CHANGED_NS	= 0x04,
>   	NVME_LOG_CMD_EFFECTS	= 0x05,
> +	NVME_LOG_TELEMETRY_CTRL	= 0x08,
>   	NVME_LOG_ANA		= 0x0c,
>   	NVME_LOG_DISC		= 0x70,
>   	NVME_LOG_RESERVATION	= 0x80,
> 
