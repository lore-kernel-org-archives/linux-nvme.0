Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F2E8784C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L4Ug0cAePU3x0Zr6iQgRD8ks/VuRJj0QWJMbmRydpQ8=; b=X5wxI3C87O0vCdUYuEA6i3qNSf
	zkeH6xge1kBjWgwW+s1cR9rtFJx8q6fB/3lY0iB6KXsSYU66+OE2IhXTpULnn2H3tkc+NYBjUWkaM
	R32A0HeRfJB4yEIModN5ehuqkqH5GDEIreg79MNQhoCIALofYEgprqxnBaiCyDu/rl284UHTLuOOK
	xhzki0RL9kwvhZkaFZsGGRslEU31ynPTNzrwQNzWjTMp3mf6GaNGy8iL7Y/+rNxH43QM3Eec+Inb+
	EY+4dwNqQVOgb4AVzJLuqc1UW4znYqrzBEEeqyg4jWRPrJRFx27ZH1djPNxMZRcPSWhtc78gyR65E
	2aJNeRSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKPZ-000000074FL-0PB6;
	Tue, 03 Feb 2026 17:42:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKPX-000000074F3-3eXw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 17:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E147E60143;
	Tue,  3 Feb 2026 17:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19419C116D0;
	Tue,  3 Feb 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770140518;
	bh=mYLo//Hf0CdyWj2A1kskOpG25ECJq6tKQxdW6rNvCCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D23R1mDa/GjuoXb6uTeAAz2a0WvE8SWNBDNO7798zfXfJN7iyTkvb3YApqHUZKxDc
	 IH/fcovTehSI1QgjlrY4WHcYfe5eglEWxtfftwluwDDjp9coRh04dogFpvpi8m9O6X
	 4roQZ250pq8x7lIjCYrdFC3IpGIrCJV+izSpnkUeEF0xdcbF2oHW9D1jfpCHiyX5Sf
	 fn/E1of84rjdocSGN+Ulj4i8y+8iqj8T8W8x3XpZkBrgF4onv8w27LvJc6dQcrSo1v
	 K3knVTr2+m/2+88CtqS9YwuL1rTPS/iIgeq1V7pP62Yj7/ubpCZ97Uet6gBR94Vmtw
	 JUFHJActlZBKA==
Date: Tue, 3 Feb 2026 10:41:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYIzZNdjWOlJ_Oao@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203094247.GP34749@unreal>
 <4e375e54-e141-473c-ae71-fc013268d057@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e375e54-e141-473c-ae71-fc013268d057@arm.com>
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

On Tue, Feb 03, 2026 at 01:50:12PM +0000, Robin Murphy wrote:
> > Can dev->dma_skip_sync be modified in parallel with this check?
> > If so, dma_need_unmap() may return different results depending on the
> > time at which it is invoked.
> 
> It can if another thread is making mappings in parallel, however as things
> currently stand that would only lead to the current thread thinking it must
> save the unmap state for the mappings it's already made even if it
> technically didn't need to.
> 
> In principle it could also change back the other way if another thread reset
> the device's DMA mask, but doing that with active mappings would
> fundamentally break things in regard to the dma_skip_sync mechanism anyway.

We can handle a change in dma_needs_unmap() from false -> true. Worst
case scenario is we save off a descriptor when we didn't really need to,
but it's just a small memory use for the lifetime of the IO.

We don't correctly handle a transition from true -> false, though. We'd
currently leak memory if that happened. It sounds like that transition
is broken for other reasons too, so I won't bother trying to handle it.

