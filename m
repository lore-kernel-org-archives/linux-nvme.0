From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 10 Apr 2019 18:18:24 +0000
Subject: [PATCH] nvme: rdma: Fix typo in struct comment
References: <20190410144859.25772-1-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB4527BB2A57F8D4EBAC4B5B48862E0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 04/10/2019 07:49 AM, Minwoo Im wrote:
> struct nvme_rdma_cm_rej has two different attributes: recfmt and sts.
> And sts will have value what this comment wanted to show.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   include/linux/nvme-rdma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> index 3aa97b98dc89..3ec8e50efa16 100644
> --- a/include/linux/nvme-rdma.h
> +++ b/include/linux/nvme-rdma.h
> @@ -77,7 +77,7 @@ struct nvme_rdma_cm_rep {
>    * struct nvme_rdma_cm_rej - rdma connect reject
>    *
>    * @recfmt:        format of the RDMA Private Data
> - * @fsts:          error status for the associated connect request
> + * @sts:           error status for the associated connect request
>    */
>   struct nvme_rdma_cm_rej {
>   	__le16		recfmt;
>
