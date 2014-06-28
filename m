From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 28 Jun 2014 09:59:17 -0400
Subject: [PATCHv2] NVMe: Mismatched host/device page size support
In-Reply-To: <1403544841-32685-1-git-send-email-keith.busch@intel.com>
References: <1403544841-32685-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140628135917.GV12025@linux.intel.com>

On Mon, Jun 23, 2014@11:34:01AM -0600, Keith Busch wrote:
> @@ -511,13 +512,13 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
>  	if (!prp_list) {
>  		iod->first_dma = dma_addr;
> 	iod->npages = -1;
> -		return (total_len - length) + PAGE_SIZE;
> +		return (total_len - length) + page_size;
>  	}
>  	list[0] = prp_list;
>  	iod->first_dma = prp_dma;
>  	i = 0;
>  	for (;;) {
> -		if (i == PAGE_SIZE / 8) {
> +		if (i == page_size >> 3) {
>  			__le64 *old_prp_list = prp_list;
>  			prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
>  			if (!prp_list)

Something weird happened to this hunk.  There's three lines missing
between lines 3 & 4 of it.  I think I fixed it up right, but please check.
