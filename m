From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 17 Jun 2014 23:45:38 -0400
Subject: [PATCH] NVMe: Async event request
In-Reply-To: <1403045638-16790-1-git-send-email-keith.busch@intel.com>
References: <1403045638-16790-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140618034538.GG12025@linux.intel.com>

On Tue, Jun 17, 2014@04:53:58PM -0600, Keith Busch wrote:
> +static void nvme_submit_async_req(struct nvme_queue *nvmeq)
> +{
> +	struct nvme_command *c;
> +	int cmdid;
> +
> +	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, special_completion, 0);
> +	if (cmdid < 0)
> +		return;

Return -EBUSY here ...

> +	c = &nvmeq->sq_cmds[nvmeq->sq_tail];
> +	memset(c, 0, sizeof(*c));
> +	c->common.opcode = nvme_admin_async_event;
> +	c->common.command_id = cmdid;
> +
> +	if (++nvmeq->sq_tail == nvmeq->q_depth)
> +		nvmeq->sq_tail = 0;
> +	writel(nvmeq->sq_tail, nvmeq->q_db);
> +}

... and 0 here ...

>  static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
>  {
>  	while (bio_list_peek(&nvmeq->sq_cong)) {
> @@ -1876,6 +1909,12 @@ static int nvme_kthread(void *data)
>  				nvme_cancel_ios(nvmeq, true);
>  				nvme_resubmit_bios(nvmeq);
>  				nvme_resubmit_iods(nvmeq);
> +
> +				if (!i) {
> +					for (; dev->event_limit > 0;
> +							dev->event_limit--)
> +						nvme_submit_async_req(nvmeq);
> +				}

... and make this:

				while ((i == 0) && (dev->event_limit > 0)) {
					if (nvme_submit_async_req(nvmeq))
						break;
					dev->event_limit--;
				}

What do you think?
