Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7322DC83F17
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BvCY+Z8BLwEZMtGNSXwASf9WcyyBOM1Esnjq5QLJ2NE=; b=wiR4lMxLAYESpkTKLKTPFBI41l
	pquMv54V+ZjSefFTcTxNbM7NquVnQjQhp98GFdQJRUu0kodlYq4zPGB7zoqj2Xh/0hbqxd4hTz8gR
	UY8yLo7DUV43pDEp8yo+sJc5mEju+QhRg2fG4HdJwgEKNLAYC69dPHRQXcOoHjGVCH+MQLGeHJziF
	NA1NgvricowfiTyDXQC3x0WaD8v6ZOihDA6a/eomsuU8zW4aCL3OEDgfi/coY8hcbzLxJ9/JLQcN/
	2k9qcxIMSqhIIXOPHfnr5JTemwRz5PPpBhuZcKrHpkAOebgwmvWPTR+++4BxEZztGZr9g+xyjK1+I
	ybSFgJbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua2Rq-0000000DSf6-1dmt;
	Fri, 11 Jul 2025 01:21:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua1lC-0000000DMwa-1mzG
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 00:37:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C213444C57;
	Fri, 11 Jul 2025 00:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37622C4CEE3;
	Fri, 11 Jul 2025 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194225;
	bh=7u5+cf2nJZoDvmfkGRcyh5Fe4HAs8tplHaitTwUCHWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sqm12vd9TY/Nk7pcL72xtGHsxJB2aGz4GX4/Iy7SCuXKfdNSIeMpjgT3p2SJAHMD7
	 jRJT1IWcHOYotojPgRMOhsQbiwVP33H7vUwcKMslz51Z3cLD8ylN4aA2pwq6cqzpZr
	 M4HeN/UPTISa4xw//cuSX1IENDvGQ8OY6c1RdOgZ+AWM0Y1r3+i78mXfQBr9yaQMTU
	 fw3PH0ByiCTkJZL6xvafI0/Zyl3fKDdoAbTSPctw4If+pFHGxiVbGee9KWaKlXo0e1
	 6VJ13eKdGROA34cUpAhBBt4Xb9B9arIUfdrGYEUHeN7vBg8FpZ16qSu90MW+jINSoE
	 2nK05e6x/oz2g==
Date: Thu, 10 Jul 2025 18:37:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aHBcr3Nw5UWrYy1B@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
 <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_173706_482760_54AD7F64 
X-CRM114-Status: GOOD (  11.16  )
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

On Fri, Jul 11, 2025 at 02:25:12AM +0200, Klara Modin wrote:
> This patch seems to introduce a memory leak, causing the slab to grow
> continuously. The easiest way I found to trigger it is along the lines
> of
> 
> # dd if=/dev/nvme0n1 of=/dev/null bs=8M

Doh! Thank you for the report, I appreciate notification for regressions
on the -next branches. I'll look into it tomorrow if hch doesn't beat me
to it.

