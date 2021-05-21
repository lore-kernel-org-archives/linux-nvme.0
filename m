Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EBC47081
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:14:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6EF613F4
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6EF613F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxtH4YRLb1e8WNRlb/vrxC02dxEfDyOtvGnUXErR1fU=; b=bAdJ4a92QjfIBa2PxLu0DpCsQB
	/rGomTZruqeKX4IWp661bYs9n9YMw7QaQ59eQDbft69OoIIRygHDLWDKYppoL5pruo3Bvs9nc8MHI
	gj64NChOkXBrvh6BavQPQ9I3KHi73/L6gG2i5DMk1kpyZKWSuCf4b9mmD3pwyhZX9x3oyvAFy2LiP
	bG0E+I9iuaSiQTNt16wsxqpnIams++OJkZoKU9QrK2PI3Sp601Uu5dkdj9D8Qs/hYrV6ajsKYH75h
	O42x3qQ7hIl0JORzqhUHV8oDdFIBCDN2elAJkt7Fo46ajL817V45OedCstB/sALNB9kTYOU8ejwI3
	1ST1a+2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDOy-001CrR-AC; Fri, 21 May 2021 22:13:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDOt-001Cqz-Al
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:13:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=IxSQjVE6BoF+TFgs0otfqF6Tm/CUmp7dqmW/leZzgAU=; b=S2SZDz2NS5ri3Sah4NlH7wswys
 2PBgdi8JnpSIn/J1Kp32VFULOzV+7aOLqBm5xzRJ1OXCZKoWVfT8XXoCp1gMjjho/g5u4/p9+U7au
 2AMPyGl+QsrgxGlhiK93LKWdiG4JWfJlHWDcAEAa2reYF5MNH2XqwJVlRzr7JZgF4WB7YTRnIfRP5
 dDKCAz2lqdANHMilFtL+4wF9DqJxeRGgJ85mJAKHIs4yOzKRqG/oxKW31oeR9gQ9Wfy1Rh9tu8ymV
 jYZKjHuKbKQAaYOcf5bwFgs1eNJFSa8oHwDamZVOfOLjiYHzTGKeQme+d7PVy3udnvcRN/q2M+qec
 HYCs6aCA==;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDOn-00HSOE-NM
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:13:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id r12so22391556wrp.1
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IxSQjVE6BoF+TFgs0otfqF6Tm/CUmp7dqmW/leZzgAU=;
 b=U+LbgmoF7/4CSQqpVLuFAmIe9lgNvTdqqBkrI03H3GV5AzblEKhT01j7a7rUicdJO8
 Cfwlm4s/vkgD0M3QHDlulryw0MVfIrquZGth5MuXsNTzq/eY8k+tUoIEEM98hEHLAcDC
 L2E7WLjJatIc7RqdL7LMmMVQfsEzcbnMtu8CBrRM6xASb/hojxDxjkPBpjDkiCHIzIm5
 jtoSSLkD7E1ON2zit2v2g1kKGbBnW77DUjKN/ud3ZUbqg2PPDVuxk9/yvUOiYC4RemNb
 tiMKBeMav4Y9YmJMskeurKnVEEZuge8LqVKgAiR2au/vlDCR1HzpOyShoDmRQhCXeaSL
 u7sw==
X-Gm-Message-State: AOAM533LQZ3wxBp6okziCYJwnD1lucv0tmI5eUfrr2SG6ZZ//+83CkiE
 JZZvLXxF1USn/GqzyLRUuHQ=
X-Google-Smtp-Source: ABdhPJyFgLfqmIooqcegw3qxzGy1rNNrHYr2cLJLfCGL3sfXaaeXqrq5S4UzOxM/N2/b5tD3nb6Ehw==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr11878204wro.40.1621635219939; 
 Fri, 21 May 2021 15:13:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id 188sm842167wma.7.2021.05.21.15.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:13:39 -0700 (PDT)
