From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:25:59 +0200
Subject: [PATCH 1/1] nvme-rdma: Introduce
 nvme_rdma_configure_blk/nvme_rdma_destroy_blk
In-Reply-To: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
References: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
Message-ID: <25446ba6-52c9-7e05-b2ab-a7f57600ee31@grimberg.me>

Hey Max,

> Create new helpers to avoid code and logic duplication between admin/IO
> block layer resources creation and destruction.

I really (really) dislike the names (sorry). Can you come up with 
something better?
