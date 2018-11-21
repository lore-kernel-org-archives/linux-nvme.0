From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 14:04:32 +0100
Subject: [PATCH v2 07/14] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <20181120030019.31738-9-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-9-sagi@grimberg.me>
Message-ID: <20181121130432.GB1373@lst.de>

On Mon, Nov 19, 2018@07:00:09PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi at lightbitslabs.com>
> 
> connect_work and err_work will be reused by nvme-tcp so
> share those in nvme_ctrl for rdma and fc to share.

As said before when you sent this invididually:  I'd rather not move
struct members to the common struture until we actually start using
it there.  So for now please add it to the containing TCP-specific
structure, although I'm looking forward to actually see code around
it consolidated eventually.
