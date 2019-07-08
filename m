From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Jul 2019 02:59:09 -0700
Subject: [PATCH 1/3] nvmet: print a hint while rejecting NSID 0 or
 0xffffffff
In-Reply-To: <8a62f718d2b1b77c548be8009dbcfc9a3f75f7cf.1562234605.git.mskorzhinskiy@solarflare.com>
References: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
 <8a62f718d2b1b77c548be8009dbcfc9a3f75f7cf.1562234605.git.mskorzhinskiy@solarflare.com>
Message-ID: <fd654531-d950-8afb-41e0-997c96b1d636@grimberg.me>

Please send it as a separate patch not related to the other two...

> Adding this hint for the sake of convenience.
> 
> It was spotted that a few times people spent some time before understanding
> what is exactly wrong in configuration process. This should save a few time
> in such situations, especially for people who is not very confident with
> NVMe requirements.
> 
> Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
> ---
>   drivers/nvme/target/configfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 08dd5af357f7..c91cad4f7927 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -588,8 +588,10 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
>   		goto out;
>   
>   	ret = -EINVAL;
> -	if (nsid == 0 || nsid == NVME_NSID_ALL)
> +	if (nsid == 0 || nsid == NVME_NSID_ALL) {
> +		pr_err("NSIDs 0 and 0xffffffff are invalid NSIDs\n");

Why not?
		pr_err("invalid nsid %#x", nsid);
