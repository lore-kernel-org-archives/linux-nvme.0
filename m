From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:27:52 +0200
Subject: [PATCH 1/1] nvme-rdma: Introduce
 nvme_rdma_configure_blk/nvme_rdma_destroy_blk
In-Reply-To: <20171108181754.GA471@lst.de>
References: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
 <20171108181754.GA471@lst.de>
Message-ID: <a469a4fb-741e-99d5-9708-4725c9b9a035@grimberg.me>


>> Create new helpers to avoid code and logic duplication between admin/IO
>> block layer resources creation and destruction.
> 
> How is this going to interact with Sagi's refactoring in this area?

It shouldn't really interfere, its just something that will move to
nvme-core as-is, but as I told Max, we need to find a better name for
it.

And I also remember you had a few plans to modify the calling
conventions so if you have a good idea, maybe now would be a good
time to offer something else so we can move up to this direction.
