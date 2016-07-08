From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 08 Jul 2016 15:27:28 -0700
Subject: [PATCH -next] nvmet: fix return value check in
 nvmet_subsys_alloc()
In-Reply-To: <1467806529-23712-1-git-send-email-weiyj_lk@163.com>
References: <1467806529-23712-1-git-send-email-weiyj_lk@163.com>
Message-ID: <1468016848.9164.16.camel@linux.intel.com>

On Wed, 2016-07-06@12:02 +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
> 
> In case of error, the function kstrndup() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei at trendmicro.com.cn>

Looks good and inline with how other drivers use kstrndup(), thanks for
the fix.

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> ---
>  drivers/nvme/target/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index e0b3f01..8a891ca 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -895,7 +895,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const
> char *subsysnqn,
>  	subsys->type = type;
>  	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
>  			GFP_KERNEL);
> -	if (IS_ERR(subsys->subsysnqn)) {
> +	if (!subsys->subsysnqn) {
>  		kfree(subsys);
>  		return NULL;
>  	}
> 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
