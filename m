From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 17 Aug 2016 10:13:23 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
Message-ID: <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>

> 
> Can this be related due to the fact that we use a signle-threaded
> workqueue for delete/reset/reconnect? (delete cancel_sync the active
> reconnect work...)
> 
> Does this untested patch help?

That seems to do it!


> --
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8d2875b4c56d..78a47c17fb01 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1997,7 +1997,7 @@ static struct nvmf_transport_ops
> nvme_rdma_transport = {
> 
>   static int __init nvme_rdma_init_module(void)
>   {
> -       nvme_rdma_wq = create_workqueue("nvme_rdma_wq");
> +       nvme_rdma_wq = alloc_workqueue("nvme_rdma_wq", 0, 0);
>          if (!nvme_rdma_wq)
>                  return -ENOMEM;
> --
