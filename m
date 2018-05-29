From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Tue, 29 May 2018 17:15:34 +0000
Subject: [PATCH 09/14] nvmet: Add AEN configuration support
In-Reply-To: <20180526102735.31404-10-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-10-hch@lst.de>
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>

[...]
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-
> cmd.c
> index 82d521f60a43..20d9ce5064f8 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -432,6 +432,16 @@ static void nvmet_execute_set_features(struct
> nvmet_req *req)
>  		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
>  		nvmet_set_result(req, req->sq->ctrl->kato);
>  		break;
> +		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
> +		if (val32 & ~NVMET_AEN_SUPPORTED) {
> +			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +			break;
> +		}

This looks overly restrictive - a host sending a Set Features with e.g. the health critical warning bits set in CDW11 will get a failure.  As far as I can tell, this isn't allowed by the spec;  Set Features - Asynchronous Event Configuration and the health log page have been mandatory since NVMe 1.0, and presumably support for the corresponding health log page related AER bits is also mandatory (these were the only bits available in NVMe 1.0).  I think it should be fine to just allow the user to set any (valid) combination of bits here, while still only triggering the NS Changed notification.

Thanks,
-- Daniel
