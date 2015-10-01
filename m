From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 1 Oct 2015 15:39:47 +0300
Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
 nvme_queue structures
In-Reply-To: <1443493217.3449.14.camel@linux.intel.com>
References: <1443493217.3449.14.camel@linux.intel.com>
Message-ID: <560D2993.50000@dev.mellanox.co.il>

On 9/29/2015 5:20 AM, J Freyensee wrote:
>  From f8a686150998471ea28347a946753cabc73bb79a Mon Sep 17 00:00:00 2001
> From: Jay Sternberg <jay.e.sternberg at intel.com>
> Date: Fri, 25 Sep 2015 12:20:59 -0700
> Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
> nvme_queue structures
>

It would really help if you can spare a few words on what this patch
is all about and more importantly list the specifics splits and 
additions (no need for every bit) so it will be easier for the reader.

> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) 2015 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~
> + *
> + * The NVMe Fabrics project separates the NVMe (Non-Volatile Memory
> express)
> + * SSD protocol from the physical technology or 'fabric' (RDMA,
> ethernet,
> + * PCIe, etc) used as the bus communication mechanism between the
> storage
> + * device and the rest of the system. Thus, this initial NVMe
> framework
> + * makes no assumption that a technology like PCIe or RDMA is being
> + * used to carry out the protocol.
> + *
> + * This file is used to specify all pci specific data structures and
> + * functions that would implement PCI NVMe device.
> + */
> +

Is this text really needed here? Perhaps this type text belongs in a
dedicated Documentation/nvme.txt (which will probably be needed at some
point).

And let's lose the ~~~ separator...
