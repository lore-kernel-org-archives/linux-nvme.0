From: hch@lst.de (Christoph Hellwig)
Date: Wed, 2 Nov 2016 15:40:45 +0100
Subject: [PATCH v2] nvmet: Fix possible infinite loop triggered on hot
 namespace removal
In-Reply-To: <1478015644-26108-1-git-send-email-sagi@grimberg.me>
References: <1478015644-26108-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161102144045.GB13577@lst.de>

On Tue, Nov 01, 2016@05:54:04PM +0200, Sagi Grimberg wrote:
> From: Solganik Alexander <sashas at lightbitslabs.com>
> 
> When removing a namespace we delete it from the subsystem namespaces
> list with list_del_init which allows us to know if it is enabled or
> not.
> 
> The problem is that list_del_init initialize the list next and does
> not respect the RCU list-traversal we do on the IO path for locating
> a namespace. Instead we need to use list_del_rcu which is allowed to
> run concurrently with the _rcu list-traversal primitives (keeps list
> next intact) and guarantees concurrent nvmet_find_naespace forward
> progress.
> 
> By changing that, we cannot rely on ns->dev_link for knowing if the
> namspace is enabled, so add enabled indicator entry to nvmet_ns for
> that.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Solganik Alexander <sashas at lightbitslabs.com>
> Cc: <stable at vger.kernel.org> # v4.8+
> ---
> Changes from v1:
> - Changed enabled from atomic bit to bool and updated it under
>   the subsys lock in order to protect against enable/disable
>   running concurrently
> - Fixed nvmet_ns_enabled display
> 
>  drivers/nvme/target/core.c  | 15 +++++++++------
>  drivers/nvme/target/nvmet.h |  3 ++-
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 6559d5afa7bf..bf36d2486245 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -264,9 +264,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	int ret = 0;
>  
>  	mutex_lock(&subsys->lock);
> -	if (!list_empty(&ns->dev_link))
> +	if (ns->enabled)
>  		goto out_unlock;
>  
> +	ns->enabled = true;
> +
>  	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
>  			NULL);
>  	if (IS_ERR(ns->bdev)) {

This will leave the enable flag set when an error happen? later,
won't it?  I'd set it just before dropping the lock.

>  static inline bool nvmet_ns_enabled(struct nvmet_ns *ns)
>  {
> -	return !list_empty_careful(&ns->dev_link);
> +	return ns->enabled;

and we can probably kill this helper, it's pretty pointless
now.
