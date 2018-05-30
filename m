From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:58:42 +0300
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from
 core layer
In-Reply-To: <1527436222-15494-5-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-5-git-send-email-maxg@mellanox.com>
Message-ID: <e11e25ff-fc15-4d0c-f8c8-e8513fafff08@grimberg.me>


> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index d8b6bde..8a0cda6 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -2107,9 +2107,9 @@
>   	}
>   
>   	sig_attrs->check_mask =
> -	       (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
> -	       (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
> -	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
> +	       (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? IB_SIG_CHECK_GUARD : 0)  |
> +	       (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? IB_SIG_CHECK_APPTAG : 0) |
> +	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? IB_SIG_CHECK_REFTAG : 0);

Please consider avoiding >80 char lines.
