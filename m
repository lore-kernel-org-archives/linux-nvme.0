From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 09:27:52 +0100
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>
References: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
 <20190321013908.GA15115@ming.t460p>
 <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me>
 <20190321023235.GB15115@ming.t460p>
 <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>
Message-ID: <20190327082752.GN20525@lst.de>

On Thu, Mar 21, 2019@02:40:51PM -0700, Sagi Grimberg wrote:
>> nvme_rdma_teardown_io_queues:
>>          nvme_stop_queues(&ctrl->ctrl);
>>          nvme_rdma_stop_io_queues(ctrl);
>>          blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
>>                          &ctrl->ctrl);
>>          if (remove)
>>                  nvme_start_queues(&ctrl->ctrl);
>>          nvme_rdma_destroy_io_queues(ctrl, remove);
>>
>
> Yea, you're right. I'm fine with this patchset.

Is this an official Reviewed-by?
