Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2B3CD4F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Og3M6X/dLfVH0LKqo+qx8nIvaIABgCH8sr09iFhkGfY=; b=NbHjeVQ1CzYy55CveOkzd7eA2e
	cS/cMCL+lbHSeXuNBAOGUQ3EAXxyUYXH/zhq8X/wDp6qRLwcCeKr74+zto/uBV8Qk9/eYQbf5LDZF
	2Yi2XmDYmMXjrfKbHKKQrAsZU5fT89QM3Sv0OPJOQoLQQqDzx4Xohe8seGvp/vUgez6ockgo3PIri
	Y2QXlbhddbj7Mfa+FQlsgDksISKgXltsbbIh18eHTp1AyS4I5oDVe3Co+4shxDU8HurepSNCdaEA6
	RukuomlzyhdngHo9VFtjSIOEma42o+bGlraEsfpPgUvXGxPlxSJOG5zmB+DG1rbVrKukodhLvdtDI
	FG2RFa0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbJT-00000003nBW-2YpF;
	Wed, 20 May 2026 07:25:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbJR-00000003nAc-2rzp
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 07:25:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E039168BFE; Wed, 20 May 2026 09:25:48 +0200 (CEST)
Date: Wed, 20 May 2026 09:25:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com,
	coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
Message-ID: <20260520072548.GC14937@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519172326.3462354-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_002553_868829_398503AE 
X-CRM114-Status: GOOD (  12.88  )
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

Replying here, but at least the high-level issue applies to the
previous patch as well.

Moving the checking from submit_bio_noacct into __bio_split_to_limits
means that we lose it for bio-based drivers except for the few that
manuall call bio_split_to_limits.  So we'll still need a helper for
them, which could be called just before calling into ->submit_bio.

> -static inline blk_status_t blk_check_zone_append(struct request_queue *q,
> -						 struct bio *bio)
> -{

Keeping a helper for this instead of doing a lot of work in a switch
statements feels nicer.

> -static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
> -						 struct bio *bio)
> -{
> -	if (bio->bi_iter.bi_size > queue_atomic_write_unit_max_bytes(q))
> -		return BLK_STS_INVAL;
> -
> -	if (bio->bi_iter.bi_size % queue_atomic_write_unit_min_bytes(q))
> -		return BLK_STS_INVAL;
> -
> -	return BLK_STS_OK;
> -}

Similar for this one.


