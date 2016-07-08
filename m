From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 8 Jul 2016 08:49:54 -0500
Subject: [PATCH 3/5] nvme-rdma.h: Add includes for nvme rdma_cm negotiation
In-Reply-To: <1467809752-31320-4-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
 <1467809752-31320-4-git-send-email-hch@lst.de>
Message-ID: <003801d1d91f$9b664740$d232d5c0$@opengridcomputing.com>

> From: Sagi Grimberg <sagi at grimberg.me>
> 
> NVMe over Fabrics RDMA transport defines a connection establishment
> protocol over the RDMA connection manager. This header will be used by
> both the host and target drivers to negotiate the connection
> establishment parameters.
> 
> Signed-off-by: Jay Freyensee <james.p.freyensee at intel.com>
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  include/linux/nvme-rdma.h | 71
> +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 include/linux/nvme-rdma.h
> 
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> new file mode 100644
> index 0000000..bf240a3
> --- /dev/null
> +++ b/include/linux/nvme-rdma.h
> @@ -0,0 +1,71 @@
> +/*
> + * Copyright (c) 2015 Mellanox Technologies. All rights reserved.
> + *

Copyright should be 2016?

Otherwise looks good.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
