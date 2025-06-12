Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E991CC71136
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/VQtoCGVchzjX8gzMOikbPguye0oL8wbk9HW8yzTvg=; b=t61Slf49IuLfvsoI7vICPQnemr
	l0TzuEcXQI4BxNvop7GJCvyFJuIix1QO8WBUpKoiZm7UJtMQDJlaLvCS7nD8ImI5+0ZqpGWTRJTyJ
	1GqDciIWgx79Bt7Qmh0Vao9mt0Hj2sraFUppu3eDUtGJv5mMxL/bAVO+y7NX5i3Xfsl6s7kJFdFhz
	1g/bH7UII0jAV2u3hr8bEJdX44fN+EQv4RwraX0OXGs6cYD6jvZmI4QTecDtbogLPeVxmSGFtli7a
	RAFnoxz+PfbohUJUa/jNJ4+zN8fCSvMgjSLaLr16ELyN9KuAYmzggyQc+f9ZqRz5eXAcKvupf0H3u
	Vvw0dBtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa3I-0000000CBbe-1nVv;
	Thu, 12 Jun 2025 05:00:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa3E-0000000CBaU-24Vm
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 540AB68D0D; Thu, 12 Jun 2025 07:00:28 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:00:27 +0200
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
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250612050027.GE12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-5-hch@lst.de> <aEnsLRDcZ-ykBsVX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnsLRDcZ-ykBsVX@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220032_669428_22CCF261 
X-CRM114-Status: GOOD (  11.42  )
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

On Wed, Jun 11, 2025 at 02:50:53PM -0600, Keith Busch wrote:
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> > +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) < sgl_threshold)))
> 
> This looks backwards for deciding to use sgls in the non-forced case.
> Shouldn't it be:
> 
> 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
> 
> ?

Yes.


