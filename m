From: james.smart@broadcom.com (James Smart)
Date: Mon, 22 Jul 2019 08:42:44 -0700
Subject: [PATCH 0/4] small set of nvme cleanups
In-Reply-To: <20190719194546.24229-1-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
Message-ID: <3086fcef-efb2-85e4-4e36-2c5734cf3068@broadcom.com>



On 7/19/2019 12:45 PM, Sagi Grimberg wrote:
> Centralizes queue size settings for fabrics and
> removes redundant argument to nvme_disable/enable_ctrl.
>
> Sagi Grimberg (4):
>    nvme: have nvme_init_identify set ctrl->cap
>    nvme: move sqsize setting to the core
>    nvme: don't pass cap to nvme_disable_ctrl
>    nvme: don't pass cap to nvme_enable_ctrl
>
>   drivers/nvme/host/core.c   | 19 ++++++++++---------
>   drivers/nvme/host/fc.c     | 12 +-----------
>   drivers/nvme/host/nvme.h   |  4 ++--
>   drivers/nvme/host/pci.c    |  7 ++++---
>   drivers/nvme/host/rdma.c   | 15 ++-------------
>   drivers/nvme/host/tcp.c    | 13 ++-----------
>   drivers/nvme/target/loop.c | 12 +-----------
>   7 files changed, 22 insertions(+), 60 deletions(-)
>

The changes look fine except for 1 main issue:? All of the nvmf 
transports call nvme_enable_ctrl(), which still references ctrl->cap, 
before they call nvme_init_identify().

-- james
