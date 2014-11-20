From: keith.busch@intel.com (Keith Busch)
Date: Thu, 20 Nov 2014 23:41:36 +0000 (UTC)
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <546E6784.6000609@micron.com>
References: <546E6784.6000609@micron.com>
Message-ID: <alpine.LNX.2.00.1411202312020.4225@localhost.lm.intel.com>

On Thu, 20 Nov 2014, Sam Bradshaw wrote:
> There are several expensive divide operations in the submit and
> completion paths that can be converted to less expensive arithmetic
> and logical operations.  Profiling shows significant drops in time
> spent in nvme_alloc_iod() under common workloads as a result of this
> change.

Very cool. I didn't see a difference on my processor's TSC when I added
even more divides to the IO path for mismatched page size support,
but I was afraid it'd have higher cost elsewhere. Thanks for the patch.

> Patch is against Jens' for-3.19/drivers branch.
>
> Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> ---
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 9310fe5..a5e2ebc 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -360,8 +360,14 @@ static __le64 **iod_list(struct nvme_iod *iod)
>  */
> static int nvme_npages(unsigned size, struct nvme_dev *dev)
> {
> -	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
> -	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
> +	unsigned page_size = (1 << dev->page_shift);
> +	unsigned nprps = (size >> dev->page_shift) + 1;
> +
> +	if (size & (page_size - 1))
> +		nprps++;
> +	if ((nprps << 3) < (page_size - 8))
> +		return 1;

You actually don't need to subtract 8 here. That's for reserving a place
for chaining a PRP list, but we don't need to reserve a place if all
the entries fit in page.

> +	return DIV_ROUND_UP(nprps << 3, page_size - 8);

Can we get rid of this divide too?!
