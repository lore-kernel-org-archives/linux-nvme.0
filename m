From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Aug 2019 16:49:31 -0700
Subject: [PATCH rfc] nvme: make all fabrics command run on a separate
 request queue
In-Reply-To: <20190808234643.8180-1-sagi@grimberg.me>
References: <20190808234643.8180-1-sagi@grimberg.me>
Message-ID: <01658bb4-6b98-8729-fed9-5a75fd197746@grimberg.me>


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ae30ed75dad9..ccd465220f1e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1623,7 +1623,8 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>   		ret = nvme_identify_ns_descs(ctrl, nsid, ids);
>   		if (ret)
>   			dev_warn(ctrl->device,
> -				 "%s: Identify Descriptors failed\n", __func__);
> +				 "%s: Identify Descriptors failed (%d)\n",
> +				 __func__, ret);
>   	}
>   	return ret;
>   }


Ignore this hunk... unrelated change from a different patch set...
