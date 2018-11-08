From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 8 Nov 2018 11:24:56 -0500
Subject: nvme: make ANA support independent on native nvme multipath
In-Reply-To: <20181105154136.142597-1-hare@suse.de>
References: <20181105154136.142597-1-hare@suse.de>
Message-ID: <20181108162456.GA28854@redhat.com>

On Mon, Nov 05 2018 at 10:41am -0500,
Hannes Reinecke <hare@suse.de> wrote:

> NVMe native multipathing is an implementation detail on the host,
> and ANA support is actually independent on that.
> So we shouldn't check for native NVMe multipathing when trying to
> evaluate whether ANA is supported; not doing so results in the
> ANA sysfs attributes not to be present when the 'multipath=false'
> module option is set.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 4944ffdf6831..f7efcaeb2d98 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -22,7 +22,7 @@ MODULE_PARM_DESC(multipath,
>  
>  inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>  {
> -	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
> +	return ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
>  }
>  
>  /*
> -- 
> 2.16.4
> 

So you're going for ANA to work with CONFIG_NVME_MULTIPATH=Y but
nvme_core.multipath=N

Yes please.

Acked-by: Mike Snitzer <snitzer at redhat.com>
