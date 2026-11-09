Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EE606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CqdGH8fM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU0HHyi6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RVDPfH3Ode68kwTp62yVfBJGx284cqqREueZ0mgCu50=; b=CqdGH8fMH2KHPesNjL+qFn6ZZ9
	Nk9CDvVcp4UyK2+vJHvGyErxl8UkCyMbf0+bxAiHN6mxL7NetlDfv2659PgV83o3b7qjBMK4XWZKI
	H72AxHflrsKXgOTyAtCt0iAknjBrKwYLoNB8UAKqzYPXwj3hLoWkNmBWfPHIKcDgJ9gpnVTgTcaLr
	RbLWZbF7+Pp8BgRzBXZDmo5n+7+Ci582xhJh7386tET40SqGbTN7gJa/FSF4nXGptmtaNNpk7/wEf
	oJVNaiyosWUI8fpYJDHLFHls6/Nhbg8EWQgKyqZnSBYpW1nHo11wYJZETx4YT93SiHMeZFE3lUDJp
	NjnhnMgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQS0Z-00000001AJY-1DTQ;
	Mon, 09 Nov 2026 16:14:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQS0T-00000001AIb-3Ysb
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 16:14:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 509D463435;
	Mon,  9 Nov 2026 16:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9746D1F0089F;
	Mon,  9 Nov 2026 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240844;
	bh=RVDPfH3Ode68kwTp62yVfBJGx284cqqREueZ0mgCu50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CU0HHyi6GMM0L8nyluZV31Up/1fO8WvY61hhbWIWblXQ6zr8pk/yOozZcSXF9s2Gw
	 1fauQG1x4ePXkriBbjDZLb/rqDVSXPBitEc9itwk+kW3/axxwoNaMCRSldfXqsJkYG
	 jBgxlgMEyAn95SLNLswBBHApMidahSZfI/7PaK4OiFmX+cm+zSVa0umITM5ika8OLI
	 QqZwnsjV8at35PqqbshP2ezYXC2FhiNk/Ho3iw4CQO27i4jpTTi6M/nSHjGebATqJy
	 Pg5cEEYhfhEPLK3/dc0C4O1i5oikUOhNadoofQsc4uBetL6GdsfBo3O/6CanwLLU0M
	 wA+Cmen/Ci4tw==
Date: Mon, 9 Nov 2026 09:14:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
	lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
	namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Message-ID: <avHxSog2_rsJKGUy@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
 <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp>
 <87o6c0wbo4.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6c0wbo4.ffs@fw13>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 10:53:47PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
> > This is done on purpose: pci_msix_write_vector_ctrl() already has the
> > same offline check, so nothing actually gets written, same as before.
> >
> > And regardless of whether it's offline or not, we have to set the
> > PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
> > both paths, so it lives in the noflush helper to avoid duplicating it.
> 
> Indeed, but that's an unreadable mess TBH.

No disagreement there! I was just going for a minimal diff, but we can
refactor a bit on the way. I'll take a stab at it.

I also don't really get the rationale for putting the check in
write_vector. The commit message says the checks are to avoid having to
deal with errors, but posted writes don't produce errors, so not sure
what it's actually guarding against.

> Can we please change that to have two functions here?
> 
>     pci_msix_write_vector_ctrl()
> plus    
>     pci_msix_write_vector_ctrl_and_flush()
> 
> and fixup the related call sites?

