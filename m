Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A56C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:06:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AB82080C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0XwXSgBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AB82080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XkrQJ0LwxnsinIxZ94/qJBCCI8BQbDsr4xJSaptvVTU=; b=0XwXSgBEJF56kQmztsOaPyr6D
	1MpevrSBq8SkktscCAhmVxJXdE+YzXc84O2RfRxhTi32JUFcslfw6PLx5yDvBrImA9zmYzRF4XHxS
	/xS0D9BIyJyfgRZS9FZUqFB9Vxhsutgm6cc/SR597OgEdStXR20JFglwQb3DjEfn71eOartb9690f
	Q92h/VwFl58Wdoioai/uab0TfO2Pc6/R0NPjCNbFZF6Lko+YCubnnDqIW6KV2inL+XgsTpmBlIiTz
	1hr3oXawZvfOa5KacKvKlySa/ZTXqQg8X/PKqWpAEymEqt8UDwvSBgeu5jLQUGtRmlWRhnnUqOW3h
	3fwA0CPYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBKQN-0002UL-0F; Thu, 27 Aug 2020 16:06:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBKQK-0002Tj-0D
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 16:06:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 91C4A68BEB; Thu, 27 Aug 2020 18:06:44 +0200 (CEST)
Date: Thu, 27 Aug 2020 18:06:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200827160644.GA10869@lst.de>
References: <20200827152824.2784396-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827152824.2784396-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_120648_161767_BD92E719 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 27, 2020 at 08:28:24AM -0700, Keith Busch wrote:
> +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> +		blk_queue_chunk_sectors(ns->queue, iob);
> +	else if (iob && !(disk->flags & GENHD_FL_UP))
> +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
> +			ns->head->ns_id, iob);
> +

Similar to the zoned stuff I just find this super hard to read.

I wonder if we need to untangle this a little.  Something like

static inline bool nvme_first_scan(struct nvme_ns *)
{
	/* add a comment here */
	return !(ns->disk->flags & GENHD_FL_UP)
}

static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
{
	u32 chunk_sectors = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));

	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
	    is_power_of_2(ctrl->max_hw_sectors))
	    	chunk_sectors = ctrl->max_hw_sectors;

	if (!chunk_sectors)
		return;

	if (!is_power_of_2(chunk_sectors)) {
		if (nvme_first_scan(ns)) {
			dev_warn(ctrl->device,
				"namespace%u: ignoring unaligned I/O boundary: %u\n",
				ns->head->ns_id, chunk_sectors);
		}
		return;
	}

	if (blk_queue_is_zoned(ns->queue)) {
		if (nvme_first_scan(ns)) {
			dev_info(ctrl->device,
				"namespace%u: ignoring I/O boundary for zoned namespace\n",
				ns->head->ns_id);
		}
		return;
	}
			
	blk_queue_chunk_sectors(ns->queue, chunk_sectors);
}

>  	nvme_update_disk_info(disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
> -- 
> 2.24.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
