Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A4C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B2420739
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FFi78n8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B2420739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LUUawbXBog3DInz6g7CAfa4YuBIbr6nwOjfPwcLza4Q=; b=FFi78n8bfx1zev
	csNd+i5RipuyNg9/K3cyA3LqhQqGrdtA0Rz0r2Mh/xJYrYF4uwyCMaVFwbGJmq00IDJc8byKfC/4z
	mySXFhUS2AIbm6LNuIMokSkrFaMuiGvZxFR8J4Z/1mlMSKv0juzI8ufnknlKsXRePTKsiPrAAc6kT
	g0ZiuOjM0kjZ5KgnMvaoQaD4FsZ/EzbItXgoZKrVpk+F40ueM96RmWPro8JvgHlYOqotZd7vkZmIQ
	jYsiQ73sfRlzfk6wV6A2X/NEdJWadP2Sx5mM2Uyt3SO9wq8yk+2KOFSwDZATyzFXVRCGSVmp1olqF
	YzmqQwk/od3TqxJFcTdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm0Pf-0004mK-M3; Thu, 18 Jun 2020 19:41:27 +0000
Received: from charlie.dont.surf ([128.199.63.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm0Pc-0004lc-Ms
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 19:41:26 +0000
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DA454BF56E;
 Thu, 18 Jun 2020 19:35:59 +0000 (UTC)
Date: Thu, 18 Jun 2020 21:35:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 5/5] nvme: support for zoned namespaces
Message-ID: <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618145354.1139350-6-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_124124_884276_59CA7A34 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ajay Joshi <ajay.joshi@wdc.com>,
 sagi@grimberg.me, Keith Busch <keith.busch@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Aravind Ramesh <aravind.ramesh@wdc.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, hch@lst.de,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Jun 18 07:53, Keith Busch wrote:
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> new file mode 100644
> index 000000000000..d57fbbfe15e8
> --- /dev/null
> +++ b/drivers/nvme/host/zns.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/blkdev.h>
> +#include <linux/vmalloc.h>
> +#include "nvme.h"
> +
> +static int nvme_set_max_append(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_command c = { };
> +	struct nvme_id_ctrl_zns *id;
> +	int status;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.cns = NVME_ID_CNS_CS_CTRL;
> +	c.identify.csi = NVME_CSI_ZNS;
> +
> +	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> +	if (status) {
> +		kfree(id);
> +		return status;
> +	}
> +
> +	ctrl->max_zone_append = 1 << (id->zamds + 3);
> +	kfree(id);
> +	return 0;
> +}
> +
> +int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> +			  unsigned lbaf)
> +{
> +	struct nvme_effects_log *log = ns->head->effects;
> +	struct request_queue *q = disk->queue;
> +	struct nvme_command c = { };
> +	struct nvme_id_ns_zns *id;
> +	int status;
> +
> +	/* Driver requires zone append support */
> +	if (!(log->iocs[nvme_cmd_zone_append] & NVME_CMD_EFFECTS_CSUPP))
> +		return -ENODEV;
> +
> +	/* Lazily query controller append limit for the first zoned namespace */
> +	if (!ns->ctrl->max_zone_append) {
> +		status = nvme_set_max_append(ns->ctrl);
> +		if (status)
> +			return status;
> +	}
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
> +	c.identify.cns = NVME_ID_CNS_CS_NS;
> +	c.identify.csi = NVME_CSI_ZNS;
> +
> +	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
> +	if (status)
> +		goto free_data;
> +
> +	/*
> +	 * We currently do not handle devices requiring any of the zoned
> +	 * operation characteristics.
> +	 */
> +	if (id->zoc) {
> +		status = -EINVAL;
> +		goto free_data;
> +	}

A dev_err() here would be nice. I had to dig a bit to track down why my
emulated device didn't show up ;)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
