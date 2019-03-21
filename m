From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Mar 2019 14:40:51 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190321023235.GB15115@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
 <20190321013908.GA15115@ming.t460p>
 <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me>
 <20190321023235.GB15115@ming.t460p>
Message-ID: <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>


> For example,
> 
> nvme_rdma_complete_rq
> 	->nvme_rdma_unmap_data
> 		->ib_mr_pool_put
> 
> But the ib queue pair may has been destroyed by nvme_rdma_destroy_io_queues()
> before request's remote completion.
> 
> nvme_rdma_teardown_io_queues:
>          nvme_stop_queues(&ctrl->ctrl);
>          nvme_rdma_stop_io_queues(ctrl);
>          blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
>                          &ctrl->ctrl);
>          if (remove)
>                  nvme_start_queues(&ctrl->ctrl);
>          nvme_rdma_destroy_io_queues(ctrl, remove);
> 

Yea, you're right. I'm fine with this patchset.
