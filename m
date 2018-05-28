From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:21:55 +0200
Subject: [PATCH 02/17] RDMA/core: introduce check masks for T10-PI offload
In-Reply-To: <1527436222-15494-3-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-3-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072155.GC5618@lst.de>

On Sun, May 27, 2018@06:50:07PM +0300, Max Gurtovoy wrote:
> T10-PI offload capability is currently supported in iSER protocol only,
> and the definition of the HCA protection information checks are missing
> from the core layer. Add those definition to avoid code duplication in
> other drivers (such iSER target and NVMeoF).
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  include/rdma/ib_verbs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 9fc8a82..bdb1bbc 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -861,6 +861,19 @@ enum ib_sig_err_type {
>  };
>  
>  /**
> + * Signature check masks (8 bytes in total) according to the T10-PI standard:
> + *  -------- -------- ------------
> + * | GUARD  | APPTAG |   REFTAG   |
> + * |  2B    |  2B    |    4B      |
> + *  -------- -------- ------------
> + */
> +enum {
> +	IB_SIG_CHECK_GUARD = 0xc0,
> +	IB_SIG_CHECK_APPTAG = 0x30,
> +	IB_SIG_CHECK_REFTAG = 0x0f,
> +};

Maybe align the equal signs using tabs?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
