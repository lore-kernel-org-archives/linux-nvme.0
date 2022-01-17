Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C2EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jan 2022 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
	:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bE7XGG7JHTbEocyOQv+58wvSJiYi+mCpCSCYzUavIH4=; b=iFJL2NwwmKIRi7mhBtBEMgPEBW
	hNn0VpugxMb1ldw3durVg1odotXbaKlWjM5W3mqXy2fN21erRkvDUDdsypiQVBNfoNZ8MUi2zYDSX
	2dZ0GhcmPSJYojFmJmx5Dh20853Z9qvKoyCtAQb/ORvuId5+9p1+fHtj583wjZW0BchLRWCzTAmnW
	lMxG9S3hsR1PrvqPK2P4Vk6ER0o7losAmx793OOb9MV1K2nZg9Edv89AGcX/jss/SuOgobtGssLY4
	NBqjslXcXT0WwWoEpyx4IwxnTj3IpxOAwRz+jb2HaAkZzSA8LXr0QbMvqnC+ZFi+3Oww49TVu7eH4
	tr02bBAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9SRO-00F5mp-Pv; Mon, 17 Jan 2022 13:52:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9SRB-00F5he-Cw
 for linux-nvme@lists.infradead.org; Mon, 17 Jan 2022 13:52:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C59921F399;
 Mon, 17 Jan 2022 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642427561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bE7XGG7JHTbEocyOQv+58wvSJiYi+mCpCSCYzUavIH4=;
 b=TMZ4gWW/Axl6wPm9Y1qbC/fluCfW9zv1Cs89ZBhJdHSW4xZNCw9TjP8tYGq9mmEceoJiz/
 BJ9G/A1sN79fWEkXnsT8X+bCki8Yra7gY/G/Lnsm4ZsV8tFAxJIWCPXGm2OlLoqrw5PFW1
 Z4ZFp2J9s02ifT9elk/UD6zj6OwQdKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642427561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bE7XGG7JHTbEocyOQv+58wvSJiYi+mCpCSCYzUavIH4=;
 b=RJospXDd4o0t5HjC08b9abEiSKRCkx315v1d7RdSWT33r1l8SLItK+Vj1Ghn9SAXhdggRb
 +WMXx6vKgzjqJ+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B630713D27;
 Mon, 17 Jan 2022 13:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 98I0LKl05WG1VAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 17 Jan 2022 13:52:41 +0000
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20211223215726.71096-1-alan.adamson@oracle.com>
 <20211223215726.71096-2-alan.adamson@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 1/1] nvme: Add verbose error logging
Message-ID: <08e72d54-4bd8-acaf-3a8b-03e5ec66280a@suse.de>
Date: Mon, 17 Jan 2022 14:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211223215726.71096-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220117_055245_639017_1406251D 
X-CRM114-Status: GOOD (  33.67  )
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

