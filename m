Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B53EEE0217
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sh9MvX9mYqh24F8vgpE7Zb5M7yiErTJqYnqXONGIsA=; b=IPSbIzQ3DMlioDpyHB63tRDVEe
	Ts649cx/jj8SefVU+YImv4tNoQJggDsxoHs7craQleJUJ1fFQXxs36Qt96nIsh/+9SO3LJa2bxoG/
	FsFlWf5bdwvotfSAZizhxWUazokDh720lh2f0/07iRzQsqlU+ikJYHcn3nxQ0SN8gFqiam1GTQUnZ
	zUE2wRlRSERczJnPwrgzzVNjCK9NdXxVwrA1zsE7gLmKpVAegUgTPdWRL1fe/IR5msFQCA2hPQ3tS
	xgxF0NehTUKKRGX1TxcYFh6tNO2fT1hlDc7uFog1PYGV0W1wgdHbiOueTytZu6pYM8i+jro64Fv/D
	a3xDUomg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIeA-00000008dC4-2HAl;
	Wed, 11 Sep 2024 08:24:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIYr-00000008bb6-0DDg
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 08:18:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66D2B227AB6; Wed, 11 Sep 2024 10:18:46 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv3 08/10] blk-integrity: remove inappropriate limit
 checks
Message-ID: <20240911081846.GB7372@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-9-kbusch@meta.com> <20240910154526.GH23805@lst.de> <ZuBx9blCTUvsS6yq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuBx9blCTUvsS6yq@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_011849_253491_76EF8838 
X-CRM114-Status: GOOD (  15.22  )
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

On Tue, Sep 10, 2024 at 10:21:09AM -0600, Keith Busch wrote:
> I was hoping to not introduce another queue limit for the metadata
> virt_boundary_mask. We could remove the virt_boundary from the NVMe PCI
> driver if it supports SGL's and then we're fine. But we're commiting to
> that data format for all IO even if PRP might have been more efficient.
> That might be alright, though.

The real question is if we actually want that.  If we want to take
fully advantage of the new dma mapping API that Leon is proposing we'd
need to impose a similar limit.  And a lot of these super tiny SGL
segments probably aren't very efficient to start with.  Something that
bounce buffers a page worth of PI tuples might end up beeing more
efficient in the end.

