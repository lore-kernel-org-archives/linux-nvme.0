Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DEC87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XV67guEa/FnZKChSSVXPJpMRHMDf6Gpe9gXqv2CG5Ng=; b=RCyfIDokGdplMBXdgHWB3fnXY7
	2I/tGz5nQ4JiR+Gz95aXySr4QugQt+Hw3wRL6XbSA3YfJa7zBbtSpcyZsk2M0UG/MraoPW/gRITf2
	WFSDQJ54AAXJl36g6/5t3ai/dvMmHcQzsboc6oZx2HpK2eJ/goirVANuIsnPW+c0bhftFWyLCYtZs
	d56NERAfwyXeRj6t4Ur52APfRAg/fXRPAv80K9etGpWeBnCExv1U0BaIBk6jYohwE7n7hL/SaJaML
	YqtuSd91iDDpmheNOJvgiGckp5kiuat4SgABlQkd+VIUJ8rG2nkCy3kbU0Lom8jn3BrcHI38pZtnY
	CEEPaASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSeK-00000007peS-0pi5;
	Mon, 11 Aug 2025 13:33:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSc4-00000007pWq-0Mz8
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 13:30:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BB8360051;
	Mon, 11 Aug 2025 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B2C4CEED;
	Mon, 11 Aug 2025 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919055;
	bh=wZjCh8XlQL32DPQm8fd7YqWZa/4AL5hrwFmnrWSDD78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZJra/xFTZZUYA2ye35yT03O3yRf7zdbDk/qD0SUM10HA/zsiMhXFXL+GmwH0xUWC
	 nUX94uoMGxW7dw+UefsARCMkdmxgpaw/b92IlU6bbVlPm3VIE9VMao1Dzwf1iMh2tI
	 UWs4KBLOOHZyVjAbHjrdHZNihbkFMV4bv2W0eZiswFxD1P9fOJY+7inG0FJW92ncdR
	 n1CJeXqVNldYBJwfEqK8SolLz8A0M/cfdXUMVt62b+o/IOOGNLrSEamrv2ydlh1KWT
	 QSChZwmrAODvtk2q0WZ/xSEkpct8bsxJpdwlAf2PBD5Yt1U6I4G4mEgUsqyPiGzTsF
	 Mbe6QbADDF9Og==
Date: Mon, 11 Aug 2025 07:30:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	joshi.k@samsung.com
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <aJnwjVm7tTJwoQhj@kbusch-mbp>
References: <20250808155826.1864803-1-kbusch@meta.com>
 <20250808155826.1864803-2-kbusch@meta.com>
 <20250810140448.GA4262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810140448.GA4262@lst.de>
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

On Sun, Aug 10, 2025 at 04:04:48PM +0200, Christoph Hellwig wrote:
> > +struct blk_map_iter {
> > +	phys_addr_t			paddr;
> > +	u32				len;
> > +	struct bvec_iter		iter;
> > +	struct bio			*bio;
> > +};
> 
> This now mixes the output previous in the phys_vec, and instead
> of keeping it private to the implementation exposes it to all the
> callers.  I could not find an explanation in the commit log, nor
> something that makes use of it later in the series.
> 
> If possible I'd like to keep these separate and the output isolated
> in blk-mq-dma.c.  But if there's a good reason to merge them, please
> add it to the commit log, and also clearly document the usage of the
> fields in the (public) structure.  Especially the len member could
> very easily confuse.

Perhaps I misunderstood the assignment:

  https://lore.kernel.org/linux-block/20250722055339.GB13634@lst.de/

I thought you were saying you wanted the lower (bvec pages -> phys
addrs) and upper part (phys -> dma) available as an API rather than
keeping the lower part private to blk-dma. This patch helps move towards
that, and in the next patch provides a common place to stash the bvec
array that's being iterated.

