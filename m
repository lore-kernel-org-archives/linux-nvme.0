From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 27 Oct 2016 05:49:06 -0700
Subject: [PATCH] nvme-loop: kfree(ctrl) on _create() error exit
In-Reply-To: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20161027124906.GA28200@infradead.org>

On Wed, Oct 26, 2016@01:20:57PM -0700, Jay Freyensee wrote:
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index d5df77d..b0f9931 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -673,6 +673,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>  	nvme_uninit_ctrl(&ctrl->ctrl);
>  out_put_ctrl:
>  	nvme_put_ctrl(&ctrl->ctrl);
> +	kfree(ctrl);
>  	if (ret > 0)
>  		ret = -EIO;
>  	return ERR_PTR(ret);

This will give us a double free.  The final put in nvme_put_ctrl calls
->free_ctrl which will free the controller.
