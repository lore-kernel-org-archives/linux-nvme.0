From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Jun 2016 13:30:32 +0300
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
Message-ID: <576A68C8.2060408@grimberg.me>


> Many controller implementations will return errors to commands that will
> not succeed, but without the DNR bit set. The driver previously retried
> these commands an unlimited number of times until the command timeout
> has exceeded, which takes an unnecessarilly long period of time.
>
> This patch limits the number of retries a command can have, defaulting
> to 5, but is user tunable at load or runtime.
>
> The struct request's 'retries' field is used to track the number of
> retries attempted. This is in contrast with scsi's use of this field,
> which indicates how many retries are allowed.

Why not follow the same scheme?

>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   drivers/nvme/host/nvme.h | 5 ++++-
>   drivers/nvme/host/pci.c  | 6 ++++++
>   3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9d7cee4..2b2eca9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -47,6 +47,11 @@ unsigned char shutdown_timeout = 5;
>   module_param(shutdown_timeout, byte, 0644);
>   MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
>
> +unsigned int nvme_max_retries = 5;
> +module_param_named(max_retries, nvme_max_retries, uint, 0644);
> +MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
> +EXPORT_SYMBOL_GPL(nvme_max_retries);

This looks like its a per-controller attribute, it might be better to
make nvme-cli pass this via the vendor extensions? This way we can have
it on a per-controller basis.
