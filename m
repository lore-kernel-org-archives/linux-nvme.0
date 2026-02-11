Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A91ECD6C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OhNTfZGr1132ztLCQrF4A8s/zaIFhL7cXoYp95fh7V4=; b=huNWnXxlmKTeBn4eSvBP0C0m01
	KhaVQodLi6ElhQZQU9STiraXl26X98NtEuU7q/2G8QNco8jflNQW4ELR121fkHpRGc092n+O6+eSm
	H5fkDyTzs0isof7RYK+V+Qtuk9irxrOZpl3rgrjLdFTtyTdduzktzaKmv+R2CqZB4ISfomTGq7oyn
	w1W0LGQTePODEiDJbBRGcUH/YXZfTvWU1o9W5VOydqm9rWwCtj0KdoJIZJqesCvmDLTmVFgzCr7C1
	Ncj1VDTxI2mlrzkvkxVaLuR9+QBnrkWAB8P63BFwfCiNjaGV8WSVdBUaZ0kJ4TvSpS0OuwyTcBS97
	IX6HO0bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCbZ-00000000oda-0rri;
	Wed, 11 Feb 2026 15:58:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCbW-00000000od3-1wy7
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 15:58:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08D7168C7B; Wed, 11 Feb 2026 16:58:12 +0100 (CET)
Date: Wed, 11 Feb 2026 16:58:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme-pci: do not try to add queue maps at runtime
Message-ID: <20260211155811.GC11325@lst.de>
References: <20260210193715.2543091-1-kbusch@meta.com> <20260210193715.2543091-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210193715.2543091-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_075814_666346_286CD2FA 
X-CRM114-Status: GOOD (  13.98  )
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

On Tue, Feb 10, 2026 at 11:37:15AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer allocates the set's maps once. We can't add special
> purpose queues at runtime if they weren't allocated at initialization
> time.

Same here, a comment in the code would be helpful.

> +	if (dev->ctrl.tagset) {
> +		switch (dev->ctrl.tagset->nr_maps) {
> +		case 1:
> +			dev->nr_write_queues = 0;
> +			dev->nr_poll_queues = 0;
> +			break;
> +		case 2:
> +			dev->nr_poll_queues = 0;
> +			break;

Maybe use fallthrough or just two ifs to condense this a tiny bit?

Otherwise looks good.


