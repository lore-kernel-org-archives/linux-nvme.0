From: keith.busch@gmail.com (Keith Busch)
Date: Mon, 29 Jul 2019 18:59:11 -0600
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <20190729233201.27993-2-sagi@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
Message-ID: <CAOSXXT6kG36vCf7wj8aJG+9fARYP9y+SB8TogfKuc+g20S_TYg@mail.gmail.com>

On Mon, Jul 29, 2019@5:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
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
>         ns = nvme_find_get_ns(ctrl, nsid);
>         if (ns) {
> -               if (ns->disk && revalidate_disk(ns->disk))
> +               if (ns->disk && revalidate_disk(ns->disk) &&
> +                   ctrl->state != NVME_CTRL_LIVE)
>                         nvme_ns_remove(ns);

That should be '== NVME_CTRL_LIVE', right? You don't want to remove it
for the resetting state, and the removing states take care of removal
directly.

On the RESETTING state, shouldn't we avoid calling revalidate_disk()
in the first place? An intermittent failure during reset could cause
the disk to temporarily go to a zero-capacity, which may cause some
filesystem issues that we could avoid if we know we're about to rescan
this namespace.

>                 nvme_put_ns(ns);
>         } else
