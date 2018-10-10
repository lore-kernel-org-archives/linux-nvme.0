From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Oct 2018 09:34:22 -0600
Subject: [PATCH v2 1/2] nvme-core: Make implicit seed truncation explicit
In-Reply-To: <20181010150820.203745-2-bvanassche@acm.org>
References: <20181010150820.203745-1-bvanassche@acm.org>
 <20181010150820.203745-2-bvanassche@acm.org>
Message-ID: <20181010153421.GA9967@localhost.localdomain>

On Wed, Oct 10, 2018@08:08:19AM -0700, Bart Van Assche wrote:
> The nvme_user_io.slba field is 64 bits wide. That value is copied into the
> 32-bit bio_integrity_payload.bip_iter.bi_sector field. Make that truncation
> explicit to avoid that Coverity complains about implicit truncation. See
> also Coverity ID 1056486 on http://scan.coverity.com/projects/linux.
> 
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>

Looks good, thanks for the update.

Reviewed-by: Keith Busch <keith.busch at intel.com>


>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8cecb36b5af1..65c42448e904 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1132,7 +1132,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  
>  	return nvme_submit_user_cmd(ns->queue, &c,
>  			(void __user *)(uintptr_t)io.addr, length,
> -			metadata, meta_len, io.slba, NULL, 0);
> +			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
>  }
>  
>  static u32 nvme_known_admin_effects(u8 opcode)
> -- 
> 2.19.0.605.g01d371f741-goog
> 
