From: mlin@kernel.org (Ming Lin)
Date: Thu, 9 Jun 2016 14:54:16 -0700
Subject: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
In-Reply-To: <051801d1c297$c7d8a7d0$5789f770$@opengridcomputing.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <051801d1c297$c7d8a7d0$5789f770$@opengridcomputing.com>
Message-ID: <CAF1ivSag+pbhRcNu+VmJYd5FmzwxZ==Ebge78TaZkXqKC-Sidg@mail.gmail.com>

On Thu, Jun 9, 2016@2:42 PM, Steve Wise <swise@opengridcomputing.com> wrote:

> Should the above error path actually goto a block that frees the rsps?  Like
> this?
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index c184ee5..8aaa36f 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1053,7 +1053,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
>                                 !queue->host_qid);
>                 if (IS_ERR(queue->cmds)) {
>                         ret = NVME_RDMA_CM_NO_RSC;
> -                       goto out_free_cmds;
> +                       goto out_free_responses;
>                 }
>         }
>
> @@ -1073,6 +1073,8 @@ out_free_cmds:
>                                 queue->recv_queue_size,
>                                 !queue->host_qid);
>         }
> +out_free_responses:
> +        nvmet_rdma_free_rsps(queue);
>  out_ida_remove:
>         ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
>  out_destroy_sq:

Yes. Nice catch.