On 12/23/21 10:57 PM, Alan Adamson wrote:
> Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
> a verbose description of the error is logged, otherwise only status codes/bits
> is logged.
> 
> Verbose logging example:
> nvme0n1: Read @ LBA 2304, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
> 
> Non-verbose logging example:
> nvme0n1: Read @ LBA 2304, 1 blocks, NVME Error (sct 0x2 / sc 0x81) DNR
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>  drivers/nvme/host/Kconfig  |   8 ++
>  drivers/nvme/host/Makefile |   2 +-
>  drivers/nvme/host/core.c   |   3 +
>  drivers/nvme/host/errors.c | 202 +++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h   |   2 +
>  include/linux/nvme.h       |   1 +
>  6 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/nvme/host/errors.c
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index dc0450ca23a3..d6d056963c06 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -24,6 +24,14 @@ config NVME_MULTIPATH
>  	   /dev/nvmeXnY device will show up for each NVMe namespace,
>  	   even if it is accessible through multiple controllers.
>  
> +config NVME_VERBOSE_ERRORS
> +	bool "NVMe verbose error reporting"
> +	depends on NVME_CORE
> +	help
> +	   This option enables verbose reporting for NVMe errors. The
> +	   error translation table will grow the kernel image size by
> +	   about 4 KB.
> +
>  config NVME_HWMON
>  	bool "NVMe hardware monitoring"
>  	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index dfaacd472e5d..ea3d702feb51 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
>  obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
>  obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
>  
> -nvme-core-y				:= core.o ioctl.o
> +nvme-core-y				:= core.o ioctl.o errors.o
>  nvme-core-$(CONFIG_TRACING)		+= trace.o
>  nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
>  nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1af8a4513708..fda029a55436 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -354,6 +354,9 @@ void nvme_complete_rq(struct request *req)
>  
>  	switch (nvme_decide_disposition(req)) {
>  	case COMPLETE:
> +		if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +			nvme_error_log(req);
> +
>  		nvme_end_req(req);
>  		return;
>  	case RETRY:
> diff --git a/drivers/nvme/host/errors.c b/drivers/nvme/host/errors.c
> new file mode 100644
> index 000000000000..3183b2e728d4
> --- /dev/null
> +++ b/drivers/nvme/host/errors.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express device driver verbose errors
> + * Copyright (c) 2021, Oracle and/or its affiliates
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/blkdev.h>
> +#include "nvme.h"
> +
> +struct nvme_string_table {
> +	unsigned int code;
> +	const unsigned char *string;
> +};
> +
> +static const struct nvme_string_table nvme_ops[] = {
> +	{ REQ_OP_READ,			"Read" },
> +	{ REQ_OP_WRITE,			"Write" },
> +	{ REQ_OP_FLUSH,			"Flush" },
> +	{ REQ_OP_DISCARD,		"Deallocate (DSM)" },
> +	{ REQ_OP_WRITE_ZEROES,		"Write Zeroes" },
> +	{ REQ_OP_ZONE_RESET_ALL,	"Zone Reset All" },
> +	{ REQ_OP_ZONE_RESET,		"Zone Reset" },
> +	{ REQ_OP_ZONE_OPEN,		"Zone Open" },
> +	{ REQ_OP_ZONE_CLOSE,		"Zone Close" },
> +	{ REQ_OP_ZONE_FINISH,		"Zone Finish" },
> +	{ REQ_OP_ZONE_APPEND,		"Zone Append" },
> +};
> +#define NVME_OPS_SIZE ARRAY_SIZE(nvme_ops)
> +
> +#ifdef CONFIG_NVME_VERBOSE_ERRORS
> +#define TEN_NULLS	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
> +
> +static const char * const nvme_errors[] = {
> +	"Success",
> +	"Invalid Command Opcode",
> +	"Invalid Field in Command",
> +	"Command ID Conflict",
> +	"Data Transfer Error",
> +	"Commands Aborted due to Power Loss Notification",
> +	"Internal Error",
> +	"Command Abort Requested",
> +	"Command Aborted due to SQ Deletion",
> +	"Command Aborted due to Failed Fused Command",
> +	"Command Aborted due to Missing Fused Command",
> +	"Invalid Namespace or Format",
> +	"Command Sequence Error",
> +	"Invalid SGL Segment Descriptor",
> +	"Invalid Number of SGL Descriptors",
> +	"Data SGL Length Invalid",
> +	"Metadata SGL Length Invalid",
> +	"SGL Descriptor Type Invalid",
> +	"Invalid Use of Controller Memory Buffer",
> +	"PRP Offset Invalid",
> +	"Atomic Write Unit Exceeded",
> +	"Operation Denied",
> +	"SGL Offset Invalid",
> +	"Reserved",
> +	"Host Identifier Inconsistent Format",
> +	"Keep Alive Timeout Expired",
> +	"Keep Alive Timeout Invalid",
> +	"Command Aborted due to Preempt and Abort",
> +	"Sanitize Failed",
> +	"Sanitize In Progress",
> +	"SGL Data Block Granularity Invalid",
> +	"Command Not Supported for Queue in CMB",
> +	"Namespace is Write Protected",
> +	"Command Interrupted",
> +	"Transient Transport Error",
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +	"Invalid IO Command Set",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS, TEN_NULLS, TEN_NULLS,
> +	NULL, NULL, NULL,
> +	"LBA Out of Range",
> +	"Capacity Exceeded",
> +	"Namespace Not Ready",
> +	"Reservation Conflict",
> +	"Format In Progress",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS, TEN_NULLS, TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, NULL, NULL, NULL,
> +	"Completion Queue Invalid",
> +	"Invalid Queue Identifier",
> +	"Invalid Queue Size",
> +	"Abort Command Limit Exceeded",
> +	"Reserved",
> +	"Asynchronous Event Request Limit Exceeded",
> +	"Invalid Firmware Slot",
> +	"Invalid Firmware Image",
> +	"Invalid Interrupt Vector",
> +	"Invalid Log Page",
> +	"Invalid Format",
> +	"Firmware Activation Requires Conventional Reset",
> +	"Invalid Queue Deletion",
> +	"Feature Identifier Not Saveable",
> +	"Feature Not Changeable",
> +	"Feature Not Namespace Specific",
> +	"Firmware Activation Requires NVM Subsystem Reset",
> +	"Firmware Activation Requires Reset",
> +	"Firmware Activation Requires Maximum Time Violation",
> +	"Firmware Activation Prohibited",
> +	"Overlapping Range",
> +	"Namespace Insufficient Capacity",
> +	"Namespace Identifier Unavailable",
> +	NULL,
> +	"Namespace Already Attached",
> +	"Namespace Is Private",
> +	"Namespace Not Attached",
> +	"Thin Provisioning Not Supported",
> +	"Controller List Invalid",
> +	"Device Self-test In Progress",
> +	"Boot Partition Write Prohibited",
> +	"Invalid Controller Identifier",
> +	"Invalid Secondary Controller State",
> +	"Invalid Number of Controller Resources",
> +	"Invalid Resource Identifier",
> +	"Sanitize Prohibited",
> +	"ANA Group Identifier Invalid",
> +	"ANA Attach Failed",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS,
> +	"Conflicting Attributes",
> +	"Invalid Protection Information",
> +	"Attempted Write to Read Only Range",
> +	"ONCS Not Supported",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, NULL, NULL,
> +	"Zoned Boundary Error",
> +	"Zone Is Full",
> +	"Zone Is Read Only",
> +	"Zone Is Offline",
> +	"Zone Invalid Write",
> +	"Too Many Active Zones",
> +	"Too Many Open Zones",
> +	"Invalid Zone State Transition",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, NULL, NULL,
> +	"Write Fault",
> +	"Unrecovered Read Error",
> +	"End-to-end Guard Check Error",
> +	"End-to-end Application Tag Check Error",
> +	"End-to-end Reference Tag Check Error",
> +	"Compare Failure",
> +	"Access Denied",
> +	"Deallocated or Unwritten Logical Block",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	NULL,
> +	"Asymmetric Access Persistent Loss",
> +	"Asymmetric Access Inaccessible",
> +	"Asymmetric Access Transition",
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
> +	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +	"Host Pathing Error",
> +};
> +#define NVME_ERRORS_SIZE ARRAY_SIZE(nvme_errors)
> +#endif /* CONFIG_NVME_VERBOSE_ERRORS */
> +

This 'ten NULLs' stuff is patently ugly.

I would suggest split off this array into several, taking a cue on how
the status codes are arranged in the NVMe spec.
IE have one array for generic status values
(ie figure 94 in NVMe-Base 2.0a; maybe even split that one into two for
the 0x8X values), another one for command specific values (ie figure 95)
and so on.
Within these sections the status codes are assigned consecutively, so
there shouldn't be any holes in them, and we do avoid the NULL padding.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

