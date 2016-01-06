From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 19:51:12 +0000
Subject: [PATCHv3 4/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160106130419.GA23245@infradead.org>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
 <1451923859-14187-5-git-send-email-keith.busch@intel.com>
 <20160106130419.GA23245@infradead.org>
Message-ID: <20160106195112.GB20732@localhost.localdomain>

On Wed, Jan 06, 2016@05:04:19AM -0800, Christoph Hellwig wrote:
> -static int nvme_delete_queue(struct nvme_queue *nvmeq, struct request_queue *q)
> +static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>  {
> +	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
>  	struct request *req;
> +	struct nvme_command cmd;
>  
> -	req = nvme_alloc_request(q, (struct nvme_command *)&nvmeq->dq,
> -							BLK_MQ_REQ_NOWAIT);
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.delete_queue.opcode = nvme_admin_delete_sq;

Now I actually ran with the proposal and found this minor opcode
oversight. Should be:

+	cmd.delete_queue.opcode = opcode;

After that, it's successful.
