From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 09:56:45 +0100
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
Message-ID: <20181121085645.GA29747@lst.de>

On Mon, Nov 19, 2018@07:00:16PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi at lightbitslabs.com>
> 
> This patch implements the NVMe over TCP host driver. It can be used to
> connect to remote NVMe over Fabrics subsystems over good old TCP/IP.
> 
> The driver implements the TP 8000 of how nvme over fabrics capsules and
> data are encapsulated in nvme-tcp pdus and exchaged on top of a TCP byte
> stream. nvme-tcp header and data digest are supported as well.
> 
> To connect to all NVMe over Fabrics controllers reachable on a given taget
> port over TCP use the following command:
> 
> 	nvme connect-all -t tcp -a $IPADDR
> 
> This requires the latest version of nvme-cli with TCP support.
> 
> Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
> Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
> Signed-off-by: Solganik Alexander <sashas at lightbitslabs.com>
> ---
>  drivers/nvme/host/Kconfig  |   15 +
>  drivers/nvme/host/Makefile |    3 +
>  drivers/nvme/host/tcp.c    | 2306 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2324 insertions(+)
>  create mode 100644 drivers/nvme/host/tcp.c
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 88a8b5916624..0f345e207675 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -57,3 +57,18 @@ config NVME_FC
>  	  from https://github.com/linux-nvme/nvme-cli.
>  
>  	  If unsure, say N.
> +
> +config NVME_TCP
> +	tristate "NVM Express over Fabrics TCP host driver"
> +	depends on INET
> +	depends on BLK_DEV_NVME
> +	select NVME_FABRICS
> +	help
> +	  This provides support for the NVMe over Fabrics protocol using
> +	  the TCP transport.  This allows you to use remote block devices
> +	  exported using the NVMe protocol set.
> +
> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
> +	  from https://github.com/linux-nvme/nvme-cli.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index aea459c65ae1..8a4b671c5f0c 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
>  obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
>  obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
>  obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
> +obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
>  
>  nvme-core-y				:= core.o
>  nvme-core-$(CONFIG_TRACING)		+= trace.o
> @@ -21,3 +22,5 @@ nvme-fabrics-y				+= fabrics.o
>  nvme-rdma-y				+= rdma.o
>  
>  nvme-fc-y				+= fc.o
> +
> +nvme-tcp-y				+= tcp.o
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> new file mode 100644
> index 000000000000..4c583859f0ad
> --- /dev/null
> +++ b/drivers/nvme/host/tcp.c
> @@ -0,0 +1,2306 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * NVMe over Fabrics TCP host.
> + * Copyright (c) 2018 LightBits Labs. All rights reserved.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/nvme-tcp.h>
> +#include <net/sock.h>
> +#include <net/tcp.h>
> +#include <linux/blk-mq.h>
> +#include <crypto/hash.h>
> +
> +#include "nvme.h"
> +#include "fabrics.h"
> +
> +struct nvme_tcp_queue;
> +
> +enum nvme_tcp_send_state {
> +	NVME_TCP_SEND_CMD_PDU = 0,
> +	NVME_TCP_SEND_H2C_PDU,
> +	NVME_TCP_SEND_DATA,
> +	NVME_TCP_SEND_DDGST,
> +};
> +
> +struct nvme_tcp_send_ctx {
> +	struct bio		*curr_bio;
> +	struct iov_iter		iter;
> +	size_t			offset;
> +	size_t			data_sent;
> +	enum nvme_tcp_send_state state;
> +};
> +
> +struct nvme_tcp_recv_ctx {
> +	struct iov_iter		iter;
> +	struct bio		*curr_bio;
> +};

I don't understand these structures.  There should only be
a bio to be send or receive, not both.  Why do we need two
curr_bio pointers?

To me it seems like both structures should just go away and
move into nvme_tcp_request ala:


	struct bio		*curr_bio;

	/* send state */
	struct iov_iter		send_iter;
	size_t			send_offset;
	enum nvme_tcp_send_state send_state;
	size_t			data_sent;

	/* receive state */
	struct iov_iter		recv_iter;
