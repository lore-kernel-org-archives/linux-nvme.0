Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D8CC77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MC50+L6+4fJPxVmQ41RYVc/zzHXQvOv/aEd/RSWuEIw=; b=dSuEHJ8WhzEnE+wHmdbr65Wb9b
	U10Qz4knllf7YaX63cTy0xPO3bGJDC0kJUe2uGy18aPAQO7urfPoUt2PX7LlpKgIIjLxUaliPFICT
	Gv/VYRSg1vLqiINR2vs7HC5cbtBDkhjlEI0cxkop1IknWdAZPsWtNTaK6xAQfK7vS+rsQ0SACHVn8
	w1ZCJulYYTyYhcgUfZ96i3rTTxawXI737Mn7d2WhCB9vlLHg5gz8lbENAksK3S9iYbKALkMNryNHz
	khCqauvBL/4kGaDCVLLLkTSyZerTXD+YYdTg/so0WAKkDmrjP2Cm/FclSYpbUdpFQUqJ8SIUnbLhO
	bjOKPu8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU32w-00000005chz-35R2;
	Tue, 24 Jun 2025 12:46:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU32t-00000005cdQ-3NZC
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 12:46:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D54268AFE; Tue, 24 Jun 2025 14:46:26 +0200 (CEST)
Date: Tue, 24 Jun 2025 14:46:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250624124625.GA19239@lst.de>
References: <20250623141259.76767-1-hch@lst.de> <20250623141259.76767-4-hch@lst.de> <aFlyYjALviyhQ-IE@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlyYjALviyhQ-IE@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_054639_985524_3956DA11 
X-CRM114-Status: GOOD (  14.81  )
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

On Mon, Jun 23, 2025 at 09:27:30AM -0600, Keith Busch wrote:
> > -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> > +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
> >  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
> 
> We historically interpreted sgl_threshold set to 0 to mean disable SGL
> usage, maybe because the controller is broken or something. It might be
> okay to have 0 mean to not consider segment sizes, but I just wanted to
> point out this is a different interpretation of the user parameter.

This is still a leftover from the threshold mess in the first version.
I'll fix it for the next one.

