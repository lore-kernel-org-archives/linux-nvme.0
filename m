From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 Feb 2017 09:30:25 +0100
Subject: [PATCH v2 01/18] lpfc: Correct WQ creation for pagesize
In-Reply-To: <58990202.ppD+DnSRmfoY41ZK%jsmart2021@gmail.com>
References: <58990202.ppD+DnSRmfoY41ZK%jsmart2021@gmail.com>
Message-ID: <72365ed8-6b4c-2dcf-5a37-ecd5885e1e4f@suse.de>

On 02/07/2017 12:08 AM, James Smart wrote:
> 
> Correct WQ creation for pagesize
> 
> The driver was calculating the adapter command pagesize indicator from
> the system pagesize. However, the buffers the driver allocates are only
> one size (SLI4_PAGE_SIZE), so no calculation was necessary.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> Note: this patch was not in v1
> 
>  drivers/scsi/lpfc/lpfc_hw4.h | 2 ++
>  drivers/scsi/lpfc/lpfc_sli.c | 9 +++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
> index 5646699..964a1fd 100644
> --- a/drivers/scsi/lpfc/lpfc_hw4.h
> +++ b/drivers/scsi/lpfc/lpfc_hw4.h
> @@ -1186,6 +1186,7 @@ struct lpfc_mbx_wq_create {
>  #define lpfc_mbx_wq_create_page_size_SHIFT	0
>  #define lpfc_mbx_wq_create_page_size_MASK	0x000000FF
>  #define lpfc_mbx_wq_create_page_size_WORD	word1
> +#define LPFC_WQ_PAGE_SIZE_4096	0x1
>  #define lpfc_mbx_wq_create_wqe_size_SHIFT	8
>  #define lpfc_mbx_wq_create_wqe_size_MASK	0x0000000F
>  #define lpfc_mbx_wq_create_wqe_size_WORD	word1
> @@ -1257,6 +1258,7 @@ struct rq_context {
>  #define lpfc_rq_context_page_size_SHIFT	0		/* Version 1 Only */
>  #define lpfc_rq_context_page_size_MASK	0x000000FF
>  #define lpfc_rq_context_page_size_WORD	word0
> +#define	LPFC_RQ_PAGE_SIZE_4096	0x1

I wonder why do we need the two LPFC_RQ_PAGE_SIZE_4096 and
LPFC_WQ_PAGE_SIZE_4096 both being 1? Wouldn't a more global
LPFC_PAGE_SIZE_4096 or LPFC_Q_PAGE_SIZE_4096 be sufficient?

But I don't have a strong opinion on this either.

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
