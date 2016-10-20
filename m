From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Oct 2016 14:08:06 -0700
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <015c01d22b12$5e9f4e70$1bddeb50$@opengridcomputing.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
 <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
 <31822981-0032-98aa-6570-450351020463@sandisk.com>
 <012601d22afd$5a310460$0e930d20$@opengridcomputing.com>
 <015201d22b0b$4f526440$edf72cc0$@opengridcomputing.com>
 <015c01d22b12$5e9f4e70$1bddeb50$@opengridcomputing.com>
Message-ID: <2ce6e308-0a64-8d68-dbf0-8c58c78e1af0@sandisk.com>

On 10/20/2016 01:41 PM, Steve Wise wrote:
> And here is a proposed change to nvme_rdma to use rdma_reject_msg().  If you
 > like this idea, I'll send out these two patches, or send them to you to
 > include in your series.
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 601aecf..41a2d4c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1237,18 +1237,19 @@ out_destroy_queue_ib:
>  static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
>                 struct rdma_cm_event *ev)
>  {
> +       short nvme_status = -1;
> +
>         if (ev->param.conn.private_data_len) {
>                 struct nvme_rdma_cm_rej *rej =
>                         (struct nvme_rdma_cm_rej *)ev->param.conn.private_data;
>
> -               dev_err(queue->ctrl->ctrl.device,
> -                       "Connect rejected, status %d.", le16_to_cpu(rej->sts));
> -               /* XXX: Think of something clever to do here... */
> -       } else {
> -               dev_err(queue->ctrl->ctrl.device,
> -                       "Connect rejected, no private data.\n");
> +               nvme_status = le16_to_cpu(rej->sts);
>         }
>
> +       dev_err(queue->ctrl->ctrl.device, "Connect rejected: status %d (%s) "
> +               "nvme status %d.\n", ev->status,
> +               rdma_reject_msg(queue->cm_id, ev->status), nvme_status);
> +
>         return -ECONNRESET;
>  }

Hello Steve,

Had you already realized that the description of my patch 6/6 shows that 
it is not guaranteed on an IB setup that ev->param.conn.private_data_len 
== 0 for other cases than IB_CM_REJ_CONSUMER_DEFINED?

Thanks,

Bart.
