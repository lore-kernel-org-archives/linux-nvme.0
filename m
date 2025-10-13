Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BBACCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfO5R3KEDe0QOijEUV2KTeoUed/JmpjYhYgJMgZHg0M=; b=isaORcaq7cQlEiLYNZkAOAB/3z
	tYO5wlPqTE2T9njIc2jsvAHWKz2HfSWT4UT4lF8hMSehGYB1EsIreiwjxg9G0B4aAzj4LPkww7Bm6
	UBAucVZfB9XyKor3Sj6XqGBOez6+H3uMN+aQgwVioQUPw13o1iqhN2J1FgW9FKPZ9K+nTctwkIfsv
	lX+uJWDn2Cvm01HgPg+LvkR+Yic7n2ni3w7YyKgvE5lGRY+HSPs5JWPzuU4qp65fgSUCHDTjUS092
	/Xglkp6sTROTd+nOBBbc1O2ZuqFqwz8vqjRAIvf4zky4bt2Lyfs0ClsGQoZeBpQYvAvZBL+AGrBPA
	lY2VXCkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OKR-0000000EIM0-3nuM;
	Mon, 13 Oct 2025 19:35:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OKP-0000000EILZ-44G7
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 19:35:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 89E604050C;
	Mon, 13 Oct 2025 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA01C4CEE7;
	Mon, 13 Oct 2025 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384129;
	bh=PDb/9QSmnfc9gdH61UyK4f+MBTlIYS2e0YlFH2q7c3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W597waVYS8NqjFkFpcAEzQ0yXJsQua2oaQbGXwesKEmyI86rGnOWEgSzgL9FBiMwM
	 2xNG220+PBCwFfynAwT0hOrXJvH4QGnvg5O/sdxTN7AfeTarzLAuG0Py6P3hMN/gvA
	 I6RWa65wJ9S4uKS3qF/oWVqKEvG5vu5ZlJ2UC6gveM7j+KwamUjZRnx8XJ7ZgsBWVG
	 MFj+vcEpe+99RcsTQBAYIQHuyV36KYDlt5xJSqfYlstzoWaqb8qxZP+uWRSY9mLCbb
	 impCsRC9ARPclTlVCOeA9R5qwI3adi+sECArMrt/MgCtmK6IOZyQ9LrcLrLlNWMFAk
	 cpQITFN+5yjzw==
Date: Mon, 13 Oct 2025 22:35:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/4] blk-mq-dma: unify DMA unmap routine
Message-ID: <20251013193525.GD14552@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
 <aO1Ku5DCIMVRirdu@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1Ku5DCIMVRirdu@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_123530_022529_A4AE1C15 
X-CRM114-Status: GOOD (  13.57  )
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

On Mon, Oct 13, 2025 at 12:53:47PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 06:34:10PM +0300, Leon Romanovsky wrote:
> > +bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, size_t mapped_len)
> > +{
> > +	struct bio_integrity_payload *bip = bio_integrity(req->bio);
> > +
> > +	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
> > +	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
> > +		return true;
> 
> I don't think you can unify it at this part here because the data
> payload might not be P2P but the integrity payload could be. The data
> payload needs to proceed to the next unmapping step in that case, but
> this change would have it return true early.

I was under wrong impression that request has or data payload or
integrity, but never both :(.

Thanks

