Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F47AC369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+AJtABvgFwXzYTxi5z5tHd7Yx6+/IBejIizWd/FsJU=; b=sy3wQwTWwRCoGKR2Hv2IcPuOW7
	S8QQcA1uS4zFRF/pANSR3lsCMw3OmgTlRf9bGhDWgYnsPk88uqkJg6M3a0jLVT2Lp/YuGSwxKN6cI
	yfWb1FryAqrqXTxizo0DVCsk0a0qyCvQ/x5iMH5X0hrg+9Kt0MoLpD0zTnYTGFKgikrtI7QOvXCvq
	Pmbgf/3hlxP7ovdyx1M7l+t6dgcjwVGJMHJuCAQR/X6GTaTFhVEY+A64xN4gnAJdVOriNvjDxdNP3
	0L1l3GYzPtEWI097MruYmSf4BCmurdFFnerQTKahC16ZFzGumc0XxIqZH2+5kIwlkFQOL1QxRpRJU
	f18ERorg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7AIL-00000006dFh-3xEJ;
	Tue, 22 Apr 2025 09:52:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78oC-00000006GNN-48JV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 08:16:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E39A68AA6; Tue, 22 Apr 2025 10:16:44 +0200 (CEST)
Date: Tue, 22 Apr 2025 10:16:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@sigma-star.at>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, kch@nvidia.com,
	sagi@grimberg.me, hch@lst.de, upstream+nvme@sigma-star.at,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
Message-ID: <20250422081644.GB411@lst.de>
References: <20250418090834.2755289-1-richard@nod.at> <0e61c6e9-10bc-4272-b446-31e0d67547ce@kernel.org> <8418057.aG60p0z9Xu@anvil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8418057.aG60p0z9Xu@anvil>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_011649_166125_F0FE1EB2 
X-CRM114-Status: GOOD (  15.03  )
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

On Fri, Apr 18, 2025 at 11:56:30AM +0200, Richard Weinberger wrote:
> TBH, I'm not sure whether it makes actually sense for the bdev case to make
> blksize_shift configurable.

> It's also worth discussing whether we should limit blksize_shift to a specific
> range. Right now, any shift is accepted, and it is up to the user to
> use a sane value.

It should have a hard lower bound of 512 bytes (9) and for direct I/O and
the bdev backend the reported dio alignment.

The upper bound is capped by the nvme_lbaf field being a 8-bit value on
the wire, no real need to require anything lower than that probably.


