From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 7 May 2018 09:21:35 +0200
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-6-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
Message-ID: <20180507072135.mys4whntstzowyux@linux-x5ow.site>

On Fri, May 04, 2018@01:28:45PM +0200, Hannes Reinecke wrote:
> Add ANA support to the nvme host. If ANA is supported the state
> and the group id are displayed in new sysfs attributes 'ana_state' and
> 'ana_group'.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c      | 123 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/multipath.c |  12 ++++-
>  drivers/nvme/host/nvme.h      |   3 ++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62262fac7a5d..14dff8e96899 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -99,6 +99,7 @@ static struct class *nvme_subsys_class;
>  
>  static void nvme_ns_remove(struct nvme_ns *ns);
>  static int nvme_revalidate_disk(struct gendisk *disk);
> +static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns);
>  
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -1488,6 +1489,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>  		goto out;
>  	}
>  
> +	if (ctrl->subsys->cmic & (1 << 3))
> +		nvme_get_ana_log(ctrl, ns);
> +

Can you move nvme_get_ana_log(), et al above nvme_reset_ctrl() so we
don't need the forward declaration?

      Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
