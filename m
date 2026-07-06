Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E496BC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rinMnqakmw3sXeXqyVmCy2MjaLJ0YRohop5WivEfGNw=; b=KCTxpnYNKyccC1pZeC2eHPLXG2
	StQpgK8qzckakSueHLIUswNS4cqFt4WXmEKAKe2GhoWSyeqg+BgGHX0YUl2k09smhj3y1ptmvr4V8
	5mZi9SjPt5GizkIh9qcsBGuO0bnmh7IzGxbAExGYXFCZMrrVbRfX7xE3peeLztSUupbOct7jViQpA
	fZDXjIZtue1hAyfM78oR18828aW+99s7yeHcsu3XfG0qmmUeEs2GEhmutZD1WY2Mogstukf1R4mzA
	0ielkqaUhNPSDp96GHt3vPKyJh5G8i1Qy1oxZpZoXd76bi9uzZEeXIrPsfNQxhSyL6RS9h+h4xPxs
	y9VqUu2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoRx-0000000DNpH-3TF2;
	Mon, 06 Jul 2026 18:53:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoRq-0000000DNp5-2GUv
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:53:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 991B641375;
	Mon,  6 Jul 2026 18:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C751F000E9;
	Mon,  6 Jul 2026 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364019;
	bh=rinMnqakmw3sXeXqyVmCy2MjaLJ0YRohop5WivEfGNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O33XfqL/241LO0nhab6rTkwAC6/HDxoiQqjY7joQ/IVX5lI21uyT7mlupmArjLNqN
	 F0+m8KmgsnHXYHKDz/LjdO6X9gVO2uNLb7M4+BxeJcCmDcnOOVKVMpXQC6Fx2xzgEs
	 v1m0KJ2ExDwsf6XNZPaLRCeb6IYyUh2F/ZxcYLMUoVRtfbU03PWikW7Jns8y4f8OvC
	 TqHKg+gntUodBe06ZHDsL1Etth/kycSfajDSygmfGgZ9PYdrwXptMBY1Ghrq64z8Gn
	 BfRyUTkBtA241GfLUc9l3+8tFQyY/es8HLFhexl1SCfMN361RiQramchnnxq2TyAEc
	 0uodGXpdoVL4A==
Date: Mon, 6 Jul 2026 12:53:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, dlemoal@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2] nvme-multipath: revalidate zones for namespace heads
Message-ID: <akv5sZSOvxW7JbWI@kbusch-mbp>
References: <20260610032846.54044-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610032846.54044-1-sangyao@kylinos.cn>
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

On Wed, Jun 10, 2026 at 11:28:46AM +0800, Yao Sang wrote:
> Zoned multipath namespace heads get BLK_FEAT_ZONED and their limits are
> refreshed from the paths, but the zone state for the head disk is never
> initialized. The previous nr_zones assignment only updated a single
> field and did not allocate or populate the block layer's per-zone state.
> 
> The failure was found with xfstests xfs/643 and xfs/646 on an NVMe
> ZNS multipath namespace. Tracing showed regular REQ_OP_WRITE I/O being
> submitted to sequential zones through the multipath head.

Thanks, applied to nvme-7.3.

