From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 14:16:15 +0300
Subject: [PATCH] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
References: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
Message-ID: <97a72992-3ac3-74d9-96dc-22c31bbb6694@grimberg.me>



On 05/06/17 12:45, Marta Rybczynska wrote:
> This patch improves the way the RDMA IB signalling is done
> by using atomic operations for the signalling variable. This
> avoids race conditions on sig_count.
> 
> The signalling interval changes slightly and is now the
> largest power of two not larger than queue depth / 2.
> 
> ilog() usage idea by Bart Van Assche.
> 
> Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
> ---
>   drivers/nvme/host/rdma.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 28bd255..80682f7 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -88,7 +88,7 @@ enum nvme_rdma_queue_flags {
>   
>   struct nvme_rdma_queue {
>          struct nvme_rdma_qe     *rsp_ring;
> -       u8                      sig_count;
> +       atomic_t                sig_count;
>          int                     queue_size;
>          size_t                  cmnd_capsule_len;
>          struct nvme_rdma_ctrl   *ctrl;
> @@ -554,6 +554,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
>   
>          queue->queue_size = queue_size;
>   
> +       atomic_set(&queue->sig_count, 0);
> +
>          queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
>                          RDMA_PS_TCP, IB_QPT_RC);
>          if (IS_ERR(queue->cm_id)) {
> @@ -1038,17 +1040,26 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>                  nvme_rdma_wr_error(cq, wc, "SEND");
>   }
>   
> -static inline int nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> +static inline int nvme_rdma_init_sig_count(int queue_size)
>   {
> -       int sig_limit;
> -
> -       /*
> -        * We signal completion every queue depth/2 and also handle the
> -        * degenerated case of a  device with queue_depth=1, where we
> -        * would need to signal every message.
> +       /* We want to signal completion at least every queue depth/2.
> +        * This returns the largest power of two that is not above half
> +        * of (queue size + 1) to optimize (avoid divisions).
>           */
> -       sig_limit = max(queue->queue_size / 2, 1);
> -       return (++queue->sig_count % sig_limit) == 0;
> +       return 1 << ilog2((queue_size + 1) / 2);
> +}
> +
> +static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> +{
> +       int count, limit;
> +
> +       limit = nvme_rdma_init_sig_count(queue->queue_size);

Why calling it init? you're not initializing anything...

I'd just call it nvme_rdma_sig_limit()

> +       count = atomic_inc_return(&queue->sig_count);
> +
> +       /* Signal if count is a multiple of limit */
> +       if ((count & (limit - 1)) == 0)
> +               return true;
> +       return false;
>   }

You can replace it with:
	return (atomic_inc_return(&queue->sig_count) & (limit - 1)) == 0;

And lose the local count variable.
