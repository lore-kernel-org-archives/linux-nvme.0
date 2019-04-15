From: minwoo.im@samsung.com (Minwoo Im)
Date: Tue, 16 Apr 2019 07:30:29 +0900
Subject: [PATCH 0/2] nvme: pci: Fix queue_count parameter
In-Reply-To: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
 <CGME20190411155300epcas5p49adfec0820281f7c3fd918ba59d9cf7d@epcms2p1>
Message-ID: <20190415223029epcms2p1a3f2e25f3b0c265adfcf15429076cbee@epcms2p1>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Minwoo Im
> Sent: Friday, April 12, 2019 12:53 AM
> To: linux-nvme at lists.infradead.org
> Cc: Keith Busch; Jens Axboe; Minwoo Im; Christoph Hellwig; Sagi Grimberg
> Subject: [PATCH 0/2] nvme: pci: Fix queue_count parameter
> 
> The first patch will make it return an error if given value is larger
> than number of possible cpus.  It has not been doing anything about it.
> 
> The second patch is just a nit for clean-up of local variable.  It does
> not need to be initialized in this scope because kstrtoint() will return
> an error if it fails without referring local variable after it.
> 
> It has been reported:
> 	http://lists.infradead.org/pipermail/linux-nvme/2019-April/023333.html
> 

Jens, 

Could you please have a look at this? I think it might fix
commit 3b6592f70("nvme: utilize two queue maps, one for reads and one for writes").

Thanks,

> Minwoo Im (2):
>   nvme: pci: Return -EINVAL if given nr_queue larger than nr_cpu
>   nvme: pci: Do not initialize local_var
> 
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
