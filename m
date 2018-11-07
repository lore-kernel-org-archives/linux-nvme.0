From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Nov 2018 19:15:31 -0800
Subject: [PATCH] nvmet-rdma: Fix using unallocated nvmet_rdma_delete_wq
In-Reply-To: <2b8067ce-9943-0345-31ff-e71b06c57568@mellanox.com>
References: <1541435031-16919-1-git-send-email-israelr@mellanox.com>
 <2b8067ce-9943-0345-31ff-e71b06c57568@mellanox.com>
Message-ID: <5d3b0ef9-0559-699c-e845-cb0ac8162cda@grimberg.me>


> Sagi/Christoph/Keith,
> 
> please note that the problematic commit? "nvmet-rdma: use a private 
> workqueue for delete" is only merged to nvme-4.20 so this fix can be 
> squashed to it IMO.

I think we need to revert 2acf70a ("nvmet-rdma: use a private workqueue 
for delete") altogether because it never made any difference..
