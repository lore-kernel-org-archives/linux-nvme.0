From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 18 Nov 2018 00:18:08 +0200
Subject: [PATCH 04/11] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <20181115171626.9306-5-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-5-sagi@lightbitslabs.com>
Message-ID: <3fb868a5-2887-4fa1-d963-05c379ba8a4a@mellanox.com>


On 11/15/2018 7:16 PM, Sagi Grimberg wrote:
> connect_work and err_work will be reused by nvme-tcp so
> share those in nvme_ctrl for rdma and fc to share.
>
> Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>


looks good (and I see that more sharing should be made in the future as 
well :) )

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
