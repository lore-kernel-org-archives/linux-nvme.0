From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Fri, 19 Jun 2015 22:47:04 +0000
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9D03A71F1@NTXBOIMBX02.micron.com>



> @@ -376,7 +394,12 @@ static int __nvme_submit_cmd(struct nvme_queue
> *nvmeq, struct nvme_command *cmd)  {
>  	u16 tail = nvmeq->sq_tail;
> 
> -	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +	if (nvmeq->cmb_mapped)
> +		memcpy_toio(&nvmeq->sq_cmds[tail], cmd,
> +				sizeof(*cmd));
> +	else
> +		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +
>  	if (++tail == nvmeq->q_depth)
>  		tail = 0;
>  	writel(tail, nvmeq->q_db);

I think a store fence is necessary between memcpy_toio() and the doorbell ring.
This applies elsewhere in the patch as well.

For example, we've seen rare cases where Haswells do not emit the whole SQE out 
of the write combine buffers before the doorbell write traverses PCIe.  Other 
architectures may have a similar need.  
