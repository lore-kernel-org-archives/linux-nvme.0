From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Tue, 15 May 2018 20:28:52 +0000
Subject: Cannot Connect NVMeoF At Certain NR_IO_Queues Values
In-Reply-To: <4b40ebf3-e01c-cf2b-38f5-07d7c5c6e304@mellanox.com>
References: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>
 <743c4b33-2bf8-7c76-95af-62043c2aaeeb@mellanox.com>
 <DE927C68B458BE418D582EC97927A9287FF27624@ORSMSX113.amr.corp.intel.com>
 <4b40ebf3-e01c-cf2b-38f5-07d7c5c6e304@mellanox.com>
Message-ID: <DE927C68B458BE418D582EC97927A9287FF290AF@ORSMSX113.amr.corp.intel.com>


> >> Meanwhile I can suggest a fast workaround for you if needed (or other
> >> solutions as well):
> >> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> >> index
> >> 0f840ec..dd92cb9 100644
> >> --- a/drivers/nvme/host/rdma.c
> >> +++ b/drivers/nvme/host/rdma.c
> >> @@ -2236,7 +2236,7 @@ static int nvme_rdma_map_queues(struct
> >> blk_mq_tag_set *set)
> >>           .init_hctx      = nvme_rdma_init_hctx,
> >>           .poll           = nvme_rdma_poll,
> >>           .timeout        = nvme_rdma_timeout,
> >> -       .map_queues     = nvme_rdma_map_queues,
> >>    };
> >
> > Thanks, I'll give this a shot.
> >
> 
> Great.

Max, I'm not having much luck rebuilding with this code change, to be honest building the kernel from source is not something I'm used to doing.  You mentioned other workarounds may exist, are there any that don't involve rebuilding from the kernel source?

Thanks!
