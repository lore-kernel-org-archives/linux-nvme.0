Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFCBC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2v69k0FpZXRJWU7maPS7pZn9/dJbmF2mczIG+UyctyE=; b=YwRZ8J8BbgmaJtxxF4Xdro+XpG
	uf0WD9qhz9Nw2UEPh9fL1hSkcfLTMdUJnpq7qOlHJ/sP4moUF4zjw9qZ0nmuWNQhXlSEm08A+MVLs
	bMmbPTxbQi52pR8jBwe/CfnIknU4usGSs5pGhTay4k5GkekKyBZjO0PEeXv0rEN4yGzPiY0Is393a
	8maePIlXSYqbnyk0GIqqd8SOJGUsI7TX67HnYoqN0y0utgJ1rINAbHg8pgmcB7C3vl8Jaz+i2x0e0
	SyX1eFMHLj8i/nnlCN4QhRcHlBoldADeRO0m6OK4DMf6sUnnirjs3hVBM/2BPwVcnC0oAWKJ1YXrX
	ja5iO2jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdABD-00000007HYS-0pzt;
	Wed, 29 Jan 2025 15:40:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdAB9-00000007HXe-2Iq3
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 15:40:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E53E268D07; Wed, 29 Jan 2025 16:40:25 +0100 (CET)
Date: Wed, 29 Jan 2025 16:40:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk, hch@lst.de,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250129154025.GA7047@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <Z5pJGHAR7AWCC0T4@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5pJGHAR7AWCC0T4@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_074035_725792_E0A6498D 
X-CRM114-Status: GOOD (  18.45  )
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

On Wed, Jan 29, 2025 at 08:28:24AM -0700, Keith Busch wrote:
> On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> > There is value in avoiding Copy-on-write (COW) checksum tree on
> > a device that can anyway store checksums inline (as part of PI).
> > This would eliminate extra checksum writes/reads, making I/O
> > more CPU-efficient.
> 
> Another potential benefit: if the device does the checksum, then I think
> btrfs could avoid the stable page writeback overhead and let the
> contents be changable all the way until it goes out on the wire.

If the device generates the checksum (aka DIF insert) that problem goes
away.  But we also lose integrity protection over the wire, which would
be unfortunate.

If you feed the checksum / guard tag from the kernel we still have the
same problem.  A while ago I did a prototype where we'd bubble up to the
fs that we had guard tag error vs just the non-specific "protection
error" and the file system would then retry after copying.  This was
pretty sketchy as the error handling blew up frequently and at least my
version would only work for synchronous I/O and not with aio / io_uring
due to the missing MM context.  But if someone has enough spare cycles
that could be something interesting to look into again.

