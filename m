From: konrad@kernel.org (Konrad Rzeszutek Wilk)
Date: Sun, 15 Jan 2017 12:41:08 -0500
Subject: [PATCH resend] swiotlb: ensure that page-sized mappings are
 page-aligned
In-Reply-To: <1484160991-29624-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1484160991-29624-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <20170115174106.GA6150@localhost.localdomain>

On Wed, Jan 11, 2017@09:56:31PM +0300, Nikita Yushchenko wrote:
> Some drivers do depend on page mappings to be page aligned.
> 
> Swiotlb already enforces such alignment for mappings greater than page,
> extend that to page-sized mappings as well.
> 
> Without this fix, nvme hits BUG() in nvme_setup_prps(), because that routine
> assumes page-aligned mappings.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush at cogentembedded.com>

I queued it up in stable/for-linus-4.10 in swiotlb queue tree.

> ---
>  lib/swiotlb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 975b8fc..a8d74a7 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -483,11 +483,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
>  
>  	/*
> -	 * For mappings greater than a page, we limit the stride (and
> -	 * hence alignment) to a page size.
> +	 * For mappings greater than or equal to a page, we limit the stride
> +	 * (and hence alignment) to a page size.
>  	 */
>  	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> -	if (size > PAGE_SIZE)
> +	if (size >= PAGE_SIZE)
>  		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	else
>  		stride = 1;
> -- 
> 2.1.4
> 
