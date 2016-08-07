From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 7 Aug 2016 10:20:38 +0300
Subject: [PATCH 1/2] nvme-rdma: tell fabrics layer admin queue depth
In-Reply-To: <1470444851-7459-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <970b69cc-b439-63ac-b26e-90f3581b49de@grimberg.me>


> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index dc99676..f81d937 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -363,7 +363,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  	cmd.connect.opcode = nvme_fabrics_command;
>  	cmd.connect.fctype = nvme_fabrics_type_connect;
>  	cmd.connect.qid = 0;
> -	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
> +	cmd.connect.sqsize = cpu_to_le16(ctrl->admin_sqsize);
>  	/*
>  	 * Set keep-alive timeout in seconds granularity (ms * 1000)
>  	 * and add a grace period for controller kato enforcement
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ab18b78..32577a7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -137,6 +137,7 @@ struct nvme_ctrl {
>  	struct delayed_work ka_work;
>
>  	/* Fabrics only */
> +	u16 admin_sqsize;
>  	u16 sqsize;
>  	u32 ioccsz;
>  	u32 iorcsz;

No need for admin_sqsize member, its always set to NVMF_AQ_DEPTH-1,
just use that...
