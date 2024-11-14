Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713BED68B38
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+VAMTocin9VVuS4dIQtEJ7svLpRdLRVIZb2WTHyhR0=; b=Qv4cGJPWKchbNtDlIg/3u9HCWn
	QuHAXaEDz4+djDUmmrfTcq70jDRfM3/CZaPTUeTh2LAtdaaCvKn6gNNOlnZiHLq+2x2Buc0xtzga7
	sva9OsyBcpDmjJr5HTYmOx+Afjzzpsgyolye6ZiqfDhxKO0nlqlDCxbze1R5eZktV/fdF9Da8ZGWO
	bStrD+SLUyZueIWFIIvxZUP+BpTkrczcCx04YgVQmM3Rm3mKGvHR5+ZDPi4GWs1gFDCUhN5WOjM9p
	bcCKpmif8PoaPMu4Epf23y0bFoWjub63LUS3BR2VlLBHDTrHR9q7HsH7xaW2ZteNQGiZqypmdYbPh
	uu2PYuJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcxk-00000000BZB-2dj3;
	Thu, 14 Nov 2024 16:44:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcvk-00000000Az3-1xUp
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 16:42:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7BD468C7B; Thu, 14 Nov 2024 17:42:45 +0100 (CET)
Date: Thu, 14 Nov 2024 17:42:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <20241114164245.GA4132@lst.de>
References: <20241112210620.2650523-1-kbusch@meta.com> <20241112210620.2650523-3-kbusch@meta.com> <20241113045859.GC20379@lst.de> <ZzTKORM566PReqHI@kbusch-mbp> <20241114055642.GB10948@lst.de> <ZzYdDSNpH99YHJvb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYdDSNpH99YHJvb@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_084252_649542_48E59B1C 
X-CRM114-Status: GOOD (  16.57  )
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

On Thu, Nov 14, 2024 at 08:53:49AM -0700, Keith Busch wrote:
> Only admin users can access this path by default. You have to opt-in for
> it, so it's not exploitable unless you ask for it.

We do allow non-privileged users to send I/O commands and a small
whitelist of admin commands by default, limited by the CSE effects.

> I can't see disabling
> the interface entirely. In a previous version of this patch, I had the
> kernel tainted if you tried to do passthrough without SGL support. Would
> that be a fair compromise if I reintroduce that behavior?

Taint might be a bit too strong, but a one-time message in the log might
be useful.

