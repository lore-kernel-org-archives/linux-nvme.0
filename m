From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:56:29 +0300
Subject: [PATCH 02/17] RDMA/core: introduce check masks for T10-PI offload
In-Reply-To: <1527436222-15494-3-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-3-git-send-email-maxg@mellanox.com>
Message-ID: <b3cc5f74-8408-d2aa-6d96-894533350ddf@grimberg.me>


>   /**
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
> +
> +/**
>    * struct ib_sig_err - signature error descriptor
>    */
>   struct ib_sig_err {

I'm thinking we ought to move al the dif/signature stuff to its own
header rather than spamming ib_verbs.h...

Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
