Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B4E83058
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 06:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cdIVbyyRie03PhPOAYQJRMWzaX561jLlwz1v3KDW/X0=; b=z70eahCUlnsclA/t8Bvgm5CEwb
	JughRePIeKa0cW+Wzf576VKXGWY6sgFvR+Oh9oyjVaFtVd98Z+ROou6GiHb2a2AAAPwl6NqQkcwz6
	JjJmapvQSEES8zIXEH7ihMRI0tdlhc2/wgsX+qNd0LUS3N0Uii8r8sTLSDEkItPx0ZelYi67sUnP+
	fRQub8yXXv5WiYDqtE406x0q8Y6dl1GgFAoJNp1d7qlvP7Y9Qv39mDV0ylyNbvnUF4MgiHl3u06k3
	YzqNbCJ18iWBpRIE7P5y3xXXoEqTi5E/vNqPQxf456vaGgvTmTNOCSxki06tcgRYPYW+gK7ECbSkq
	PZ3dGTiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9gD-00000006AbN-1PID;
	Tue, 03 Feb 2026 06:14:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9gB-00000006AbH-2kze
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 06:14:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9D04660128;
	Tue,  3 Feb 2026 06:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C0AC116D0;
	Tue,  3 Feb 2026 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770099266;
	bh=ZRLmHQ6WbGoWDl85DpVVViz2f0mnbKfHUjBEQxspXaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a25gm59zkLTTTg5ib78zaGpSNSL4Z6hzL/0K/yF7DtEms6jmUt9YfklXea7FgMouW
	 WDUl/EBex3Y5zOJhH81rog+QdTvd7+K1XjlNyHrUotRdJNX8eHJzCS2cCyjcRmEd0E
	 6gdAcQhw3MvR7RaSAry3teiFQB6EBjViY/I6eWu1HSdCFDsPpdsNtDaeLYMpotPxi4
	 IHi1qDDgLqLWJiwZa2WGNEhXV4O7Hour/RMl/NUaHh84RBjg526pxDZPy/Up7cDE/Y
	 sKJCd5dlwXerhQwVj/Cy/Bdn81SaDz0AmRIuGOPSfh8UYBbM/LWIwzdqXe/FQQa7Es
	 g/f1M/xzuCzQA==
Date: Mon, 2 Feb 2026 23:14:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYGSP4luf1nOFhS2@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203052756.GA15839@lst.de>
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

On Tue, Feb 03, 2026 at 06:27:56AM +0100, Christoph Hellwig wrote:
> >  	iod->nr_descriptors = 0;
> >  	iod->total_len = 0;
> >  	iod->meta_total_len = 0;
> > +	iod->nr_dma_vecs = 0;
> > +	iod->dma_vecs = NULL;
> 
> I don't think we need the dma_vecs initialization here, as everything
> is keyed off nr_dma_vecs.

Yes, we should definitely use nr_dma_vecs and skip the NULL setting. I'm
a big fan removing unnecessary initialisations. Just a caution, my
suggested patch has this check:

	if (!iod->dma_vecs)

So we just need to update it to use 'iod->nr_dma_vecs' instead, which
would have been correct, too.

