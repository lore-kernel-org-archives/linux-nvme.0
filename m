From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Jun 2017 12:57:31 -0400
Subject: [nvme-4.13 V2] nvme: Implement NS Optimal IO Boundary from 1.3
 Spec
In-Reply-To: <20170615154726.8337-1-scott.bauer@intel.com>
References: <20170615154726.8337-1-scott.bauer@intel.com>
Message-ID: <20170615165731.GB13399@localhost.localdomain>

On Thu, Jun 15, 2017@09:47:26AM -0600, Scott Bauer wrote:
> The NVMe 1.3 spec introduces Namespace Optimal IO Boundaries (NOIOB),
> which standardizes the stripe mechanism we currently have quirks for.
> This patch implements the necessary logic to handle this new feature.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> ---
>  drivers/nvme/host/core.c | 9 +++++++++
>  drivers/nvme/host/nvme.h | 1 +
>  include/linux/nvme.h     | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4ff5114f467d..dfa72bb2ef0c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1080,6 +1080,12 @@ static void nvme_init_integrity(struct nvme_ns *ns)
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +static void nvme_set_chunk_size(struct nvme_ns *ns)
> +{
> +	unsigned int chunk_size = (((u32)ns->noiob) << ns->lba_shift) >> 9;

Let's say we've a large noiob (16k) with a 4k block size. The above would
shift beyond 32-bits, so I would rewrite this as:

	unsigned int chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
