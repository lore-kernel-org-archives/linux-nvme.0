Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD2C56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:55:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EB3204EA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nc3XZ++Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EB3204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qU2GQ5rD6sn0EULcyoA4SJCJ9iyelEjlKy26rmCRYa8=; b=Nc3XZ++ZiYzHUe0aWx/S4KWrv
	44CA2Bgd4XAkt1JPtIxLvqC3h0dWh5eAJZfEuuqOZO+3wrpxk7xh4k2AB2mfCm9mw1XFlieiiH/BF
	I97ZdfykFdWdNWogOp6/dPxKMcYIOO22OS+kRM1/MaWtd8jWKWgtQWI+H8McF4TJSolZ2v5cWBRjf
	+rxgRPfiQpKcgOsZWNBMAwrBamMnYiYBqyAbb565aPbIMOsGyi1YG1+bj+7MMfE1C0fs6M3IyGjmB
	jkiYfOpjrXmZ/rsX9+XmKKeF1aLlKmNukZzGWBTohI2NCVBYrZHTymFKLeZUUv3AXV8keePFiyLpC
	/BW6P9wXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki6VO-0002MC-Ew; Thu, 26 Nov 2020 01:55:30 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki6VL-0002Lm-1k
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:55:28 +0000
Received: by mail-wm1-f65.google.com with SMTP id p22so531567wmg.3
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uN4Lv9JTyOJaSRmfcxPeTuRv4JDqK5e6vuLpA6VYe9k=;
 b=htGfFrMzDBbV6E31DMuf60CU2yb3GAtk0BCXg1EYCY84NooGhn/jDnrmSCHzu8HuQl
 u0EAzjIgPGmzX0Wdbh/KiF+C5rnFNBy7aaqtzm1Hv0M/Au6jXhO7YszkRZPHcaXJkUwl
 QUgiGd9Ip8/YqnIuPaJelEXvkgj6MCdF77jIGEOZA5sLIzsxZkYr9NQkIAkbVwRqRAJc
 5FfiflDM8gJ8q8lwLhx58fujubxsHMkoA2LEZTKkhtdIxlsyIR+vhWKiU4gACGWebtKw
 3Mpj5fW4TfJZMWNPDVL/06HIBucaE4gxShG8VHqxjDykZ8Z20NrCTGlHo+TriZppY640
 qNiA==
X-Gm-Message-State: AOAM530e8h96zHv4hKf2kRgIf0MWpwYiW9py704p5Hn2ImtUlL4McbZx
 EuQvQ9crEDzS5PCOQZkpt4w=
X-Google-Smtp-Source: ABdhPJyJqtwnkmq/Xfs3/fmOvXv1E6DN3U7r/gzgFdU+IvR/bNHDZhteRfexMmvLUCpQjogelEI9Uw==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr568906wmc.186.1606355725853; 
 Wed, 25 Nov 2020 17:55:25 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id o5sm6398112wmh.8.2020.11.25.17.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:55:25 -0800 (PST)
Subject: Re: [PATCH 1/7] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW
 offload ULP
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 Erik.Smith@dell.com, Douglas.Farley@dell.com, liuw@vmware.com
References: <20201119142107.17429-1-smalin@marvell.com>
 <20201119142107.17429-2-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d19162e-ffd6-7cb3-0e76-94d11e7d6635@grimberg.me>
