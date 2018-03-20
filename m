From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 20 Mar 2018 14:56:19 +0200
Subject: [PATCH] nvme: Skip checking heads without namespaces
In-Reply-To: <20180319165350.9879-1-keith.busch@intel.com>
References: <20180319165350.9879-1-keith.busch@intel.com>
Message-ID: <79a25da6-baa1-7f8d-825d-41202bd440aa@mellanox.com>



On 3/19/2018 6:53 PM, Keith Busch wrote:
> If a task is holding a reference to a namespace on a removed controller,
> the head will not be released. If the same controller is added again
> later, its namespaces may not be successfully added. Instead, the user
> will see kernel message "Duplicate IDs for nsid <X>".
> 
> This patch fixes that by skipping heads that don't have namespaces when
> considering if a new namespace is safe to add.
> 
> Reported-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>
> Cc: stable at vger.kernel.org
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7aeca5db7916..0b9e60861e53 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2793,6 +2793,7 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
>   
>   	list_for_each_entry(h, &subsys->nsheads, entry) {
>   		if (nvme_ns_ids_valid(&new->ids) &&
> +		    !list_empty(&h->list) &&
>   		    nvme_ns_ids_equal(&new->ids, &h->ids))
>   			return -EINVAL;
>   	}
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
