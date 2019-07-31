From: hare@suse.de (Hannes Reinecke)
Date: Wed, 31 Jul 2019 14:18:55 +0200
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <20190729233201.27993-2-sagi@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
Message-ID: <993aee4e-9f9e-4af1-07e6-69218a12bc1b@suse.de>

On 7/30/19 1:32 AM, Sagi Grimberg wrote:
> If a controller reset is racing with a namespace revalidation, the
> revalidation I/O will surely fail, but we should not remove the
> namespace as we will execute the I/O when the controller is LIVE again.
> Specifically check if the controller is LIVE because as
> RESETTING/CONNECTING are transient and DELETING/DEAD will eventually
> remove the namespace in the removal code path.
> 
> This fixes sporious I/O errors in path failover coditions where the
> controller reset is racing with the namespace scan work.
> 
> Reported-by: Hannes Reinecke  <hare at suse.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa31da0762b9..5f6970e7ba73 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  	ns = nvme_find_get_ns(ctrl, nsid);
>  	if (ns) {
> -		if (ns->disk && revalidate_disk(ns->disk))
> +		if (ns->disk && revalidate_disk(ns->disk) &&
> +		    ctrl->state != NVME_CTRL_LIVE)
>  			nvme_ns_remove(ns);
>  		nvme_put_ns(ns);
>  	} else
> 
The thing I'm worried about here is concurrency (this was also what
caused my earlier attempts to be rejected).
Thing is, the controller state can be set asynchronously. Which in
itself is protected by ctrl->lock, but here we're not taking the lock at
all. Hence we might be seeing a stale value, causing us to makt the
wrong decision.

I have a patchset checking 'ctrl->state' under lock; will be posting it
later.

And another thing: where's the point in 'revalidate_disk()' to be called
if the controller is not live? At best it won't do anything; at worst
we'll stall if we have to do more than one I/O (the reset cycle will
abort _one_ I/O, but if we have to submit more than one we'll be stuck,
too).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
