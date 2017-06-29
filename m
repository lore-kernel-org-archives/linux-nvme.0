From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Jun 2017 08:03:32 -0700
Subject: [PATCH 1/7] nvme: move queue_count to the nvme_ctrl
In-Reply-To: <1498734552-14845-2-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
 <1498734552-14845-2-git-send-email-sagi@grimberg.me>
Message-ID: <4ec754c8-ac8c-1701-bab9-846584c79b1e@broadcom.com>

On 6/29/2017 4:09 AM, Sagi Grimberg wrote:
> all drivers use it exactly the same, move it
> to nvme_ctrl. Looking further ahead, nvme core
> will really maintain it.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fc.c     | 35 +++++++++++++++++------------------
>   drivers/nvme/host/nvme.h   |  1 +
>   drivers/nvme/host/pci.c    | 15 +++++++--------
>   drivers/nvme/host/rdma.c   | 39 +++++++++++++++++++--------------------
>   drivers/nvme/target/loop.c | 15 +++++++--------
>   5 files changed, 51 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>
Looks fine

Reviewed-By: James Smart <james.smart at broadcom.com>