Subject: Re: [RFC PATCH v5 01/27] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-2-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1df61e8a-c579-e945-ec13-9155b86bbbf4@grimberg.me>
Date: Fri, 21 May 2021 15:13:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-2-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_151341_844846_C7CF8053 
X-CRM114-Status: GOOD (  53.17  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/19/21 4:13 AM, Shai Malin wrote:
> This patch will present the structure for the NVMeTCP offload common
> layer driver. This module is added under "drivers/nvme/host/" and future
> offload drivers which will register to it will be placed under
> "drivers/nvme/hw".
> This new driver will be enabled by the Kconfig "NVM Express over Fabrics
> TCP offload commmon layer".
> In order to support the new transport type, for host mode, no change is
> needed.
> 
> Each new vendor-specific offload driver will register to this ULP during
> its probe function, by filling out the nvme_tcp_ofld_dev->ops and
> nvme_tcp_ofld_dev->private_data and calling nvme_tcp_ofld_register_dev
> with the initialized struct.
> 
> The internal implementation:
> - tcp-offload.h:
>    Includes all common structs and ops to be used and shared by offload
>    drivers.
> 
> - tcp-offload.c:
>    Includes the init function which registers as a NVMf transport just
>    like any other transport.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   MAINTAINERS                     |   8 ++
>   drivers/nvme/host/Kconfig       |  16 +++
>   drivers/nvme/host/Makefile      |   3 +
>   drivers/nvme/host/tcp-offload.c | 126 +++++++++++++++++++
>   drivers/nvme/host/tcp-offload.h | 212 ++++++++++++++++++++++++++++++++
>   5 files changed, 365 insertions(+)
>   create mode 100644 drivers/nvme/host/tcp-offload.c
>   create mode 100644 drivers/nvme/host/tcp-offload.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..49a4a73ea1c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13092,6 +13092,14 @@ F:	drivers/nvme/host/
>   F:	include/linux/nvme.h
>   F:	include/uapi/linux/nvme_ioctl.h
>   
> +NVM EXPRESS TCP OFFLOAD TRANSPORT DRIVERS
> +M:	Shai Malin <smalin@marvell.com>
> +M:	Ariel Elior <aelior@marvell.com>
> +L:	linux-nvme@lists.infradead.org
> +S:	Supported
> +F:	drivers/nvme/host/tcp-offload.c
> +F:	drivers/nvme/host/tcp-offload.h
> +
>   NVM EXPRESS FC TRANSPORT DRIVERS
>   M:	James Smart <james.smart@broadcom.com>
>   L:	linux-nvme@lists.infradead.org
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index a44d49d63968..6e869e94e67f 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -84,3 +84,19 @@ config NVME_TCP
>   	  from https://github.com/linux-nvme/nvme-cli.
>   
>   	  If unsure, say N.
> +
> +config NVME_TCP_OFFLOAD
> +	tristate "NVM Express over Fabrics TCP offload common layer"
> +	default m
> +	depends on INET
> +	depends on BLK_DEV_NVME

This needs to be: select NVME_CORE

In fact, I've sent a patch that fixes that for nvme-tcp..

> +	select NVME_FABRICS
> +	help
> +	  This provides support for the NVMe over Fabrics protocol using
> +	  the TCP offload transport. This allows you to use remote block devices
> +	  exported using the NVMe protocol set.
> +
> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
> +	  from https://github.com/linux-nvme/nvme-cli.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index cbc509784b2e..3c3fdf83ce38 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
>   obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
>   obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
>   obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
> +obj-$(CONFIG_NVME_TCP_OFFLOAD)	+= nvme-tcp-offload.o
>   
>   nvme-core-y				:= core.o ioctl.o
>   nvme-core-$(CONFIG_TRACING)		+= trace.o
> @@ -26,3 +27,5 @@ nvme-rdma-y				+= rdma.o
>   nvme-fc-y				+= fc.o
>   
>   nvme-tcp-y				+= tcp.o
> +
> +nvme-tcp-offload-y		+= tcp-offload.o
> diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
> new file mode 100644
> index 000000000000..711232eba339
> --- /dev/null
> +++ b/drivers/nvme/host/tcp-offload.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Marvell. All rights reserved.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +/* Kernel includes */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +/* Driver includes */
> +#include "tcp-offload.h"
> +
> +static LIST_HEAD(nvme_tcp_ofld_devices);
> +static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);

Why is that a rwsem?

