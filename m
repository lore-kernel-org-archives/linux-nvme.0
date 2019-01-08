From: emilne@redhat.com (Ewan D. Milne)
Date: Tue, 08 Jan 2019 11:22:41 -0500
Subject: [PATCH] nvme-multipath: zero out ANA log buffer
In-Reply-To: <20190108114658.13747-1-hare@suse.de>
References: <20190108114658.13747-1-hare@suse.de>
Message-ID: <bf26a377e7373a1bf6efe2d8ecc02bafd61583b5.camel@redhat.com>

On Tue, 2019-01-08@12:46 +0100, Hannes Reinecke wrote:
> When nvme_init_identify() fails the ANA log buffer is deallocated
> but _not_ set to NULL. This can cause double free oops when this
> controller is deleted without ever being reconnected.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 183ec17ba067..df4b3a6db51b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -570,6 +570,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	return 0;
>  out_free_ana_log_buf:
>  	kfree(ctrl->ana_log_buf);
> +	ctrl->ana_log_buf = NULL;
>  out:
>  	return error;
>  }
> @@ -577,5 +578,6 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  {
>  	kfree(ctrl->ana_log_buf);
> +	ctrl->ana_log_buf = NULL;
>  }
>  

Reviewed-by: Ewan D. Milne <emilne at redhat.com>
