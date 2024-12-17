Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641FBE7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JuTF7Q3CMbcTt0P6KbYbOtTNJ1TRLgQ+etyHz6JEOM=; b=lAVwkEq9XSHjCF118Iz/1j66E7
	TAFGV/jF66+lQJ4D3BhMQvVLp+fAvaLQpMzxMGbr/+7glIdP1hiyhejjTLTVppujUet+rF6DZGiDf
	TpU1W3M0Txz9X5iH/0OpFeKajSnDHU+ZZ7wGE3itxiNqXlCFe1uWGQsh0ypDQftTIOmXiXtfgng4q
	1lQLooK6eR4ErU9jziqP3MYcPrfy9G7jACPSX6z7TQU/xvaA2L20MHafGzLgTiaD5ybAe9v4PFyii
	c+5I6v10BklyTEbAvyFs+AroB9Fqo1jWPLTIkVVSpjRRJkPZJ8AMzKGe9nT7kIjJCg5NqcSwWDizO
	aFgBhklw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTRw-0000000CoeE-3pdF;
	Tue, 17 Dec 2024 09:01:04 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTL7-0000000CmrD-473a
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 08:54:03 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-21683192bf9so47148315ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 00:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734425641; x=1735030441; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4JuTF7Q3CMbcTt0P6KbYbOtTNJ1TRLgQ+etyHz6JEOM=;
        b=L4CSJcTl8gRSE70OyzSPrVA0wSDU4y9dAw8FJ8d0ceAjF2frYq2BdTQWl6y2qd6tfM
         j7VFRyaK6FKvMRkV0fa++Gb4RESZHpQgaHMWh8TtaNIz2POiQVulQJqOUCYzCG2QG6uO
         rpUPq7fb2BGcv2P6iKOuBPEp73cs1T7lIlYafjkQNMRUIle+GZfwOKCvhH4beh6zL5dG
         ulxV4+lz6rZvxiL6hsCtYoO7WY9xz/4ED4WUCyrIiR/n5YMgfbtSQHnw8WyeG5cSUifq
         3IVPEa6PQ+oEd+4FIz6VOAnmABmqzLssh9Um+/ryX5ReLc2iUTU10lM18zKO8UJH63sL
         fIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425641; x=1735030441;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JuTF7Q3CMbcTt0P6KbYbOtTNJ1TRLgQ+etyHz6JEOM=;
        b=U1fHRSWH+mAykfLKHwekQMYfc/qtOJv8WwUAz4jiPgcWLqpdppsTwwvYD9bDQ00rpp
         Kfw1KRGQVZ1E7Lby+lw2uSFrSChYytNlX+U0Yy3TxkyEvuVxmtSzFEe4BUbJzQDM1la7
         /+AWcj2OMc7FDywklLfGCNu9hvC7S9YCN0lliMCRI5HYT1qpIRqmPKWyg4h+EIdM64Lc
         UOqV6CTxaJ07dB92WXNvsNPEtMvpVcEdz89XEK/BAmZPvVp9Tf7IatI6hjq81eNJXSKF
         n/KnWL7FCdWBRB7Mdcj1u5sHE5ugad1xN2m5bw3if3zuVZ982GzdrAkyGMCjrSVHvJ5R
         RvoQ==
X-Gm-Message-State: AOJu0YxGpiettEp9ocOBEOsUKjnWhtv5bdtXPGBbsc/9lmmg3m61FGI4
	kebILypRwVOyyPL4Pn4RQnDU16xZ9YClaemO/5D2GEkeILFclD9GNPIkUo0W1g==
X-Gm-Gg: ASbGncu3gsz8eit9Y2BxI1+3qKgkGnFSomK+MqOGD3qtxg6+dfsL3ZtWxHFVLEvKvph
	igUvg80mrEgoIz79/emSJ2WworU3TBix17cPlmc98lpmCTJB5/hsGjqEe8En783GhRfGQvimpTO
	4WJKlJQpyRHT7KvjpDT1XX8TSSQTqvc5LXNBVIimjY1Y42FWfHf6habT6AKcrm/AVrVs4wKrvmL
	9vQ3SLJlnm7iGOA8u3PBoZJDXWKQOiJmHsmcQOjcd296XUdmL9K/yiVNqfMOuldKw2P
X-Google-Smtp-Source: AGHT+IE6XSqQYNnxvqvVam+l2JSDyGps1nyQD9FYdCTtd8U5oin8HC88LreTy4IXSTDc/Z9Slx0ZMA==
X-Received: by 2002:a17:902:cece:b0:216:2dc4:50ab with SMTP id d9443c01a7336-21892989d93mr238909345ad.2.1734425641101;
        Tue, 17 Dec 2024 00:54:01 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a7bsm6039509a91.36.2024.12.17.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:54:00 -0800 (PST)
