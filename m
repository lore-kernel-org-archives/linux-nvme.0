Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F45F8E4B9
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UytH5tAJsEIjaXQrE7tY/x/ePNOuWpLJf1TbfH1XVCY=; b=ujWJsz4QHclHHPXyfTK9uBy9MK
	1T5F7dLmnhhqnm6vO8YHN/zMI8ZUDmNGNHMIcAXDoSxZB3+ZWxaG+wNA/qMwFl5ojo00nLKjAxSoB
	wByAJ48l084MQB5ledSsQXywfHt+advYxR1CnpwONQlC+S2+Mm4xjuKLnOCi591F8x1yhE8TjJCst
	SeXjSmvd0k2TBFMDHc3fMIE1VFd3wcs7rJEXFjREl8LGQ7DpUYo2qp3hyGRrbbKmrIV+DLUSbUNeD
	gbBmERYVoqrTNFli18/6Ql7nz+buL4w8McXnH4Elkxqr6L4Yn1SH5JM9CPAfNEAzR9oCN7pT6c0r7
	UuIO7SGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe0d-00000003cxB-3noR;
	Fri, 17 Apr 2026 07:53:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe0Z-00000003cvT-36Wt
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 07:53:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D61F68C7B; Fri, 17 Apr 2026 09:52:50 +0200 (CEST)
Date: Fri, 17 Apr 2026 09:52:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V3 1/3] block: clear BLK_FEAT_PCI_P2PDMA in
 blk_stack_limits() for non-supporting devices
Message-ID: <20260417075249.GA31524@lst.de>
References: <20260416212633.72650-1-kch@nvidia.com> <20260416212633.72650-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416212633.72650-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_005259_927229_BE5D8EF5 
X-CRM114-Status: GOOD (  11.45  )
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

On Thu, Apr 16, 2026 at 02:26:31PM -0700, Chaitanya Kulkarni wrote:
> BLK_FEAT_NOWAIT and BLK_FEAT_POLL are cleared in blk_stack_limits()
> when an underlying device does not support them.  Apply the same
> treatment to BLK_FEAT_PCI_P2PDMA: stacking drivers set it
> unconditionally and rely on the core to clear it whenever a
> non-supporting member device is stacked.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


