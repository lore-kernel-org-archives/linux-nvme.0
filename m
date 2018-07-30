From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 30 Jul 2018 08:54:26 -0700
Subject: [PATCH V2 1/3] nvme: add support for ns write protect definitions
In-Reply-To: <20180727025656.9334-2-chaitanya.kulkarni@wdc.com>
References: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
 <20180727025656.9334-2-chaitanya.kulkarni@wdc.com>
Message-ID: <20180730155426.GA29445@infradead.org>

On Thu, Jul 26, 2018@07:56:54PM -0700, Chaitanya Kulkarni wrote:
> Add various definitions from NVMe 1.3 TP 4005.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  include/linux/nvme.h | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 80dfedcf0bf7..8514d4e0b597 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -254,7 +254,7 @@ struct nvme_id_ctrl {
>  	__le16			awun;
>  	__le16			awupf;
>  	__u8			nvscc;
> -	__u8			rsvd531;
> +	__u8			nwpc;
>  	__le16			acwu;
>  	__u8			rsvd534[2];
>  	__le32			sgls;
> @@ -312,7 +312,9 @@ struct nvme_id_ns {
>  	__le16			nabspf;
>  	__le16			noiob;
>  	__u8			nvmcap[16];

> -	__u8			rsvd64[40];
> +	__u8			rsvd64[32];
> +	__u8			nsattr;
> +	__u8			rsvd100[4];

how does this add up?  We remove 8 bytes from rsvd64, but
only add 1 in nsattr and 4 in rsvd100?
