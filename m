From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 9 Apr 2019 02:22:19 +0000
Subject: [PATCH] nvmet: Return a specified error it subsys_alloc fails
References: <20190407062806.14596-1-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB4527FE299C3DFD93305D767C862D0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 4/6/19 11:28 PM, Minwoo Im wrote:
> nvmet_subsys_alloc() returns its pointer or NULL if it fails.  We can
> see three different steps in this function:
>    1. memory allocation
>    2. argument check
>    3. memory allocation for string
> 
> But now the callers of this function do not seem to handle case 2 by
> returning -ENOMEM only even if it fails with an invalid parameter.
> 
> This patch specifies error codes so that caller can pass it to its own
> caller.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/target/configfs.c  | 4 ++--
>   drivers/nvme/target/core.c      | 6 +++---
>   drivers/nvme/target/discovery.c | 4 ++--
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index adb79545cdd7..08dd5af357f7 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -898,8 +898,8 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>   	}
>   
>   	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
> -	if (!subsys)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(subsys))
> +		return ERR_CAST(subsys);
>   
>   	config_group_init_type_name(&subsys->group, name, &nvmet_subsys_type);
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 4d8dd29479c0..4285870ad01e 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1367,7 +1367,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   
>   	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>   	if (!subsys)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
>   	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
>   	/* generate a random serial number as our controllers are ephemeral: */
> @@ -1383,14 +1383,14 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   	default:
>   		pr_err("%s: Unknown Subsystem type - %d\n", __func__, type);
>   		kfree(subsys);
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   	subsys->type = type;
>   	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
>   			GFP_KERNEL);
>   	if (!subsys->subsysnqn) {
>   		kfree(subsys);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   	}
>   
>   	kref_init(&subsys->ref);
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index c872b47a88f3..aa2406b2e434 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -350,8 +350,8 @@ int __init nvmet_init_discovery(void)
>   {
>   	nvmet_disc_subsys =
>   		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_DISC);
> -	if (!nvmet_disc_subsys)
> -		return -ENOMEM;
> +	if (IS_ERR(nvmet_disc_subsys))
> +		return PTR_ERR(nvmet_disc_subsys);
>   	return 0;
>   }
>   
> 
