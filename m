From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 5 Jun 2017 17:08:16 +0300
Subject: [PATCH] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
References: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
Message-ID: <f732eb30-4582-1daa-21e2-c7c03b9af9e0@mellanox.com>



On 6/5/2017 12:45 PM, Marta Rybczynska wrote:
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
>  drivers/nvme/host/rdma.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 28bd255..80682f7 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -88,7 +88,7 @@ enum nvme_rdma_queue_flags {
>
>  struct nvme_rdma_queue {
>         struct nvme_rdma_qe     *rsp_ring;
> -       u8                      sig_count;
> +       atomic_t                sig_count;
>         int                     queue_size;
>         size_t                  cmnd_capsule_len;
>         struct nvme_rdma_ctrl   *ctrl;
> @@ -554,6 +554,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
>
>         queue->queue_size = queue_size;
>
> +       atomic_set(&queue->sig_count, 0);
> +
>         queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
>                         RDMA_PS_TCP, IB_QPT_RC);
>         if (IS_ERR(queue->cm_id)) {
> @@ -1038,17 +1040,26 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>                 nvme_rdma_wr_error(cq, wc, "SEND");
>  }
>
> -static inline int nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> +static inline int nvme_rdma_init_sig_count(int queue_size)
>  {
> -       int sig_limit;
> -
> -       /*
> -        * We signal completion every queue depth/2 and also handle the
> -        * degenerated case of a  device with queue_depth=1, where we
> -        * would need to signal every message.
> +       /* We want to signal completion at least every queue depth/2.
> +        * This returns the largest power of two that is not above half
> +        * of (queue size + 1) to optimize (avoid divisions).
>          */
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

Maybe I'm missing something, but why we need to calc limit each time in 
data path (not a big deal but we can avoid that)?
Can you add queue->sig_limit that will be calculated once at queue 
allocation ?

> +       count = atomic_inc_return(&queue->sig_count);
> +
> +       /* Signal if count is a multiple of limit */
> +       if ((count & (limit - 1)) == 0)
> +               return true;
> +       return false;
>  }
>
>  static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
>
