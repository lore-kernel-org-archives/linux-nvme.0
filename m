Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9164CC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVJqwUO6mlTibnXelYL4GUzLCW4OzKE3tHs2E+LdCmw=; b=PMLyP8PCkpaPbpSjQWYf+E+nWM
	I6BRFqbyPFg9/jUar9shaL6Xr8vh1v+qiTTuhiX0lFSkq0X0YvUya6eZwee9FCYDV+3h10A5Hat2Y
	r7ROnDMGtcAvVP0wogMDZrDSdzaZHbhIECeyQJWsvUVE3D500dlA/ylGuRDK32kdtlwQR0cGry7sp
	GZk5phV4qNHtgLG9zvYCpUJCZjpmlqHY/gW3MazV0V/unDmBl8+IcJRgDn3x90M59pfoLUwgov0i2
	GbNNv5bGNyZtWQUAHY/jQUmJion9D/4yGUvTZwtQTYP2TVmsce/HCU3Nk17gYu0Ii1h+EnCJsVT8e
	ap2RAbAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4vi-00000001Mwm-3BN5;
	Thu, 08 May 2025 17:21:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD3t2-00000001Fhl-30T7
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 16:14:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E33C5A4DF7A;
	Thu,  8 May 2025 16:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42227C4CEE7;
	Thu,  8 May 2025 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746720855;
	bh=MtFzcLugXYZj1qlG+xp9Qx0bVPoSmqXuvhOtHbpexEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOBWKKA94rcufDELYCdIUo3YjCWatG80OkgzrT4EN21y4cw9MUOk/1xP2mVPSNMNR
	 mw8zfG/1rZVmNKloFLEQ6FOpPDY2Gjtp935DqVD/qbgQkP4tc0IWhMWGrbJX3KBbqv
	 wFjWc425maSGgGn2Q7C6IM4/h0lEu/MbZmfESXinBWUAeF6e8sZe7WDIFxAGTYIdWZ
	 3AuRa+Uw1keNt2kM4MOfexXfUaUGMZQZ7R7XpX5ZiemrOHgCwt3aoo+YS2wX1zUJcS
	 YQQcYKi3hegvRa6Mk/lT/3O270BkVVwQ/03vCjGLkjJSxWvwHFzIm70uqbH0TZPYNv
	 k7ts3i6LstiBA==
Date: Thu, 8 May 2025 10:14:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <aBzYVf3qZkzgFAgy@kbusch-mbp>
References: <20250507191424.2436350-1-kbusch@meta.com>
 <20250508051233.GA27118@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508051233.GA27118@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_091416_821494_2C4D5D2E 
X-CRM114-Status: GOOD (  19.48  )
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

On Thu, May 08, 2025 at 07:12:33AM +0200, Christoph Hellwig wrote:
> > allocated and attached to the bio entirely. We only want to suppress the
> > protection checks on the device and host, but we still need the buffer.
> > 
> > Otherwise, reads and writes will just get IO errors and this nvme warning:
> 
> But to a point - the metadata buffer is only required for non-PI
> metadata.  I think from looking at the code that is exactly what
> this patch does, but the commit log sounds different.

Not exactly. If anyone's intention was to use this specifically to force
nvme pract for those special PI formats, then this patch would change
that. The driver would just get an unchecked metadata buffer instead.

This is more about just preventing the kernel from sending a request
that the driver is going to reject. Like if someone mistakenly messes
with these attributes on formats where PRACT doesn't work.

One use case is like when the kernel started supporting PI offsets
(~6.8?), and that broke the upgrade path since previously written data
wouldn't pass the newly enforced checksum on reads, so we need ways to
disable the checks.

But since you mention it, maybe someone does want to force PRACT on the
generic read/write path? I considered it a fallback when the kernel
doesn't have CONFIG_BLK_DEV_INTEGRITY, but we could control it at
runtime through these attributes too. It would just need a new flag in
the blk_integrity profile to say if format supports controller-side
strip/generation and use that to decide if we need to attach an
unchecked integrity payload or not.

