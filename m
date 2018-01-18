From: james.smart@broadcom.com (James Smart)
Date: Thu, 18 Jan 2018 07:23:50 -0800
Subject: [PATCH V5 1/2] nvme-pci: introduce RECONNECTING state to mark
 initializing procedure
In-Reply-To: <1516270202-8051-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516270202-8051-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <bdeedcd0-b761-3bf1-e0a5-3885fe29fd44@broadcom.com>

On 1/18/2018 2:10 AM, Jianchao Wang wrote:
> After Sagi's commit (nvme-rdma: fix concurrent reset and reconnect),
> both nvme-fc/rdma have following pattern:
> RESETTING    - quiesce blk-mq queues, teardown and delete queues/
>                 connections, clear out outstanding IO requests...
> RECONNECTING - establish new queues/connections and some other
>                 initializing things.
> Introduce RECONNECTING to nvme-pci transport to do the same mark.
> Then we get a coherent state definition among nvme pci/rdma/fc
> transports.
>
> Suggested-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>   drivers/nvme/host/core.c |  2 +-
>   drivers/nvme/host/pci.c  | 19 +++++++++++++++++--
>   2 files changed, 18 insertions(+), 3 deletions(-)
>

Reviewed-by: James Smart? <james.smart at broadcom.com>
