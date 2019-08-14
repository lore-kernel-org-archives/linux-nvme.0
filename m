From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Aug 2019 17:20:51 +0300
Subject: [PATCH v7 01/14] nvme-core: introduce nvme_ctrl_get_by_path()
In-Reply-To: <20190801234514.7941-2-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-2-logang@deltatee.com>
Message-ID: <e107b5f4-de8b-4dd1-2855-aa65e9f47376@mellanox.com>


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> It makes use of filp_open() to open the file and uses the private
> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
> file do not match, -EINVAL is returned.
>
> The purpose of this function is to support NVMe-OF target passthru.
>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  2 ++
>   2 files changed, 26 insertions(+)


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
