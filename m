From: hare@suse.com (Hannes Reinecke)
Date: Thu, 8 Nov 2018 10:35:21 +0100
Subject: [PATCH 1/3] nvme: NUMA locality information for fabrics
In-Reply-To: <20181108092215.GA4574@lst.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181102095641.28504-2-hare@suse.de> <20181108092215.GA4574@lst.de>
Message-ID: <c0e45613-11a6-2ec8-c696-4115a4b77f42@suse.com>

On 11/8/18 10:22 AM, Christoph Hellwig wrote:
> This patch looks good, but the dscription seems extremely misleading.
> 
> I've rewritten it as below for inclusion in nvme-4.21, let me know
> what you think:
> 
> ---
>  From 01d2c22c9d6cd2f0cb2ac2ba5cf98c2ac2d8624e Mon Sep 17 00:00:00 2001
> From: Hannes Reinecke <hare at suse.com>
> Date: Fri, 2 Nov 2018 10:56:39 +0100
> Subject: nvme: add a numa_node field to struct nvme_ctrl
> 
> Instead of directly poking into the struct device add a new numa_node
> field to struct nvme_ctrl.  This allows fabrics drivers where ctrl->dev
> is a virtual device to support NUMA affinity as well.
> 
> Also expose the field as a sysfs attribute, and populate it for the
> RDMA and FC transports.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c      | 4 +++-
>   drivers/nvme/host/fc.c        | 5 +++--
>   drivers/nvme/host/multipath.c | 4 ++--
>   drivers/nvme/host/nvme.h      | 1 +
>   drivers/nvme/host/rdma.c      | 5 +++--
>   5 files changed, 12 insertions(+), 7 deletions(-)
Works for me.

Cheers,

Hannes
