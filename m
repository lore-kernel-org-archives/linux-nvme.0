Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9174AE83056
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3pEPKhfGz33euKMKqbnesG7l9sRdD9433OJM3NH6d4=; b=Bbky0W9idj4dsswrWNdW4TD/Y0
	Z+PJ9rSpQXwsKCyTANAGJYs0I/4OD3r1V99a+WRxyrpgNn4a1e4y325CnYWxfT3IQ9zrLVOB1m2K/
	u298PJK5X+xG28so1gChgMkIjpTjx2zONGVAaLcTDKXI7ygZYiS7qxXZRph1vOZ1sFF7OQS2TNPLs
	ol+2hCEiEMkt8YbdbO/QKXQu9s8LPGQV2CAFAMBDOcI2tZPauR6keJ7gmW2onKcBX+jvEsVsEd0Qq
	FOUTlcyGrkiv0Bk8bLsD+skWEfJU7As4uKeG8wMLvXG0au7vzZ4H1TnYckjKYtAcRydQjaBStGLBu
	O5ccCWRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9p5-00000006BAD-2ybr;
	Tue, 03 Feb 2026 06:23:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9p3-00000006B9q-1feC
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 06:23:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F135868B05; Tue,  3 Feb 2026 07:23:34 +0100 (CET)
Date: Tue, 3 Feb 2026 07:23:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203062334.GI16426@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp> <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp> <20260203052756.GA15839@lst.de> <aYGSP4luf1nOFhS2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYGSP4luf1nOFhS2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_222337_602404_D05E3074 
X-CRM114-Status: GOOD (  18.78  )
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

On Mon, Feb 02, 2026 at 11:14:23PM -0700, Keith Busch wrote:
> On Tue, Feb 03, 2026 at 06:27:56AM +0100, Christoph Hellwig wrote:
> > >  	iod->nr_descriptors = 0;
> > >  	iod->total_len = 0;
> > >  	iod->meta_total_len = 0;
> > > +	iod->nr_dma_vecs = 0;
> > > +	iod->dma_vecs = NULL;
> > 
> > I don't think we need the dma_vecs initialization here, as everything
> > is keyed off nr_dma_vecs.
> 
> Yes, we should definitely use nr_dma_vecs and skip the NULL setting. I'm
> a big fan removing unnecessary initialisations. Just a caution, my
> suggested patch has this check:
> 
> 	if (!iod->dma_vecs)
> 
> So we just need to update it to use 'iod->nr_dma_vecs' instead, which
> would have been correct, too.

Ah, right.

