Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EE5C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNTnitEtTAg49c/4Nmqajfgphx6cUovtuIVAx2iXKKU=; b=Nwaer8ZLmKhxaSahVehu7aA9pg
	xPTvGJSEkeUXpbwU9q5lWnfoOZ2K5WpKLi4kpqhmmPrDVl3T+ujZwtEA5F/EeMk/AOJ7+W8BVt817
	JFPakEr04HiOuS7HsKvzcIWHrwC/3/pevlHk7xmmHmGlnkDkvQrRZSoEX64TceEYOlGTrC2pc34YE
	VmySiuLbj0muMCqEgexj+z/ZcukF9dB97QaAvgKvVjSCbZ2BdFAMrQ0kaa+LPSAAlI0g3UN1+YtPw
	wtyWCSNl3zZabRM50GFc9hQHISqWuwlm9UY/kvQViING9ijO2rmSAdvkqiUcON2VJmuuGMa2juO+M
	FnQ3JTJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpGl-000000071gF-30JV;
	Mon, 20 Jul 2026 14:46:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpGj-000000071et-0L0f
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:46:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE15268D32; Mon, 20 Jul 2026 16:46:50 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:46:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 2/2] nvme: stop using queue_limits_stack_bdev for
 namespace heads
Message-ID: <20260720144649.GC16699@lst.de>
References: <20260720022205.1798805-1-sangyao@kylinos.cn> <20260720022205.1798805-3-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720022205.1798805-3-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_074657_275932_CDF774E7 
X-CRM114-Status: GOOD (  16.46  )
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

On Mon, Jul 20, 2026 at 10:22:05AM +0800, Yao Sang wrote:
> NVMe namespace heads are not generic stacked block devices.

Not many things actually are, which leads to every recurring problems
with the stacking scheme..

> Execution features and request limits continue to accumulate
> conservatively as paths are refreshed.

What is this supposed to mean?

> Keep the helper local to NVMe so its field ownership remains explicit and

What is "field ownership" supposed to mean?

> does not impose NVMe namespace-head policy on mapped devices.

I think you need to clearly state in what way we'll want to diverge
here.

> +static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
> +					       const struct queue_limits *ns_lim)

Two tab indents, please.

>  {
> -	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
> -	t->max_active_zones =
> -		min_not_zero(t->max_active_zones, b->max_active_zones);
> +	/*
> +	 * Identify-derived namespace/head attributes come from the refreshed
> +	 * NVMe namespace limits, not from generic mapped-device stacking.
> +	 */
> +	lim->features &= ~(BLK_FEAT_ZONED | BLK_FEAT_ATOMIC_WRITES);
> +	lim->features |= ns_lim->features & BLK_FEAT_ZONED;
> +	lim->logical_block_size = ns_lim->logical_block_size;
> +	lim->physical_block_size = ns_lim->physical_block_size;

A lot of this still duplicates the core code and creates a nightmare
when we add new fields.

Can you try to refactor the core code into lower level building
blocks and reuse as much as possible while also making the policy
differences clear?


