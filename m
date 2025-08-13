Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B26CA0EE0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXwn7wxPl044Ucg5ykhpOxKPDKb8EUMyFwm8PmVJ/V0=; b=jx5aD98Xv0O7mYIdHnqEA31d7Y
	ym3dV4qFOZwAhUG2H/myKwAOOnVHaFY6m/TyJPTqZAygEMQK1WQxbBSQbB17fj0+UXfe4IzYAOhi5
	fEJE1p9iB9PcgexzuJz/CG5L4bbp1ZhrAhh2luGI89ygT8JnGYYnax7IcAz+ZT/0QWPjptiMCnlrk
	9aP/EYB7ScqIHCiAFNrPx3Bm38JonCDHh2AJKDDLs+hGdUEkus/Gl6eRhYmuF1dRq1cs5xEVbSE9O
	y0o3xnCJvrIWoWCY7ZLZbinkOb0bWR0VxZ0XkaL9xxZ+13DqLrdPibMJR1qZik5mhcoc0HiQ6M/1u
	Xwf2ZEsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umETM-0000000EQiz-2Rpm;
	Wed, 13 Aug 2025 16:37:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDn0-0000000EGGi-0Tnx
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:53:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC234227AAA; Wed, 13 Aug 2025 17:53:12 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:53:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250813155312.GA14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_085322_293880_F5286555 
X-CRM114-Status: GOOD (  10.67  )
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

On Wed, Aug 13, 2025 at 08:31:47AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In preparing for integrity dma mappings, we can't rely on the request
> flag because data and metadata may have different mapping types.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Didn't I review this already?  Either way:

Reviewed-by: Christoph Hellwig <hch@lst.de>