Date: Tue, 17 Dec 2024 14:23:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212113440.352958-18-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_005402_103532_1C2675EF 
X-CRM114-Status: GOOD (  54.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> Implement a PCI target driver using the PCI endpoint framework. This
> requires hardware with a PCI controller capable of executing in endpoint
> mode.
> 
> The PCI endpoint framework is used to set up a PCI endpoint device and
> its BAR compatible with a NVMe PCI controller. The framework is also
> used to map local memory to the PCI address space to execute MMIO
> accesses for retrieving NVMe commands from submission queues and posting
> completion entries to completion queues. If supported, DMA is used for
> command data transfers, based on the PCI address segments indicated by
> the command using either PRPs or SGLs.
> 
> The NVMe target driver relies on the NVMe target core code to execute
> all commands isssued by the host. The PCI target driver is mainly
> responsible for the following:
>  - Initialization and teardown of the endpoint device and its backend
>    PCI target controller. The PCI target controller is created using a
>    subsystem and a port defined through configfs. The port used must be
>    initialized with the "pci" transport type. The target controller is
>    allocated and initialized when the PCI endpoint is started by binding
>    it to the endpoint PCI device (nvmet_pciep_epf_epc_init() function).
> 
>  - Manage the endpoint controller state according to the PCI link state
>    and the actions of the host (e.g. checking the CC.EN register) and
>    propagate these actions to the PCI target controller. Polling of the
>    controller enable/disable is done using a delayed work scheduled
>    every 5ms (nvmet_pciep_poll_cc() function). This work is started
>    whenever the PCI link comes up (nvmet_pciep_epf_link_up() notifier
>    function) and stopped when the PCI link comes down
>    (nvmet_pciep_epf_link_down() notifier function).
>    nvmet_pciep_poll_cc() enables and disables the PCI controller using
>    the functions nvmet_pciep_enable_ctrl() and
>    nvmet_pciep_disable_ctrl(). The controller admin queue is created
>    using nvmet_pciep_create_cq(), which calls nvmet_cq_create(), and
>    nvmet_pciep_create_sq() which uses nvmet_sq_create().
>    nvmet_pciep_disable_ctrl() always resets the PCI controller to its
>    initial state so that nvmet_pciep_enable_ctrl() can be called again.
>    This ensure correct operation if, for instance, the host reboots
>    causing the PCI link to be temporarily down.
> 
>  - Manage the controller admin and I/O submission queues using local
>    memory. Commands are obtained from submission queues using a work
>    item that constantly polls the doorbells of all submissions queues
>    (nvmet_pciep_poll_sqs() function). This work is started whenever the
>    controller is enabled (nvmet_pciep_enable_ctrl() function) and
>    stopped when the controller is disabled (nvmet_pciep_disable_ctrl()
>    function). When new commands are submitted by the host, DMA transfers
>    are used to retrieve the commands.
> 
>  - Initiate the execution of all admin and I/O commands using the target
>    core code, by calling a requests execute() function. All commands are
>    individually handled using a per-command work item
>    (nvmet_pciep_iod_work() function). A command overall execution
>    includes: initializing a struct nvmet_req request for the command,
>    using nvmet_req_transfer_len() to get a command data transfer length,
>    parse the command PRPs or SGLs to get the PCI address segments of
>    the command data buffer, retrieve data from the host (if the command
>    is a write command), call req->execute() to execute the command and
>    transfer data to the host (for read commands).
> 
>  - Handle the completions of commands as notified by the
>    ->queue_response() operation of the PCI target controller
>    (nvmet_pciep_queue_response() function). Completed commands are added
>    to a list of completed command for their CQ. Each CQ list of
>    completed command is processed using a work item
>    (nvmet_pciep_cq_work() function) which posts entries for the
>    completed commands in the CQ memory and raise an IRQ to the host to
>    signal the completion. IRQ coalescing is supported as mandated by the
>    NVMe base specification for PCI controllers. Of note is that
>    completion entries are transmitted to the host using MMIO, after
>    mapping the completion queue memory to the host PCI address space.
>    Unlike for retrieving commands from SQs, DMA is not used as it
>    degrades performance due to the transfer serialization needed (which
>    delays completion entries transmission).
> 
> The configuration of a NVMe PCI endpoint controller is done using
> configfgs. First the NVMe PCI target controller configuration must be
> done to set up a subsystem and a port with the "pci" addr_trtype
> attribute. The subsystem can be setup using a file or block device
> backed namespace or using a passthrough NVMe device. After this, the
> PCI endpoint can be configured and bound to the PCI endpoint controller
> to start the NVMe endpoint controller.
> 
> In order to not overcomplicate this initial implementation of an
> endpoint PCI target controller driver, protection information is not
> for now supported. If the PCI controller port and namespace are
> configured with protection information support, an error will be
> returned when the controller is created and initialized when the
> endpoint function is started. Protection information support will be
> added in a follow-up patch series.
> 
> Using a Rock5B board (Rockchip RK3588 SoC, PCI Gen3x4 endpoint
> controller) with a target PCI controller setup with 4 I/O queues and a
> null_blk block device as a namespace, the maximum performance using fio
> was measured at 131 KIOPS for random 4K reads and up to 2.8 GB/S
> throughput. Some data points are:
> 
> Rnd read,   4KB,  QD=1, 1 job : IOPS=16.9k, BW=66.2MiB/s (69.4MB/s)
> Rnd read,   4KB, QD=32, 1 job : IOPS=78.5k, BW=307MiB/s (322MB/s)
> Rnd read,   4KB, QD=32, 4 jobs: IOPS=131k, BW=511MiB/s (536MB/s)
> Seq read, 512KB, QD=32, 1 job : IOPS=5381, BW=2691MiB/s (2821MB/s)
> 
> The NVMe PCI endpoint target driver is not intended for production use.
> It is a tool for learning NVMe, exploring existing features and testing
> implementations of new NVMe features.
> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/Kconfig  |   10 +
>  drivers/nvme/target/Makefile |    2 +
>  drivers/nvme/target/pci-ep.c | 2626 ++++++++++++++++++++++++++++++++++
>  3 files changed, 2638 insertions(+)
>  create mode 100644 drivers/nvme/target/pci-ep.c
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 46be031f91b4..6a0818282427 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -115,3 +115,13 @@ config NVME_TARGET_AUTH
>  	  target side.
>  
>  	  If unsure, say N.
> +
> +config NVME_TARGET_PCI_EP

Could you please use NVME_TARGET_PCI_EPF for consistency with other EPF drivers?

> +	tristate "NVMe PCI Endpoint Target support"
> +	depends on PCI_ENDPOINT && NVME_TARGET
> +	help
> +	  This enables the NVMe PCI endpoint target support which allows to
> +	  create an NVMe PCI controller using a PCI endpoint capable PCI
> +	  controller.

'This allows creating a NVMe PCI endpoint target using endpoint capable PCI
controller.'

> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index f2b025bbe10c..8110faa1101f 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
>  obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
>  obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
> +obj-$(CONFIG_NVME_TARGET_PCI_EP)	+= nvmet-pciep.o

Same as above: nvmet-pci-epf

>  
>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>  			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
> @@ -20,4 +21,5 @@ nvmet-rdma-y	+= rdma.o
>  nvmet-fc-y	+= fc.o
>  nvme-fcloop-y	+= fcloop.o
>  nvmet-tcp-y	+= tcp.o
> +nvmet-pciep-y	+= pci-ep.o
>  nvmet-$(CONFIG_TRACING)	+= trace.o
> diff --git a/drivers/nvme/target/pci-ep.c b/drivers/nvme/target/pci-ep.c
> new file mode 100644
> index 000000000000..d30d35248e64
> --- /dev/null
> +++ b/drivers/nvme/target/pci-ep.c
> @@ -0,0 +1,2626 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe PCI endpoint device.

'NVMe PCI Endpoint Function driver'

> + * Copyright (c) 2024, Western Digital Corporation or its affiliates.
> + * Copyright (c) 2024, Rick Wertenbroek <rick.wertenbroek@gmail.com>
> + *                     REDS Institute, HEIG-VD, HES-SO, Switzerland
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/io.h>
> +#include <linux/mempool.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvme.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci_regs.h>
> +#include <linux/slab.h>
> +
> +#include "nvmet.h"
> +
> +static LIST_HEAD(nvmet_pciep_ports);

Please name all variables/functions as 'pci_epf' instead of 'pciep'.

> +static DEFINE_MUTEX(nvmet_pciep_ports_mutex);

[...]

> +/*
> + * PCI EPF driver private data.
> + */
> +struct nvmet_pciep_epf {

nvmet_pci_epf?

> +	struct pci_epf			*epf;
> +
> +	const struct pci_epc_features	*epc_features;
> +
> +	void				*reg_bar;
> +	size_t				msix_table_offset;
> +
> +	unsigned int			irq_type;
> +	unsigned int			nr_vectors;
> +
> +	struct nvmet_pciep_ctrl		ctrl;
> +
> +	struct dma_chan			*dma_tx_chan;
> +	struct mutex			dma_tx_lock;
> +	struct dma_chan			*dma_rx_chan;
> +	struct mutex			dma_rx_lock;
> +
> +	struct mutex			mmio_lock;
> +
> +	/* PCI endpoint function configfs attributes */
> +	struct config_group		group;
> +	bool				dma_enable;
> +	__le16				portid;
> +	char				subsysnqn[NVMF_NQN_SIZE];
> +	unsigned int			mdts_kb;
> +};
> +
> +static inline u32 nvmet_pciep_bar_read32(struct nvmet_pciep_ctrl *ctrl, u32 off)
> +{
> +	__le32 *bar_reg = ctrl->bar + off;
> +
> +	return le32_to_cpu(READ_ONCE(*bar_reg));

Looks like you can use readl/writel variants here. Any reason to not use them?

> +}
> +

[...]

> +static bool nvmet_pciep_epf_init_dma(struct nvmet_pciep_epf *nvme_epf)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	struct device *dev = &epf->dev;
> +	struct nvmet_pciep_epf_dma_filter filter;
> +	struct dma_chan *chan;
> +	dma_cap_mask_t mask;
> +
> +	mutex_init(&nvme_epf->dma_rx_lock);
> +	mutex_init(&nvme_epf->dma_tx_lock);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	filter.dev = epf->epc->dev.parent;
> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> +
> +	chan = dma_request_channel(mask, nvmet_pciep_epf_dma_filter, &filter);
> +	if (!chan)
> +		return false;

You should also destroy mutexes in error path.

> +
> +	nvme_epf->dma_rx_chan = chan;
> +
> +	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
> +		dma_chan_name(chan),
> +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> +

You should print this message at the end of the function. Otherwise, if there is
a problem in acquiring TX, this and 'DMA not supported...' will be printed. 

> +	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> +	chan = dma_request_channel(mask, nvmet_pciep_epf_dma_filter, &filter);
> +	if (!chan) {
> +		dma_release_channel(nvme_epf->dma_rx_chan);
> +		nvme_epf->dma_rx_chan = NULL;
> +		return false;
> +	}
> +
> +	nvme_epf->dma_tx_chan = chan;
> +
> +	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
> +		dma_chan_name(chan),
> +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> +
> +	return true;
> +}
> +
> +static void nvmet_pciep_epf_deinit_dma(struct nvmet_pciep_epf *nvme_epf)
> +{
> +	if (nvme_epf->dma_tx_chan) {

If you destroy mutexes in error path as I suggested above, you could just bail
out if !nvme_epf->dma_enable.

> +		dma_release_channel(nvme_epf->dma_tx_chan);
> +		nvme_epf->dma_tx_chan = NULL;
> +	}
> +
> +	if (nvme_epf->dma_rx_chan) {
> +		dma_release_channel(nvme_epf->dma_rx_chan);
> +		nvme_epf->dma_rx_chan = NULL;
> +	}
> +
> +	mutex_destroy(&nvme_epf->dma_rx_lock);
> +	mutex_destroy(&nvme_epf->dma_tx_lock);
> +}
> +
> +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config sconf = {};
> +	struct device *dev = &epf->dev;
> +	struct device *dma_dev;
> +	struct dma_chan *chan;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_addr;
> +	struct mutex *lock;
> +	int ret;
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		lock = &nvme_epf->dma_rx_lock;
> +		chan = nvme_epf->dma_rx_chan;
> +		sconf.direction = DMA_DEV_TO_MEM;
> +		sconf.src_addr = seg->pci_addr;
> +		break;
> +	case DMA_TO_DEVICE:
> +		lock = &nvme_epf->dma_tx_lock;
> +		chan = nvme_epf->dma_tx_chan;
> +		sconf.direction = DMA_MEM_TO_DEV;
> +		sconf.dst_addr = seg->pci_addr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(lock);
> +
> +	dma_dev = dmaengine_get_dma_device(chan);
> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> +	ret = dma_mapping_error(dma_dev, dma_addr);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = dmaengine_slave_config(chan, &sconf);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto unmap;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> +					   sconf.direction, DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto unmap;
> +	}
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "DMA submit failed %d\n", ret);
> +		goto unmap;
> +	}
> +
> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {

Why do you need to do sync tranfer all the time? This defeats the purpose of
using DMA.

> +		dev_err(dev, "DMA transfer failed\n");
> +		ret = -EIO;
> +	}
> +
> +	dmaengine_terminate_sync(chan);
> +
> +unmap:
> +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> +
> +unlock:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
> +static int nvmet_pciep_epf_mmio_transfer(struct nvmet_pciep_epf *nvme_epf,
> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> +{
> +	u64 pci_addr = seg->pci_addr;
> +	u32 length = seg->length;
> +	void *buf = seg->buf;
> +	struct pci_epc_map map;
> +	int ret = -EINVAL;
> +
> +	/*
> +	 * Note: mmio transfers do not need serialization but this is a

MMIO

> +	 * simple way to avoid using too many mapping windows.
> +	 */
> +	mutex_lock(&nvme_epf->mmio_lock);
> +
> +	while (length) {
> +		ret = nvmet_pciep_epf_mem_map(nvme_epf, pci_addr, length, &map);
> +		if (ret)
> +			break;
> +
> +		switch (dir) {
> +		case DMA_FROM_DEVICE:
> +			memcpy_fromio(buf, map.virt_addr, map.pci_size);
> +			break;
> +		case DMA_TO_DEVICE:
> +			memcpy_toio(map.virt_addr, buf, map.pci_size);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		pci_addr += map.pci_size;
> +		buf += map.pci_size;
> +		length -= map.pci_size;
> +
> +		nvmet_pciep_epf_mem_unmap(nvme_epf, &map);
> +	}
> +
> +unlock:
> +	mutex_unlock(&nvme_epf->mmio_lock);
> +
> +	return ret;
> +}
> +
> +static inline int nvmet_pciep_epf_transfer(struct nvmet_pciep_epf *nvme_epf,

No need to add 'inline' keyword in .c files.

> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> +{
> +	if (nvme_epf->dma_enable)
> +		return nvmet_pciep_epf_dma_transfer(nvme_epf, seg, dir);
> +
> +	return nvmet_pciep_epf_mmio_transfer(nvme_epf, seg, dir);
> +}
> +

[...]

> +/*
> + * Transfer a prp list from the host and return the number of prps.

PRP (everywhere in comments)

> + */
> +static int nvmet_pciep_get_prp_list(struct nvmet_pciep_ctrl *ctrl, u64 prp,
> +				    size_t xfer_len, __le64 *prps)
> +{
> +	size_t nr_prps = (xfer_len + ctrl->mps_mask) >> ctrl->mps_shift;
> +	u32 length;
> +	int ret;
> +
> +	/*
> +	 * Compute the number of PRPs required for the number of bytes to
> +	 * transfer (xfer_len). If this number overflows the memory page size
> +	 * with the PRP list pointer specified, only return the space available
> +	 * in the memory page, the last PRP in there will be a PRP list pointer
> +	 * to the remaining PRPs.
> +	 */
> +	length = min(nvmet_pciep_prp_size(ctrl, prp), nr_prps << 3);
> +	ret = nvmet_pciep_transfer(ctrl, prps, prp, length, DMA_FROM_DEVICE);
> +	if (ret)
> +		return ret;
> +
> +	return length >> 3;
> +}
> +
> +static int nvmet_pciep_iod_parse_prp_list(struct nvmet_pciep_ctrl *ctrl,
> +					  struct nvmet_pciep_iod *iod)
> +{
> +	struct nvme_command *cmd = &iod->cmd;
> +	struct nvmet_pciep_segment *seg;
> +	size_t size = 0, ofst, prp_size, xfer_len;
> +	size_t transfer_len = iod->data_len;
> +	int nr_segs, nr_prps = 0;
> +	u64 pci_addr, prp;
> +	int i = 0, ret;
> +	__le64 *prps;
> +
> +	prps = kzalloc(ctrl->mps, GFP_KERNEL);
> +	if (!prps)
> +		goto internal;

Can you prefix 'err_' to the label?

> +
> +	/*
> +	 * Allocate PCI segments for the command: this considers the worst case
> +	 * scenario where all prps are discontiguous, so get as many segments
> +	 * as we can have prps. In practice, most of the time, we will have
> +	 * far less PCI segments than prps.
> +	 */
> +	prp = le64_to_cpu(cmd->common.dptr.prp1);
> +	if (!prp)
> +		goto invalid_field;
> +
> +	ofst = nvmet_pciep_prp_ofst(ctrl, prp);
> +	nr_segs = (transfer_len + ofst + ctrl->mps - 1) >> ctrl->mps_shift;
> +
> +	ret = nvmet_pciep_alloc_iod_data_segs(iod, nr_segs);
> +	if (ret)
> +		goto internal;
> +
> +	/* Set the first segment using prp1 */
> +	seg = &iod->data_segs[0];
> +	seg->pci_addr = prp;
> +	seg->length = nvmet_pciep_prp_size(ctrl, prp);
> +
> +	size = seg->length;
> +	pci_addr = prp + size;
> +	nr_segs = 1;
> +
> +	/*
> +	 * Now build the PCI address segments using the prp lists, starting
> +	 * from prp2.
> +	 */
> +	prp = le64_to_cpu(cmd->common.dptr.prp2);
> +	if (!prp)
> +		goto invalid_field;
> +
> +	while (size < transfer_len) {
> +		xfer_len = transfer_len - size;
> +
> +		if (!nr_prps) {
> +			/* Get the prp list */
> +			nr_prps = nvmet_pciep_get_prp_list(ctrl, prp,
> +							   xfer_len, prps);
> +			if (nr_prps < 0)
> +				goto internal;
> +
> +			i = 0;
> +			ofst = 0;
> +		}
> +
> +		/* Current entry */
> +		prp = le64_to_cpu(prps[i]);
> +		if (!prp)
> +			goto invalid_field;
> +
> +		/* Did we reach the last prp entry of the list ? */
> +		if (xfer_len > ctrl->mps && i == nr_prps - 1) {
> +			/* We need more PRPs: prp is a list pointer */
> +			nr_prps = 0;
> +			continue;
> +		}
> +
> +		/* Only the first prp is allowed to have an offset */
> +		if (nvmet_pciep_prp_ofst(ctrl, prp))
> +			goto invalid_offset;
> +
> +		if (prp != pci_addr) {
> +			/* Discontiguous prp: new segment */
> +			nr_segs++;
> +			if (WARN_ON_ONCE(nr_segs > iod->nr_data_segs))
> +				goto internal;
> +
> +			seg++;
> +			seg->pci_addr = prp;
> +			seg->length = 0;
> +			pci_addr = prp;
> +		}
> +
> +		prp_size = min_t(size_t, ctrl->mps, xfer_len);
> +		seg->length += prp_size;
> +		pci_addr += prp_size;
> +		size += prp_size;
> +
> +		i++;
> +	}
> +
> +	iod->nr_data_segs = nr_segs;
> +	ret = 0;
> +
> +	if (size != transfer_len) {
> +		dev_err(ctrl->dev, "PRPs transfer length mismatch %zu / %zu\n",
> +			size, transfer_len);
> +		goto internal;
> +	}
> +
> +	kfree(prps);
> +
> +	return 0;
> +
> +invalid_offset:
> +	dev_err(ctrl->dev, "PRPs list invalid offset\n");
> +	kfree(prps);
> +	iod->status = NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
> +	return -EINVAL;
> +
> +invalid_field:
> +	dev_err(ctrl->dev, "PRPs list invalid field\n");
> +	kfree(prps);
> +	iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +	return -EINVAL;
> +
> +internal:
> +	dev_err(ctrl->dev, "PRPs list internal error\n");
> +	kfree(prps);
> +	iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
> +	return -EINVAL;

Can't you organize the labels in such a way that there is only one return path?
Current code makes it difficult to read and also would confuse the static
checkers.

> +}
> +

[...]

> +static void nvmet_pciep_init_bar(struct nvmet_pciep_ctrl *ctrl)
> +{
> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
> +
> +	ctrl->bar = ctrl->nvme_epf->reg_bar;
> +
> +	/* Copy the target controller capabilities as a base */
> +	ctrl->cap = tctrl->cap;
> +
> +	/* Contiguous Queues Required (CQR) */
> +	ctrl->cap |= 0x1ULL << 16;
> +
> +	/* Set Doorbell stride to 4B (DSTRB) */
> +	ctrl->cap &= ~GENMASK(35, 32);
> +
> +	/* Clear NVM Subsystem Reset Supported (NSSRS) */
> +	ctrl->cap &= ~(0x1ULL << 36);
> +
> +	/* Clear Boot Partition Support (BPS) */
> +	ctrl->cap &= ~(0x1ULL << 45);
> +
> +	/* Clear Persistent Memory Region Supported (PMRS) */
> +	ctrl->cap &= ~(0x1ULL << 56);
> +
> +	/* Clear Controller Memory Buffer Supported (CMBS) */
> +	ctrl->cap &= ~(0x1ULL << 57);

Can you use macros for these?

> +
> +	/* Controller configuration */
> +	ctrl->cc = tctrl->cc & (~NVME_CC_ENABLE);
> +
> +	/* Controller status */
> +	ctrl->csts = ctrl->tctrl->csts;
> +
> +	nvmet_pciep_bar_write64(ctrl, NVME_REG_CAP, ctrl->cap);
> +	nvmet_pciep_bar_write32(ctrl, NVME_REG_VS, tctrl->subsys->ver);
> +	nvmet_pciep_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
> +	nvmet_pciep_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
> +}
> +

[...]

> +static int nvmet_pciep_epf_configure_bar(struct nvmet_pciep_epf *nvme_epf)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	const struct pci_epc_features *epc_features = nvme_epf->epc_features;
> +	size_t reg_size, reg_bar_size;
> +	size_t msix_table_size = 0;
> +
> +	/*
> +	 * The first free BAR will be our register BAR and per NVMe
> +	 * specifications, it must be BAR 0.
> +	 */
> +	if (pci_epc_get_first_free_bar(epc_features) != BAR_0) {
> +		dev_err(&epf->dev, "BAR 0 is not free\n");
> +		return -EINVAL;

-ENOMEM or -ENODEV?

> +	}
> +
> +	/* Initialize BAR flags */
> +	if (epc_features->bar[BAR_0].only_64bit)
> +		epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +
> +	/*
> +	 * Calculate the size of the register bar: NVMe registers first with
> +	 * enough space for the doorbells, followed by the MSI-X table
> +	 * if supported.
> +	 */
> +	reg_size = NVME_REG_DBS + (NVMET_NR_QUEUES * 2 * sizeof(u32));
> +	reg_size = ALIGN(reg_size, 8);
> +
> +	if (epc_features->msix_capable) {
> +		size_t pba_size;
> +
> +		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
> +		nvme_epf->msix_table_offset = reg_size;
> +		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
> +
> +		reg_size += msix_table_size + pba_size;
> +	}
> +
> +	reg_bar_size = ALIGN(reg_size, max(epc_features->align, 4096));

From where does this 4k alignment comes from? NVMe spec? If so, is it OK to use
fixed_size BAR?

> +
> +	if (epc_features->bar[BAR_0].type == BAR_FIXED) {
> +		if (reg_bar_size > epc_features->bar[BAR_0].fixed_size) {
> +			dev_err(&epf->dev,
> +				"Reg BAR 0 size %llu B too small, need %zu B\n",
> +				epc_features->bar[BAR_0].fixed_size,
> +				reg_bar_size);
> +			return -ENOMEM;
> +		}
> +		reg_bar_size = epc_features->bar[BAR_0].fixed_size;
> +	}
> +
> +	nvme_epf->reg_bar = pci_epf_alloc_space(epf, reg_bar_size, BAR_0,
> +						epc_features, PRIMARY_INTERFACE);
> +	if (!nvme_epf->reg_bar) {
> +		dev_err(&epf->dev, "Allocate BAR 0 failed\n");

'Failed to allocate memory for BAR 0'

> +		return -ENOMEM;
> +	}
> +	memset(nvme_epf->reg_bar, 0, reg_bar_size);
> +
> +	return 0;
> +}
> +
> +static void nvmet_pciep_epf_clear_bar(struct nvmet_pciep_epf *nvme_epf)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +
> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> +			  &epf->bar[BAR_0]);
> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> +	nvme_epf->reg_bar = NULL;
> +}
> +
> +static int nvmet_pciep_epf_init_irq(struct nvmet_pciep_epf *nvme_epf)
> +{
> +	const struct pci_epc_features *epc_features = nvme_epf->epc_features;
> +	struct pci_epf *epf = nvme_epf->epf;
> +	int ret;
> +
> +	/* Enable MSI-X if supported, otherwise, use MSI */
> +	if (epc_features->msix_capable && epf->msix_interrupts) {
> +		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
> +				       epf->msix_interrupts, BAR_0,
> +				       nvme_epf->msix_table_offset);
> +		if (ret) {
> +			dev_err(&epf->dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +
> +		nvme_epf->nr_vectors = epf->msix_interrupts;
> +		nvme_epf->irq_type = PCI_IRQ_MSIX;
> +
> +		return 0;
> +	}
> +
> +	if (epc_features->msi_capable && epf->msi_interrupts) {
> +		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no,
> +				      epf->msi_interrupts);
> +		if (ret) {
> +			dev_err(&epf->dev, "MSI configuration failed\n");
> +			return ret;
> +		}
> +
> +		nvme_epf->nr_vectors = epf->msi_interrupts;
> +		nvme_epf->irq_type = PCI_IRQ_MSI;
> +
> +		return 0;
> +	}
> +
> +	/* MSI and MSI-X are not supported: fall back to INTX */
> +	nvme_epf->nr_vectors = 1;
> +	nvme_epf->irq_type = PCI_IRQ_INTX;
> +
> +	return 0;
> +}
> +
> +static int nvmet_pciep_epf_epc_init(struct pci_epf *epf)
> +{
> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> +	const struct pci_epc_features *epc_features = nvme_epf->epc_features;
> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> +	unsigned int max_nr_queues = NVMET_NR_QUEUES;
> +	int ret;
> +
> +	/*
> +	 * Cap the maximum number of queues we can support on the controller
> +	 * with the number of IRQs we can use.
> +	 */
> +	if (epc_features->msix_capable && epf->msix_interrupts) {
> +		dev_info(&epf->dev,
> +			 "PCI endpoint controller supports MSI-X, %u vectors\n",
> +			 epf->msix_interrupts);
> +		max_nr_queues = min(max_nr_queues, epf->msix_interrupts);
> +	} else if (epc_features->msi_capable && epf->msi_interrupts) {
> +		dev_info(&epf->dev,
> +			 "PCI endpoint controller supports MSI, %u vectors\n",
> +			 epf->msi_interrupts);
> +		max_nr_queues = min(max_nr_queues, epf->msi_interrupts);
> +	}
> +
> +	if (max_nr_queues < 2) {
> +		dev_err(&epf->dev, "Invalid maximum number of queues %u\n",
> +			max_nr_queues);
> +		return -EINVAL;
> +	}
> +
> +	/* Create the target controller. */
> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
> +	if (ret) {
> +		dev_err(&epf->dev,
> +			"Create NVMe PCI target controller failed\n");

Failed to create NVMe PCI target controller

> +		return ret;
> +	}
> +
> +	if (epf->vfunc_no <= 1) {

Are you really supporting virtual functions? If supported, 'vfunc_no < 1' is not
possible.

> +		/* Set device ID, class, etc */
> +		epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
> +		epf->header->subsys_vendor_id =
> +			ctrl->tctrl->subsys->subsys_vendor_id;

Why these are coming from somewhere else and not configured within the EPF
driver?

> +		ret = pci_epc_write_header(epf->epc, epf->func_no, epf->vfunc_no,
> +					   epf->header);
> +		if (ret) {
> +			dev_err(&epf->dev,
> +				"Write configuration header failed %d\n", ret);
> +			goto out_destroy_ctrl;
> +		}
> +	}
> +
> +	/* Setup the PCIe BAR and create the controller */
> +	ret = pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no,
> +			      &epf->bar[BAR_0]);
> +	if (ret) {
> +		dev_err(&epf->dev, "Set BAR 0 failed\n");
> +		goto out_destroy_ctrl;
> +	}
> +
> +	/*
> +	 * Enable interrupts and start polling the controller BAR if we do not
> +	 * have any link up notifier.
> +	 */
> +	ret = nvmet_pciep_epf_init_irq(nvme_epf);
> +	if (ret)
> +		goto out_clear_bar;
> +
> +	if (!epc_features->linkup_notifier) {
> +		ctrl->link_up = true;
> +		nvmet_pciep_start_ctrl(&nvme_epf->ctrl);
> +	}
> +
> +	return 0;
> +
> +out_clear_bar:
> +	nvmet_pciep_epf_clear_bar(nvme_epf);
> +out_destroy_ctrl:
> +	nvmet_pciep_destroy_ctrl(&nvme_epf->ctrl);
> +	return ret;
> +}
> +
> +static void nvmet_pciep_epf_epc_deinit(struct pci_epf *epf)
> +{
> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> +
> +	ctrl->link_up = false;
> +	nvmet_pciep_destroy_ctrl(ctrl);
> +
> +	nvmet_pciep_epf_deinit_dma(nvme_epf);
> +	nvmet_pciep_epf_clear_bar(nvme_epf);
> +
> +	mutex_destroy(&nvme_epf->mmio_lock);
> +}
> +
> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
> +{
> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> +
> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");

These prints are supposed to come from the controller drivers. So no need to
have them here also.

> +
> +	ctrl->link_up = true;
> +	nvmet_pciep_start_ctrl(ctrl);
> +
> +	return 0;
> +}
> +

