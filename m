From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 29 May 2018 14:22:12 +0200
Subject: [PATCH 04/10] nvme: clear current path on ANA state change
In-Reply-To: <20180529101431.62271-5-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-5-hare@suse.de>
Message-ID: <20180529122212.rd74wmr42nysxii2@linux-x5ow.site>

On Tue, May 29, 2018@12:14:25PM +0200, Hannes Reinecke wrote:
> Whenever ANA state changes the path selection needs to be retriggered,
> so we should be clearing the current path here.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a5f43d164b19..a520582811f8 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -44,6 +44,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
>  {
>  	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state);
> +	nvme_mpath_clear_current_path(ns);

Don't we need the subsys lock when calling
nvme_mpath_clear_current_path()? At least that's how I interpreted
Paul here:
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017484.html


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
