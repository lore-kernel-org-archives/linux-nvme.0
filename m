Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A7C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:49:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E24217F4
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WF3W3n+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E24217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=spNVGgvKqvKl910qS+rQx11DXThW0WJOYrbdiayUDdw=; b=WF3W3n+K2EChdf
	JA/nM1i81fxWqQeLgAKBkRFvBIYpxV3dxFjKdAKVFnjHvOYmu021E+JpGiVZCsPyAu6lWY9T/xmtP
	yT1y2wFNohEQ9TWLwcwqEv1LvVepG+/5DvjhNdNJTLzZVszmnD98fd2KkOVF/8JOrMU4S21rU2kaY
	UF0PMWHql0sWKAPZxKKwJ5Z4RShqHU4X+FOE8VMhQc1Uvr+nJybXp0eK36VIUSe8MULQEBoYiwyQo
	kUjbLgzzulVpEbMBh86wdZiGw6qQiTZ68gYB+rBkuDDKkBLWiGxVC+YEyfNk/yqAm/J6KDn5A4QZV
	p9qihLi9WywRwTUNyv0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS2x5-0002B9-Ku; Tue, 05 Nov 2019 17:49:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS2x1-0002Ab-Ps
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 17:49:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 17CAA68AFE; Tue,  5 Nov 2019 18:49:05 +0100 (CET)
Date: Tue, 5 Nov 2019 18:49:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 02/15] nvme: Fail __nvme_revalidate_disk in case of a
 spec violation
Message-ID: <20191105174904.GA18972@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-4-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105162026.183901-4-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_094907_992067_93D47D64 
X-CRM114-Status: GOOD (  14.06  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 06:20:13PM +0200, Max Gurtovoy wrote:
> An extended LBA is a larger LBA that is created when metadata associated
> with the LBA is transferred contiguously with the LBA data (AKA
> interleaved). The metadata may be either transferred as part of the LBA
> (creating an extended LBA) or it may be transferred as a separate
> contiguous buffer of data. According to the NVMeoF spec, a fabrics ctrl
> supports only an Extended LBA format. Fail revalidation in case we have a
> spec violation. Also init the integrity profile for the block device for
> fabrics ctrl.

I don't think the subject describes very well what this patch does,
as it really wires up parsing and checking the ext flag for fabrics.

> +	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
> +		if ((ns->ctrl->opts && ns->ctrl->opts->pi_enable) || !ns->ext)
> +			nvme_init_integrity(disk, ns->ms, ns->pi_type);
> +	}

Can we just have a flag that says we have working metadata support instead
of having to duplicate the checks all over?

>  	ns->noiob = le16_to_cpu(id->noiob);
>  	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
>  	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
> +
> +	/*
> +	 * For Fabrics, only metadata as part of extended data LBA is supported.
> +	 * fail in case of a spec violation.
> +	 */
> +	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_FABRICS)) {
> +		if (WARN_ON_ONCE(!ns->ext))
> +			return -EINVAL;
> +	}
> +
>  	/* the PI implementation requires metadata equal t10 pi tuple size */
>  	if (ns->ms == sizeof(struct t10_pi_tuple))

This is getting a little convoluted.  I think this should rely on the
fact that we zero the whole namespace structure and clean a lot of the
mess up.  Also I think we should reject non-external metadata on PCIe
as we can't really properly support it right here.  Also instead of
using NVME_F_FABRICS I'd rather split NVME_F_METADATA_SUPPORTED into
a flag each for external or inline metadata supported.  That also means
your patch 1 can be moved much later in series where it belongs.

	if (ns->ms) {
		ns->ext = id->flbas & NVME_NS_FLBAS_META_EXT;
		if (ns->ext) {
			if (!(ns->ctrl->ops->flags & NVME_F_EXTENDED_LBA))
				return -EINVAL;
		} else {
			if (!(ns->ctrl->ops->flags & NVME_F_METADATA_P)))
				return -EINVL;
		}
		ns->metadata_supported = true;

		/*
		 * The PI implementation requires metadata equal t10 pi tuple
		 * size:
		 */
		 if (ns->ms == sizeof(struct t10_pi_tuple))
		 	ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
	}

> - out_put_disk:
> +out_put_disk:
>  	put_disk(ns->disk);
> - out_unlink_ns:
> +out_free_disk:
> +	del_gendisk(ns->disk);
> +out_unlink_ns:
>  	mutex_lock(&ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
>  	mutex_unlock(&ctrl->subsys->lock);
>  	nvme_put_ns_head(ns->head);
> - out_free_id:
> +out_free_id:
>  	kfree(id);
> - out_free_queue:
> +out_free_queue:
>  	blk_cleanup_queue(ns->queue);
> - out_free_ns:
> +out_free_ns:

No real need to reformat this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