[...]

> +static ssize_t nvmet_pciep_epf_dma_enable_show(struct config_item *item,
> +					    char *page)
> +{
> +	struct config_group *group = to_config_group(item);
> +	struct nvmet_pciep_epf *nvme_epf = to_nvme_epf(group);
> +
> +	return sysfs_emit(page, "%d\n", nvme_epf->dma_enable);
> +}
> +
> +static ssize_t nvmet_pciep_epf_dma_enable_store(struct config_item *item,
> +					     const char *page, size_t len)
> +{
> +	struct config_group *group = to_config_group(item);
> +	struct nvmet_pciep_epf *nvme_epf = to_nvme_epf(group);
> +	int ret;
> +
> +	if (nvme_epf->ctrl.tctrl)
> +		return -EBUSY;
> +
> +	ret = kstrtobool(page, &nvme_epf->dma_enable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR(nvmet_pciep_epf_, dma_enable);

What is the use of making this option user configurable? It is purely a hardware
capability and I don't think users would want to have their NVMe device working
without DMA voluntarily.

> +
> +static ssize_t nvmet_pciep_epf_portid_show(struct config_item *item, char *page)
> +{
> +	struct config_group *group = to_config_group(item);
> +	struct nvmet_pciep_epf *nvme_epf = to_nvme_epf(group);
> +
> +	return sysfs_emit(page, "%u\n", le16_to_cpu(nvme_epf->portid));
> +}
> +

[...]

> +static int __init nvmet_pciep_init_module(void)
> +{
> +	int ret;
> +
> +	ret = pci_epf_register_driver(&nvmet_pciep_epf_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = nvmet_register_transport(&nvmet_pciep_fabrics_ops);

What is the need to register the transport so early? You should consider moving
the registration to bind() so that the transport can be removed once the driver
is unbind with the controller.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

