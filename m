Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A63C87FCF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dNYBDORkQUOO1Xb7tAruxHDu9vOrcUMsgGC5uMg1D28=; b=kkevhgkTNbu8Q3t0eZEe1oqTb7
	xHvq84Em61QHplXwNFUC0XEUpLRAMMIJc2Z5pL2WpXZcWIjlzgrner9q1X3TJxiVi9TBjncX3Uy/q
	kF50z+uwsrrFLFGdpXww3TSwMrv3HOsT5QHasinpwF+y2rbDa6a68xNdnUHrqir9nxS180a3/x+IG
	Rke8HujpFtZXjQfIDUtu1SFDiJzOnQ9rJ811/Ld0PYvL8tbQQ4oeUFccnDmXv5ftVci1MuYjSbeiB
	gXIHrNqgb2JFuAigPqUWLwVaODhDpLRbgfGy4qzwSyUvTNYr3f3/yEplVA5sTs+CebSJDLveUDT1N
	gv/szSyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6ie-00000005fgs-4BXu;
	Sun, 10 Aug 2025 14:08:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6ic-00000005fgC-10PR
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:08:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E258168BEB; Sun, 10 Aug 2025 16:08:10 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:08:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 3/8] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250810140810.GC4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_070814_419354_B0E5AA0B 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

On Fri, Aug 08, 2025 at 08:58:21AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In preparing for integrity dma mappings, we can't rely on the request
> flag because data and metadata may have different mapping types.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