Date: Wed, 25 Nov 2020 17:55:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119142107.17429-2-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_205527_162916_55FDB6D6 
X-CRM114-Status: GOOD (  48.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: aelior@marvell.com, agershberg@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, dbalandin@marvell.com, malin1024@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/19/20 6:21 AM, Shai Malin wrote:
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
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> ---
>   drivers/nvme/host/Kconfig       |  16 +++
>   drivers/nvme/host/Makefile      |   3 +
>   drivers/nvme/host/tcp-offload.c | 121 ++++++++++++++++++++++
>   drivers/nvme/host/tcp-offload.h | 173 ++++++++++++++++++++++++++++++++
>   include/linux/nvme.h            |   1 +
>   5 files changed, 314 insertions(+)
>   create mode 100644 drivers/nvme/host/tcp-offload.c
>   create mode 100644 drivers/nvme/host/tcp-offload.h
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 3ed9786b88d8..c05057e8a7a4 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -83,3 +83,19 @@ config NVME_TCP
>   	  from https://github.com/linux-nvme/nvme-cli.
>   
>   	  If unsure, say N.
> +
> +config NVME_TCP_OFFLOAD
> +	tristate "NVM Express over Fabrics TCP offload common layer"
> +	default m
> +	depends on INET
> +	depends on BLK_DEV_NVME
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
> index d7f6a87687b8..0e7ef044cf29 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
>   obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
>   obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
>   obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
> +obj-$(CONFIG_NVME_TCP_OFFLOAD)	+= nvme-tcp-offload.o
>   
>   nvme-core-y				:= core.o
>   nvme-core-$(CONFIG_TRACING)		+= trace.o
> @@ -26,3 +27,5 @@ nvme-rdma-y				+= rdma.o
>   nvme-fc-y				+= fc.o
>   
>   nvme-tcp-y				+= tcp.o
> +
> +nvme-tcp-offload-y		+= tcp-offload.o
> diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
> new file mode 100644
> index 000000000000..dfb25da7a564
> --- /dev/null
> +++ b/drivers/nvme/host/tcp-offload.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright 2020 Marvell. All rights reserved.
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
> +	    !ops->create_queue ||
> +	    !ops->drain_queue ||
> +	    !ops->destroy_queue ||
> +	    !ops->init_req ||
> +	    !ops->map_sg ||
> +	    !ops->send_req)
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
> +void nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
> +{
> +	/* Placeholder - invoke error recovery flow */
> +}
> +
> +/**
> + * nvme_tcp_ofld_req_done() - NVMeTCP Offload request done callback
> + * function. Pointed to by nvme_tcp_ofld_req->done.
> + * @req:	NVMeTCP offload request to complete.
> + * @result:     The nvme_result.
> + * @status:     The completion status.
> + *
> + * API function that allows the vendor specific offload driver to report request
> + * completions to the common offload layer.
> + */
> +void
> +nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
> +		       union nvme_result *result,
> +		       __le16 status)
> +{
> +	/* Placeholder - complete request with/without error */
> +}
> +
> +static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
> +	.name		= "tcp_offload",
> +	.module		= THIS_MODULE,
> +	.required_opts	= NVMF_OPT_TRADDR,
> +	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_DISABLE_SQFLOW |
> +			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_HOST_TRADDR |
> +			  NVMF_OPT_CTRL_LOSS_TMO | NVMF_OPT_RECONNECT_DELAY |
> +			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
> +			  NVMF_OPT_NR_POLL_QUEUES | NVMF_OPT_TOS,
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
> index 000000000000..ed340b33d366
> --- /dev/null
> +++ b/drivers/nvme/host/tcp-offload.h
> @@ -0,0 +1,173 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright 2020 Marvell. All rights reserved.
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
> +	struct nvme_tcp_ofld_ops *ops;
> +};

No name? corresponding netdev?

