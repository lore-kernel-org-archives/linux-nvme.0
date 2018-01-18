From: james.smart@broadcom.com (James Smart)
Date: Thu, 18 Jan 2018 07:34:59 -0800
Subject: [PATCH V5 0/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <273980d4-0b11-a3fc-ca83-00e8f957ba87@broadcom.com>

Jianchao,

This looks very coherent to me. Thank You.

-- james



On 1/18/2018 2:10 AM, Jianchao Wang wrote:
> Hello
>
> Please consider the following scenario.
> nvme_reset_ctrl
>    -> set state to RESETTING
>    -> queue reset_work
>      (scheduling)
> nvme_reset_work
>    -> nvme_dev_disable
>      -> quiesce queues
>      -> nvme_cancel_request
>         on outstanding requests
> -------------------------------_boundary_
>    -> nvme initializing (issue request on adminq)
>
> Before the _boundary_, not only quiesce the queues, but only cancel
> all the outstanding requests.
>
> A request could expire when the ctrl state is RESETTING.
>   - If the timeout occur before the _boundary_, the expired requests
>     are from the previous work.
>   - Otherwise, the expired requests are from the controller initializing
>     procedure, such as sending cq/sq create commands to adminq to setup
>     io queues.
> In current implementation, nvme_timeout cannot identify the _boundary_
> so only handles second case above.
>
> In fact, after Sagi's commit (nvme-rdma: fix concurrent reset and
> reconnect), both nvme-fc/rdma have following pattern:
> RESETTING    - quiesce blk-mq queues, teardown and delete queues/
>                 connections, clear out outstanding IO requests...
> RECONNECTING - establish new queues/connections and some other
>                 initializing things.
> Introduce RECONNECTING to nvme-pci transport to do the same mark
> Then we get a coherent state definition among nvme pci/rdma/fc
> transports and nvme_timeout could identify the _boundary_.
>
> V5:
>   - discard RESET_PREPARE and introduce RESETTING into nvme-pci
>   - change the 1st patch's name and comment
>   - other misc changes
>
> V4:
>   - rebase patches on Jens' for-next
>   - let RESETTING equal to RECONNECTING in terms of work procedure
>   - change the 1st patch's name and comment
>   - other misc changes
>
> V3:
>   - fix wrong reference in loop.c
>   - other misc changes
>
> V2:
>   - split NVME_CTRL_RESETTING into NVME_CTRL_RESET_PREPARE and
>     NVME_CTRL_RESETTING. Introduce new patch based on this.
>   - distinguish the requests based on the new state in nvme_timeout
>   - change comments of patch
>
> drivers/nvme/host/core.c |  2 +-
> drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++-----------
> 2 files changed, 33 insertions(+), 12 deletions(-)
>
> Thanks
> Jianchao
