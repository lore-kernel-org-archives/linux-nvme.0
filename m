Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468EBC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BLYDxeuoUUPufdnI7fDG+mz9Lk0Bi+/47GDCucz7eg4=; b=Lhg85UINEVETlUlpcO1CKMpPg/
	YgJd5PbfHzS/Fez9DnSVZp/x329T7yImJcu8gnKCzcZu61i9Cuw3mIkOS5gJ6rqIi12XoX0CA36SM
	HtZaxFxheppDdA24hYAMJICFqM++yTcmvMZ43HkG33x8LI8Q2Ul1Ei56GChnzzhP8xa3nJowBI0uM
	q5tbAm14LFJyZwmEOYK2Ij85iK/DGYBcHqNNJ2PIPYoOiYa0qmKn43CexHid+Gw9oDMPxX4aB/87H
	ksjMYq5R6P/FenC3VvXgznHuhoHrR2SaRQRw9RVJLIhIrSp9g8VhhiGIlt7bnFAB5Yb+j9CgveQn9
	J72bqMyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh33-0000000FOWc-38vL;
	Mon, 24 Feb 2025 22:35:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh31-0000000FOVz-458A
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:35:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA7D068C4E; Mon, 24 Feb 2025 23:35:31 +0100 (CET)
Date: Mon, 24 Feb 2025 23:35:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/6] nvme-ioctl: combine alloc and map
Message-ID: <20250224223531.GD15518@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_143536_148364_4AD57E4D 
X-CRM114-Status: GOOD (  12.12  )
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

On Mon, Feb 24, 2025 at 10:21:27AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The same pattern repeats, so combine it. Also, the existing mapping
> leaks a request if a user requests to map a vectored fixed buffer, or
> unsupportable metadata formts, so these get fixed here too.

That fix should probably be a separate backportable patch at the
beginning of the series.

Otherwise looks sane.