> +
> +/* Per IO struct holding the nvme_request and command
> + * Allocated by blk-mq.
> + */
> +struct nvme_tcp_ofld_req {
> +	struct nvme_request req;
> +	struct nvme_command nvme_cmd;
> +	struct nvme_tcp_ofld_queue *queue;
> +
> +	/* Vendor specific driver context */
> +	void *private_data;
> +
> +	void (*done)(struct nvme_tcp_ofld_req *req,
> +		     union nvme_result *result,
> +		     __le16 status);

Where is the sgl?

> +};
> +
> +/* Allocated by nvme_tcp_ofld */
> +struct nvme_tcp_ofld_queue {
> +	/* Offload device associated to this queue */
> +	struct nvme_tcp_ofld_dev *dev;
> +	struct nvme_tcp_ofld_ctrl *ctrl;
> +
> +	/* Vendor specific driver context */
> +	void *private_data;
> +
> +	/* Error callback function */
> +	void (*report_err)(struct nvme_tcp_ofld_queue *queue);

Where is the actual error?

> +};
> +
> +/* Connectivity (routing) params used for establishing a connection */
> +struct nvme_tcp_ofld_ctrl_con_params {
> +	/* Input params */
> +	struct sockaddr_storage remote_ip_addr;
> +
> +	/*
> +	 * Can be input or output, depending if host traddr was passed.
> +	 * Vendor-specific driver should determine if it should use the passed
> +	 * addr or fill it on its own.
> +	 */
> +	struct sockaddr_storage local_ip_addr;

Why is this needed? Comment is unclear to me.

> +
> +	/* Output params */
> +	struct sockaddr	remote_mac_addr;
> +	struct sockaddr	local_mac_addr;
> +	u16 vlan_id;

And why are these needed for a tcp driver?

> +};
> +
> +/* Allocated by nvme_tcp_ofld */
> +struct nvme_tcp_ofld_ctrl {
> +	struct nvme_ctrl nctrl;
> +	struct nvme_tcp_ofld_dev *dev;
> +
> +	/* admin and IO queues */
> +	struct blk_mq_tag_set tag_set;
> +	struct blk_mq_tag_set admin_tag_set;
> +	struct nvme_tcp_ofld_queue *queues;
> +
> +	/*
> +	 * Each entry in the array indicates the number of queues of
> +	 * corresponding type.
> +	 */
> +	u32 queue_type_mapping[HCTX_MAX_TYPES];
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

Why is this needed?

> +
> +	/**
> +	 * claim_dev: Return True if addr is reachable via offload device.
> +	 * @dev: The offload device to check.
> +	 * @conn_params: ptr to routing params to be filled by the lower
> +	 *               driver. Input+Output argument.
> +	 */
> +	bool (*claim_dev)(struct nvme_tcp_ofld_dev *dev,
> +			  struct nvme_tcp_ofld_ctrl_con_params *conn_params);
> +
> +	/**
> +	 * create_queue: Create offload queue and establish TCP + NVMeTCP
> +	 * (icreq+icresp) connection. Return true on successful connection.
> +	 * Based on nvme_tcp_alloc_queue.
> +	 * @queue: The queue itself.
> +	 * @qid: The queue ID associated with the requested queue.
> +	 * @q_size: The queue depth.
> +	 */
> +	bool (*create_queue)(struct nvme_tcp_ofld_queue *queue, int qid,
> +			     size_t q_size);

Why is this passing the queue and not getting the queue back from
create? anyways bool is not a good error propagation...

> +
> +	/**
> +	 * drain_queue: Drain a given queue - Returning from this function
> +	 * ensures that no additional completions will arrive on this queue.
> +	 * @queue: The queue to drain.
> +	 */
> +	void (*drain_queue)(struct nvme_tcp_ofld_queue *queue);
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
> +	void (*poll_queue)(struct nvme_tcp_ofld_queue *queue);

This should return how much was processed.

> +
> +	/**
> +	 * init_req: Initialize vendor-specific params for a new request.
> +	 * @req: Ptr to request to be initialized. Input+Output argument.
> +	 */
> +	void (*init_req)(struct nvme_tcp_ofld_req *req);

void? what does it do?

> +
> +	/**
> +	 * send_req: Dispatch a request. Returns the execution status.
> +	 * @req: Ptr to request to be sent.
> +	 */
> +	blk_status_t (*send_req)(struct nvme_tcp_ofld_req *req);

This should return a normal int not a blk_status_t.

> +
> +	/**
> +	 * map_sg: Map a scatter/gather list to DMA addresses Returns the
> +	 * number of SGs entries mapped successfully.
> +	 * @dev: The device for which the DMA addresses are to be created.
> +	 * @req: The request corresponding to the SGs, to allow vendor-specific
> +	 *       driver to initialize additional params if it needs to.
> +	 */
> +	int (*map_sg)(struct nvme_tcp_ofld_dev *dev,
> +		      struct nvme_tcp_ofld_req *req);

really weird interface map_sg that doesn't receive nor return an sg...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
