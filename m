From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 6 Jun 2019 21:40:29 +0000
Subject: [PATCH 1/2] nvme: Introduce NVMe 1.4 Identify Namespace fields in
 struct nvme_id_ns
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-2-bvanassche@acm.org>
Message-ID: <BYAPR04MB57491B1A62AB8B917472232486170@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 06/06/2019 02:29 PM, Bart Van Assche wrote:
> Several new fields have been introduced in version 1.4 of the NVMe spec
> at offsets that were defined as reserved in version 1.3d of the NVMe
> spec. Update the definition of the nvme_id_ns data structure such that
> it is in sync with version 1.4 of the NVMe spec.
>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>   include/linux/nvme.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 8028adacaff3..2b5072ec4511 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -315,7 +315,7 @@ struct nvme_id_ns {
>   	__u8			nmic;
>   	__u8			rescap;
>   	__u8			fpi;
> -	__u8			rsvd33;
> +	__u8			dlfeat;
>   	__le16			nawun;
>   	__le16			nawupf;
>   	__le16			nacwu;
> @@ -324,11 +324,17 @@ struct nvme_id_ns {
>   	__le16			nabspf;
>   	__le16			noiob;
>   	__u8			nvmcap[16];
> -	__u8			rsvd64[28];
> +	__le16			npwg;
> +	__le16			npwa;
> +	__le16			npdg;
> +	__le16			npda;
> +	__le16			nows;
> +	__u8			rsvd74[18];
>   	__le32			anagrpid;
>   	__u8			rsvd96[3];
>   	__u8			nsattr;
> -	__u8			rsvd100[4];
> +	__le16			nvmsetid;
> +	__le16			endgid;
>   	__u8			nguid[16];
>   	__u8			eui64[8];
>   	struct nvme_lbaf	lbaf[16];
>
