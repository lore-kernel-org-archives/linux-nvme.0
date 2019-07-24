From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Wed, 24 Jul 2019 14:33:39 +0200
Subject: [PATCH 1/5] lnvm: make data_len to sizeof() instead of magic
 number
In-Reply-To: <20190723183601.29370-2-minwoo.im.dev@gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-2-minwoo.im.dev@gmail.com>
Message-ID: <80d59219-12b7-47da-d37e-9fd9941260de@lightnvm.io>

On 23/07/2019 20.35, Minwoo Im wrote:
> We can have it as a sizeof() instead of the hard-coded value for the
> data structure.
>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   nvme-lightnvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
> index 0b99786..e8cdccd 100644
> --- a/nvme-lightnvm.c
> +++ b/nvme-lightnvm.c
> @@ -442,7 +442,7 @@ static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
>   		.opcode		= nvme_nvm_admin_identity,
>   		.nsid		= nsid,
>   		.addr		= (__u64)(uintptr_t)nvm_id,
> -		.data_len	= 0x1000,
> +		.data_len	= sizeof(struct nvme_nvm_id),
>   	};
>   
>   	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);

Works for me.

Please use use my Signed-off-by instead of Reviewed-by - traditionally 
Keith has been kind to wait to pull in patches until I got a chance to 
look at them on Github. Having the review here on the mailing list and 
later as a pull request on github makes it explicit that I signed off on it.

Signed-off-by: Matias Bj?rling <matias.bjorling at wdc.com>

Thank you!

- Matias
