Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895C1CCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YvzO79GjlH7tw/AHXY287jgE7wl+02f1uY29TKhsCw=; b=n9lpOajcDwBoHzzk0K1dilEMrc
	0jc2/oc4ltaxzfj5x1PCS3XBXG9E7n4CNdKy01lNKDfIMdhFoqEea7oKdXpM12cLq4I+CCcRqlcP6
	UCs4WksrhSNeWuGQWGMBwRHRWbHLgsyLk9JmwzgaQKAa+DuiwS+6/CEwBt1Thws9H9NBC24APFHer
	05WRvwU93s4gWa/HvyE5w5t1TS4jRIjhscmolvFKniSLCYf+gWFtbO2OKK591kjqFj0KtWSI38GA2
	9vURMgegVtNe16QtQ4I9452zNj2F+YeBNycix33la9aXsDuusqM7k3X3aP0V2XX/1OypZ2Koht80B
	eIG0+aDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Ng8-0000000ECNe-1GRN;
	Mon, 13 Oct 2025 18:53:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Ng6-0000000ECNK-1rKi
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 18:53:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F27145200;
	Mon, 13 Oct 2025 18:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F89AC4CEE7;
	Mon, 13 Oct 2025 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381629;
	bh=QbCkkqHDRODaloYhX6Hv/SUHAubYrcVQyDlxupIG2jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+VWFlbym/MbpFKzMA0bfI4FgsEQzA2Uv+xaqz8XNUt+vQrC3luUw15Zdmmn70O++
	 OQItyqjhCU1wvRt9DE1zHfO+SQ1GeKLtWMmBwufETANYEO2pTFTFR2PpcZ4yt3+9XN
	 VE+D6Ed7rPRbKv2m6DpvUdaK/bvHcz5wm65Mg6uta4IUx5EX3aDC7fpD2QCePcR3eM
	 hKWooNw4wnbGr96FeIEC2dT5IOCnvE/9VsD5WFYu2H5GIgnAHkP2UStgL3g2seV/as
	 PLOPYpFBFR9RKBFSfsYnINP2TgnWBNzvuGk9uphOiJDbypaZQ5V/0HRDi4XpxsyrlS
	 +s6vUK8mMnydg==
Date: Mon, 13 Oct 2025 12:53:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/4] blk-mq-dma: unify DMA unmap routine
Message-ID: <aO1Ku5DCIMVRirdu@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_115350_500206_F4A2B738 
X-CRM114-Status: GOOD (  10.91  )
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

On Mon, Oct 13, 2025 at 06:34:10PM +0300, Leon Romanovsky wrote:
> +bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, size_t mapped_len)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(req->bio);
> +
> +	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
> +	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
> +		return true;

I don't think you can unify it at this part here because the data
payload might not be P2P but the integrity payload could be. The data
payload needs to proceed to the next unmapping step in that case, but
this change would have it return true early.

