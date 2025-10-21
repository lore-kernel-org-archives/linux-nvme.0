Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20200CCD1A7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ID4Y7chJRkJOylkEEWjzAF4aEtssmmVwKo3hasL3cdU=; b=YPmS7wxbInuiWE/oCnBwDP7sIE
	e7drzgjyoN6plMsKUQKIw+p8wZBxdgpFdVsUKJKwCICmEfkYaOmSexr6NPxuIwkwz17XYVuXYqf2s
	iQZiwNQlfnJe5DnqfikGWMk7qK30LcjN6BsXPHpkzraqFne6H+j4GvbvRyaMWT9BrEPvT4QUbEp0z
	qQAJLhzfj+jo/8aRGQMWbfBrPrXBJgNKt1kutYAhhU/uQTl5jojiloxEm/QhWNlRjc3ciEOxBzkpd
	9CTnLp/UHQ5NBtwMx3HpawEuLrikkiFWEoJLMjSHhdKofNtAa/XhRpL1Iksf4gDnbe61HyNjXt3D0
	xasyCfAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBDYx-0000000HMQg-2WfK;
	Tue, 21 Oct 2025 14:42:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBDYv-0000000HMPy-3NOA
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 14:42:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 22CB5404EB;
	Tue, 21 Oct 2025 14:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA8FC4CEF1;
	Tue, 21 Oct 2025 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761057729;
	bh=VML/zAl9UGmZS9tFnKtgYnIwGOP+iyxruYi6hhWxkYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOAk7Jgo3sZ16bWrrRxYJAUsmClHxq2D2gM/ahlqhDIrbnKEl52bkIKkgPCqCLgEs
	 Iz9L+7IhMMvUdkGcYjx554wp1g/ulZxLQGO75MBp1o/lshVpiSFrOw+qcRWCKygOna
	 xKF0xZDcJv0slDJVvjcwKY5HVbDrsSQhfvnUjaov8RtDEu2EcjgrKczxrzr8uQYyDJ
	 zcVel7pbK1Sd2sp0WHDlCHuYcFzjL8z+mHDdRNd6jWOHOQ+ZWs1XU6fFbFKuOyqNGU
	 Ip93PuhC/iX+HcLnPYCLIPvmi2LZzHFARyEz+pcegKlGRAfdZhDC6X1T8UlrYHvqUm
	 4ZIstUTy0zDPw==
Date: Tue, 21 Oct 2025 08:42:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Message-ID: <aPebvnv3u6HWcqdX@kbusch-mbp>
References: <20251020182444.2587155-1-kbusch@meta.com>
 <20251021071935.GA31479@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021071935.GA31479@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_074209_880558_A7DB20F8 
X-CRM114-Status: GOOD (  16.81  )
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

On Tue, Oct 21, 2025 at 09:19:35AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 11:24:44AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The dma_map_bvec helper doesn't work for p2p data. Rather than special
> > case it, just use the same mapping logic so that the driver doesn't need
> > to consider memory types.
> 
> We already consider the memory types for the data path, so treating the
> metadasta path where p2p is even more unlikely sounds like the wrong
> tradeoff.  

Maybe the data path should only use blk_dma_iter too. Is dma_map_bvec
that much faster for the single vector case? I'm going to test both on
real hardware and see if there's a difference in CPU utilization or
latency.

> If we have a single segment we just need a single
> is_pci_p2pdma_page check to skip direct mapping path.  Something like
> this untested patch:

The logic you used isn't accurate, but I know what you mean. I'll spin a
more minimal v2 patch.

