From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:31:50 +0200
Subject: [PATCH 3/5] nvme-multipath: fixup crash during disconnect
In-Reply-To: <20180716105837.101125-4-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-4-hare@suse.de>
Message-ID: <20180719143150.GC19339@lst.de>

On Mon, Jul 16, 2018@12:58:35PM +0200, Hannes Reinecke wrote:
> The kernel will crash during disconnect, if the first path is
> 'optimized' and the second 'non-optimized'. Then upon removing the
> first path any I/O coming in _before_ removing the second path will
> find the first path to be unusable, and assign 'fallback' to the
> second. But after exiting the loop it will assign the _first_ path
> to 'current_path', leading to a crash later on.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 8980b0137fa5..5205f41c0f6c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -129,7 +129,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
>  	}
>  
>  	if (fallback)
> -		rcu_assign_pointer(head->current_path, ns);
> +		rcu_assign_pointer(head->current_path, fallback);
>  	return fallback;

This doesn't match the current version of __nvme_find_path that was
in the last posted series or the git tree.  What tree do you work against?
