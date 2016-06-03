From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Fri, 3 Jun 2016 15:17:35 +0200
Subject: [PATCH] nvme: lightnvme: make MLC num_pairs little endian
In-Reply-To: <1464957858-59392-1-git-send-email-jthumshirn@suse.de>
References: <1464957858-59392-1-git-send-email-jthumshirn@suse.de>
Message-ID: <5751836F.7060407@bjorling.me>

On 06/03/2016 02:44 PM, Johannes Thumshirn wrote:
> According to the OpenChannel SSD interface specification the NAND flash
> MLC page pairing information's number of page page pairings field is the
> first two bytes in the MLC Page Pairing data structure. The hardware's
> data structure itself is little endian so annotate it as such, like the
> rest of lighnvm's data structures.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/host/lightnvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 9461dd6..ea36cbb 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -156,7 +156,7 @@ struct nvme_nvm_completion {
>
>   #define NVME_NVM_LP_MLC_PAIRS 886
>   struct nvme_nvm_lp_mlc {
> -	__u16			num_pairs;
> +	__le16			num_pairs;
>   	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
>   };
>
>

Thanks Johannes. Applied for 4.8.
