From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Aug 2016 10:00:22 +0300
Subject: [PATCH v4 1/4] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <1471471228-15818-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471471228-15818-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471471228-15818-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <7b7f2836-ad77-b508-ad53-2f49aec03612@grimberg.me>



On 18/08/16 01:00, Jay Freyensee wrote:
> The host will be sending sqsize 0-based values,
> the target need to be adjusted as well.
>
> Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/target/rdma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index e06d504..68b7b04 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1004,11 +1004,11 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
>  	queue->host_qid = le16_to_cpu(req->qid);
>
>  	/*
> -	 * req->hsqsize corresponds to our recv queue size
> -	 * req->hrqsize corresponds to our send queue size
> +	 * req->hsqsize corresponds to our recv queue size plus 1
> +	 * req->hrqsize corresponds to our send queue size plus 1
>  	 */
> -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> +	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
> +	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 1;

hrqsize is sent as is (1's based) so no need to increment.
I'll fix it...