> +
> +/**
> + * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
> + * function.
> + * @dev:	NVMeTCP offload device instance to be registered to the
> + *		common tcp offload instance.
> + *
> + * API function that registers the type of vendor specific driver
> + * being implemented to the common NVMe over TCP offload library. Part of
> + * the overall init sequence of starting up an offload driver.
> + */
> +int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev)
> +{
> +	struct nvme_tcp_ofld_ops *ops = dev->ops;
> +
> +	if (!ops->claim_dev ||
> +	    !ops->setup_ctrl ||
> +	    !ops->release_ctrl ||
> +	    !ops->create_queue ||
> +	    !ops->drain_queue ||
> +	    !ops->destroy_queue ||
> +	    !ops->poll_queue ||
> +	    !ops->init_req ||
> +	    !ops->send_req ||
> +	    !ops->commit_rqs)
> +		return -EINVAL;
> +
> +	down_write(&nvme_tcp_ofld_devices_rwsem);
> +	list_add_tail(&dev->entry, &nvme_tcp_ofld_devices);
> +	up_write(&nvme_tcp_ofld_devices_rwsem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_tcp_ofld_register_dev);
> +
> +/**
> + * nvme_tcp_ofld_unregister_dev() - NVMeTCP Offload Library unregistration
> + * function.
> + * @dev:	NVMeTCP offload device instance to be unregistered from the
> + *		common tcp offload instance.
> + *
> + * API function that unregisters the type of vendor specific driver being
> + * implemented from the common NVMe over TCP offload library.
> + * Part of the overall exit sequence of unloading the implemented driver.
> + */
> +void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev)
> +{
> +	down_write(&nvme_tcp_ofld_devices_rwsem);
> +	list_del(&dev->entry);
> +	up_write(&nvme_tcp_ofld_devices_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
> +
> +/**
> + * nvme_tcp_ofld_report_queue_err() - NVMeTCP Offload report error event
> + * callback function. Pointed to by nvme_tcp_ofld_queue->report_err.
> + * @queue:	NVMeTCP offload queue instance on which the error has occurred.
> + *
> + * API function that allows the vendor specific offload driver to reports errors
> + * to the common offload layer, to invoke error recovery.
> + */
> +int nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
> +{

No semantics into what was the error?

> +	/* Placeholder - invoke error recovery flow */
> +
> +	return 0;
> +}
> +
> +/**
> + * nvme_tcp_ofld_req_done() - NVMeTCP Offload request done callback
> + * function. Pointed to by nvme_tcp_ofld_req->done.
> + * Handles both NVME_TCP_F_DATA_SUCCESS flag and NVMe CQ.
> + * @req:	NVMeTCP offload request to complete.
> + * @result:     The nvme_result.
> + * @status:     The completion status.
> + *
> + * API function that allows the vendor specific offload driver to report request
> + * completions to the common offload layer.
> + */
> +void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
> +			    union nvme_result *result,
> +			    __le16 status)
> +{

Why do you need to pass back the result? Isn't that a part
of the request?

> +	/* Placeholder - complete request with/without error */
> +}
> +
> +static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
> +	.name		= "tcp_offload",
> +	.module		= THIS_MODULE,
> +	.required_opts	= NVMF_OPT_TRADDR,
> +	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_NR_WRITE_QUEUES  |
> +			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
> +			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
> +			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
> +			  NVMF_OPT_TOS,
> +};
> +
> +static int __init nvme_tcp_ofld_init_module(void)
> +{
> +	nvmf_register_transport(&nvme_tcp_ofld_transport);
> +
> +	return 0;
> +}
> +
> +static void __exit nvme_tcp_ofld_cleanup_module(void)
> +{
> +	nvmf_unregister_transport(&nvme_tcp_ofld_transport);
> +}
> +
> +module_init(nvme_tcp_ofld_init_module);
> +module_exit(nvme_tcp_ofld_cleanup_module);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
> new file mode 100644
> index 000000000000..949132ce2ed4
> --- /dev/null
> +++ b/drivers/nvme/host/tcp-offload.h
> @@ -0,0 +1,212 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2021 Marvell. All rights reserved.
> + */
> +
> +/* Linux includes */
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/types.h>
> +#include <linux/nvme-tcp.h>
> +
> +/* Driver includes */
> +#include "nvme.h"
> +#include "fabrics.h"
> +
> +/* Forward declarations */
> +struct nvme_tcp_ofld_ops;
> +
> +/* Representation of a vendor-specific device. This is the struct used to
> + * register to the offload layer by the vendor-specific driver during its probe
> + * function.
> + * Allocated by vendor-specific driver.
> + */
> +struct nvme_tcp_ofld_dev {
> +	struct list_head entry;
> +	struct net_device *ndev;
> +	struct nvme_tcp_ofld_ops *ops;
> +
> +	/* Vendor specific driver context */
> +	void *private_data;

Usually there is private_data pointer when the upper layer
passes a struct to the lower layer to initialize, that is
not the case here, why don't the device driver just use
container_of to access its internal representation?

> +	int num_hw_vectors;
> +};
> +
> +/* Per IO struct holding the nvme_request and command
> + * Allocated by blk-mq.
> + */
> +struct nvme_tcp_ofld_req {
> +	struct nvme_request req;
> +	struct nvme_command nvme_cmd;
> +	struct list_head queue_entry;
> +	struct nvme_tcp_ofld_queue *queue;
> +	struct request *rq;

Why is there an explicit rq pointer? there are converters from
rq to driver req struct and vice-versa.

> +
> +	/* Vendor specific driver context */
> +	void *private_data;
> +
> +	bool async;
> +	bool last;

Undocumented and unclear why these are needed.

> +
> +	void (*done)(struct nvme_tcp_ofld_req *req,
> +		     union nvme_result *result,
> +		     __le16 status);
> +};
> +
> +enum nvme_tcp_ofld_queue_flags {
> +	NVME_TCP_OFLD_Q_ALLOCATED = 0,
> +	NVME_TCP_OFLD_Q_LIVE = 1,
> +};
> +
> +/* Allocated by nvme_tcp_ofld */
> +struct nvme_tcp_ofld_queue {
> +	/* Offload device associated to this queue */
> +	struct nvme_tcp_ofld_dev *dev;
> +	struct nvme_tcp_ofld_ctrl *ctrl;
> +	unsigned long flags;
> +	size_t cmnd_capsule_len;
> +
> +	u8 hdr_digest;
> +	u8 data_digest;
> +	u8 tos;
> +
> +	/* Vendor specific driver context */
> +	void *private_data;
> +
> +	/* Error callback function */
> +	int (*report_err)(struct nvme_tcp_ofld_queue *queue);
> +};
> +
> +/* Connectivity (routing) params used for establishing a connection */
> +struct nvme_tcp_ofld_ctrl_con_params {
> +	/* Input params */
> +	struct sockaddr_storage remote_ip_addr;
> +
> +	/* If NVMF_OPT_HOST_TRADDR is provided it will be set in local_ip_addr
> +	 * in nvme_tcp_ofld_create_ctrl().
> +	 * If NVMF_OPT_HOST_TRADDR is not provided the local_ip_addr will be
> +	 * initialized by claim_dev().
> +	 */
> +	struct sockaddr_storage local_ip_addr;
> +
> +	/* Output params */
> +	struct sockaddr	remote_mac_addr;
> +	struct sockaddr	local_mac_addr;
> +	u16 vlan_id;

Why should a ULP care about this? It's a red-flag to
me that a tcp ulp needs these params.

> +};
> +
> +/* Allocated by nvme_tcp_ofld */
> +struct nvme_tcp_ofld_ctrl {
> +	struct nvme_ctrl nctrl;
> +	struct list_head list;
> +	struct nvme_tcp_ofld_dev *dev;
> +
> +	/* admin and IO queues */
> +	struct blk_mq_tag_set tag_set;
> +	struct blk_mq_tag_set admin_tag_set;
> +	struct nvme_tcp_ofld_queue *queues;
> +
> +	struct work_struct err_work;
> +	struct delayed_work connect_work;
> +
> +	/*
> +	 * Each entry in the array indicates the number of queues of
> +	 * corresponding type.
> +	 */
> +	u32 io_queues[HCTX_MAX_TYPES];

What if the offload device doesn't support poll queue map?

> +
> +	/* Connectivity params */
> +	struct nvme_tcp_ofld_ctrl_con_params conn_params;
> +
> +	/* Vendor specific driver context */
> +	void *private_data;
> +};
> +
> +struct nvme_tcp_ofld_ops {
> +	const char *name;
> +	struct module *module;
> +
> +	/* For vendor-specific driver to report what opts it supports */
> +	int required_opts; /* bitmap using enum nvmf_parsing_opts */
> +	int allowed_opts; /* bitmap using enum nvmf_parsing_opts */

What is the difference between this one and the ulp one?

> +
> +	/* For vendor-specific max num of segments and IO sizes */
> +	u32 max_hw_sectors;
> +	u32 max_segments;

Understand max_segments maybe needed, but why max_hw_sectors? Is
that something an offload device really cares about?

> +
> +	/**
> +	 * claim_dev: Return True if addr is reachable via offload device.
> +	 * @dev: The offload device to check.
> +	 * @conn_params: ptr to routing params to be filled by the lower
> +	 *               driver. Input+Output argument.
> +	 */
> +	int (*claim_dev)(struct nvme_tcp_ofld_dev *dev,
> +			 struct nvme_tcp_ofld_ctrl_con_params *conn_params);
> +
> +	/**
> +	 * setup_ctrl: Setup device specific controller structures.
> +	 * @ctrl: The offload ctrl.
> +	 * @new: is new setup.
> +	 */
> +	int (*setup_ctrl)(struct nvme_tcp_ofld_ctrl *ctrl, bool new);

I think that the 'new' is really an odd interface, it's ok if its
internal to a driver, but not for an interface...

> +
> +	/**
> +	 * release_ctrl: Release/Free device specific controller structures.
> +	 * @ctrl: The offload ctrl.
> +	 */
> +	int (*release_ctrl)(struct nvme_tcp_ofld_ctrl *ctrl);
> +
> +	/**
> +	 * create_queue: Create offload queue and establish TCP + NVMeTCP
> +	 * (icreq+icresp) connection. Return true on successful connection.
> +	 * Based on nvme_tcp_alloc_queue.
> +	 * @queue: The queue itself - used as input and output.
> +	 * @qid: The queue ID associated with the requested queue.
> +	 * @q_size: The queue depth.
> +	 */
> +	int (*create_queue)(struct nvme_tcp_ofld_queue *queue, int qid,
> +			    size_t q_size);

queue_size

> +
> +	/**
> +	 * drain_queue: Drain a given queue - Returning from this function
> +	 * ensures that no additional completions will arrive on this queue.
> +	 * @queue: The queue to drain.
> +	 */
> +	void (*drain_queue)(struct nvme_tcp_ofld_queue *queue);

I'm assuming this is a blocking call? should probably document it.

> +
> +	/**
> +	 * destroy_queue: Close the TCP + NVMeTCP connection of a given queue
> +	 * and make sure its no longer active (no completions will arrive on the
> +	 * queue).
> +	 * @queue: The queue to destroy.
> +	 */
> +	void (*destroy_queue)(struct nvme_tcp_ofld_queue *queue);
> +
> +	/**
> +	 * poll_queue: Poll a given queue for completions.
> +	 * @queue: The queue to poll.
> +	 */
> +	int (*poll_queue)(struct nvme_tcp_ofld_queue *queue);
> +
> +	/**
> +	 * init_req: Initialize vendor-specific params for a new request.
> +	 * @req: Ptr to request to be initialized. Input+Output argument.
> +	 */
> +	int (*init_req)(struct nvme_tcp_ofld_req *req);

What is this used for?

> +
> +	/**
> +	 * send_req: Dispatch a request. Returns the execution status.
> +	 * @req: Ptr to request to be sent.
> +	 */
> +	int (*send_req)(struct nvme_tcp_ofld_req *req);
> +
> +	/**
> +	 * commit_rqs: Serves the purpose of kicking the hardware in case of
> +	 * errors, otherwise it would have been kicked by the last request.
> +	 * @queue: The queue to drain.
> +	 */
> +	void (*commit_rqs)(struct nvme_tcp_ofld_queue *queue);

Is this something you actually use? And the documentation talks about
errors which doesn't match the name, not sure what is the purpose of
this at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
