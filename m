From: hch@lst.de (hch@lst.de)
Date: Tue, 30 Apr 2019 12:25:49 +0200
Subject: nvmet: Return PTR_ERR_OR_ZERO in a single line
In-Reply-To: <20190430081251epcms2p8ca90db5f46bb9211a80822dde4771640@epcms2p8>
References: <CGME20190430081251epcms2p8ca90db5f46bb9211a80822dde4771640@epcms2p8>
 <20190430081251epcms2p8ca90db5f46bb9211a80822dde4771640@epcms2p8>
Message-ID: <20190430102549.GA19450@lst.de>

On Tue, Apr 30, 2019@05:12:51PM +0900, Minwoo Im wrote:
> The previous code is not that bad, but it can be a single line to
> return the PTR_ERR or ZERO.
> 
> Reported-by: kbuild test robot <lkp at intel.com>
> Signed-off-by: Minwoo Im <minwoo.im at samsung.com>
> ---
>  drivers/nvme/target/discovery.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index e8e09266bfa5..e3b20f1cb301 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -372,9 +372,7 @@ int __init nvmet_init_discovery(void)
>  {
>  	nvmet_disc_subsys =
>  		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_DISC);
> -	if (IS_ERR(nvmet_disc_subsys))
> -		return PTR_ERR(nvmet_disc_subsys);
> -	return 0;
> +	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);

Honestly, I find the old version much more readable..
