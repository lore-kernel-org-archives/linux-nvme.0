From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Jan 2018 14:45:19 -0700
Subject: [PATCH RESENT] nvme-pci: introduce RECONNECTING state to mark
 initializing procedure
In-Reply-To: <1516629796-2919-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1516629796-2919-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180125214519.GB20258@localhost.localdomain>

On Mon, Jan 22, 2018@10:03:16PM +0800, Jianchao Wang wrote:
> After Sagi's commit (nvme-rdma: fix concurrent reset and reconnect),
> both nvme-fc/rdma have following pattern:
> RESETTING    - quiesce blk-mq queues, teardown and delete queues/
>                connections, clear out outstanding IO requests...
> RECONNECTING - establish new queues/connections and some other
>                initializing things.
> Introduce RECONNECTING to nvme-pci transport to do the same mark.
> Then we get a coherent state definition among nvme pci/rdma/fc
> transports.
> 
> Suggested-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

This looks fine. Thank you for your patience.

Reviewed-by: Keith Busch <keith.busch at intel.com>
