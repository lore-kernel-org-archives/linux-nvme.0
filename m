From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 14:53:28 +0300
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
Message-ID: <6eb8ac59-cb3f-d0eb-f6cb-fb232e30957c@grimberg.me>


>  static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -957,6 +1001,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_dev *dev = nvmeq->dev;
>  	struct request *abort_req;
>  	struct nvme_command cmd;
> +	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +
> +	/*
> +	 * Reset immediately if the controller is failed
> +	 */
> +	if (nvme_should_reset(dev, readl(dev->bar + NVME_REG_CSTS))) {
> +		nvme_warn_reset(dev, csts);
> +		nvme_dev_disable(dev, false);

Why the nvme_dev_disable here? its going to happen in reset_work..

Other then that this change looks good!
