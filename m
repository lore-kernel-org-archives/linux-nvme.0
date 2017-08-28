From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 16:43:31 +0300
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
In-Reply-To: <1503922057-1141-1-git-send-email-omri@excelero.com>
References: <1503922057-1141-1-git-send-email-omri@excelero.com>
Message-ID: <859a5a5d-9aa1-44e6-7d67-42fed0339a8b@grimberg.me>

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e3b244c..841f35d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -132,6 +132,7 @@ struct nvmet_ctrl {
>   
>   	char			subsysnqn[NVMF_NQN_FIELD_LEN];
>   	char			hostnqn[NVMF_NQN_FIELD_LEN];
> +	u64			host_id;

I'd move it to the first cacheline given it will be accessed
in the hot path.

Other than that, looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
