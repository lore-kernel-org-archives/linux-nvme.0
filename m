Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCD5C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GeCls/1TpGuI+RYhq1povfz0TxhRmmyhmv5Tz7KN6/w=; b=TonQF6KecbRxiuHqPp8Y7rfGdc
	ZIQzhgvy9VndZiZiCg1dSPhf91sKYT+542lajKxOSHxVb4IMzAQKHvP3Up1haSjtBH5/VOlOxmFIh
	t973eKPgZePIaP6x8FLNP4hAuR2REb4xxvrI35ZcH9rYlmWWMer/0z6Y3nAwCK+2+R3A2K4awwGbQ
	AUZyYuaRcd5WXoFs+eJtx0qhmdChuJZJZecLXRN6hG7djE9VtfOtJuIDwvlGF2BHXRf7tnspFKQSy
	pJY3GSbSFJpJIDt/PijT2dsmuRl5hT4V/67f+AEQ/qFmT0lUA9xclPcJ0v7YS+nPZrBKF4LQZ9S9I
	FTjxIHEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUY7V-0000000A1Fk-0EWp;
	Wed, 25 Jun 2025 21:57:29 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUXUt-00000009x6Z-2Evl
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 21:17:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C0A06A52E72;
	Wed, 25 Jun 2025 21:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8F9C4CEEA;
	Wed, 25 Jun 2025 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750886254;
	bh=/GbWgGFy/4UaA1oIHKYxQLkUqTlpsKOvBqDSqUnS9rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Spbh67PflRJfffO5ipXEZGsoHFLy3fk39PgunrwZhCw1D6DEn8HZKx4+itfLLKQGh
	 V7DdF+n1kdcxM98DZj72zTjkKPZeELGeOLDtufXPeW6MgDIE2m2HG0lOqxwn7AIIab
	 22muKsSgpLmESLGtqRa5ZHgll523P1QUEGrWGEMNg+4uDdL3Jc4S34HF+agPZnlE0u
	 gmfmzh1FWEQoUyPQBc2+E2FCgaQBR4X/aNS7zil6pE5WHx2i70Dl0OS1YaglkF8HVu
	 HeQv832gEclSR5qpbQn/W+Z3VwjyrxAmmJD5FK40dVqcY9uHiTF+7vgmynZtMzJT4U
	 QG+IQY58UyIOA==
Date: Wed, 25 Jun 2025 15:17:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <aFxnbP68tZj6zQyb@kbusch-mbp>
References: <20250625204445.1802483-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_141735_636109_D96365FB 
X-CRM114-Status: GOOD (  11.34  )
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

On Wed, Jun 25, 2025 at 01:44:44PM -0700, Keith Busch wrote:
> +	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> +		struct bio_vec next;
> +
> +		if (!iter->iter.bi_size) {
> +			if (!iter->bio->bi_next)
> +				break;
> +			iter->bio = iter->bio->bi_next;
> +			iter->iter = iter->bio->bi_iter;

Ugh, this should have been:

			bip = bio_integrity(iter->bio);
			iter->iter = bip->bip_iter;


> +		}
> +
> +		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);

And then this should be:

		next = mp_bvec_iter_bvec(bip->bip_vec, iter->iter);

Obviously I didn't test merging bio's into plugged requests...

> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev, struct blk_dma_iter *iter)
> +{
...
> +}
> +EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);

And while I'm pointing out my mistakes, this last second name change was
pretty stupid... The export symbol needs the "_dma_" part.

