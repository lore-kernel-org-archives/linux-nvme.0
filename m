From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 30 Mar 2018 11:48:19 -0600
Subject: [RFC PATCH 1/8] nvme-core: add new interfaces
In-Reply-To: <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
Message-ID: <d3235b3f-9253-64d2-d488-144c384be6f9@deltatee.com>



On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
> +int nvme_get_ctrl_by_name(char *ctrl_name, struct nvme_ctrl **ctrl)
> +{
> +	int ret = -ENODEV;
> +	char str[256] = "/dev/";

Kernel code should not make assumptions about the layout of the
filesystem. Prepending "/dev/" to a controller name is icky. I'd suggest
looking at blkdev_get_by_path() and doing something similar. Also this
function should probably be called nvme_get_ctrl_by_path() seeing it
seems to be trying to take a path and not a name.

Logan
