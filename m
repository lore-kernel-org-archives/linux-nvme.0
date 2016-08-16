From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:05:39 +0300
Subject: [PATCH v2 5/5] nvme-rdma: adjust hrqsize to plus 1
In-Reply-To: <1471279659-25951-6-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471279659-25951-6-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20c29321-be38-c407-b24a-3cd14db43b73@grimberg.me>



On 15/08/16 19:47, Jay Freyensee wrote:
> Currently under debate due to spec confusion, increase hrqsize
> to one more than hsqsize.
>
> Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> ---
>  drivers/nvme/host/rdma.c   | 4 ++--
>  drivers/nvme/target/rdma.c | 7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 6aa913e..524c2b3 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1289,10 +1289,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
>  	 * specified by the Fabrics standard.
>  	 */
>  	if (priv.qid == 0) {
> -		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
> +		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH);
>  		priv.hsqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
>  	} else {
> -		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
> +		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize + 1);
>  		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
>  	}
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 68b7b04..3557980 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1004,11 +1004,12 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
>  	queue->host_qid = le16_to_cpu(req->qid);
>
>  	/*
> -	 * req->hsqsize corresponds to our recv queue size plus 1
> -	 * req->hrqsize corresponds to our send queue size plus 1
> +	 * req->hsqsize corresponds to our recv queue size plus 1 as
> +	 * this value is based on sqsize, a 0-based value.
> +	 * req->hrqsize corresponds to our send queue size plus 2
>  	 */
>  	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
> -	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 1;
> +	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 2;
>
>  	if (!queue->host_qid && queue->recv_queue_size > NVMF_AQ_DEPTH)
>  		return NVME_RDMA_CM_INVALID_HSQSIZE;
>

Something doesn't look right here.

 From my understanding of the WG discussion. hsqsize is 0's based and
hrqsize isn't.

So this host seems to do the right thing. but why does the target
inc hrqsize+2? you just allocated 2 more recv queue entries when the
host will never send you more than hrqsize.

Am I missing something?
