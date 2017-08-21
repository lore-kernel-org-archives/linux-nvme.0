From: james.smart@broadcom.com (James Smart)
Date: Mon, 21 Aug 2017 15:45:37 -0700
Subject: [PATCH 1/3] nvme: add virt boundary per ctrl
In-Reply-To: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
Message-ID: <9457a92d-fb58-2e57-7530-336d15364736@broadcom.com>

On 8/16/2017 3:20 AM, Max Gurtovoy wrote:
> Prepare an infrastructure for controllers that can handle arbitrarily
> sized bios (e.g advanced RDMA and PCI ctrls). Add virt_boundary_mask
> according to each ctrl constraints.
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/core.c   |    2 +-
>   drivers/nvme/host/fc.c     |    1 +
>   drivers/nvme/host/nvme.h   |    1 +
>   drivers/nvme/host/pci.c    |    1 +
>   drivers/nvme/host/rdma.c   |    1 +
>   drivers/nvme/target/loop.c |    1 +
>   6 files changed, 6 insertions(+), 1 deletions(-)
>
>
Looks fine to me.

Reviewed-By: James Smart <james.smart at broadcom.com>
