Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9208C71136
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDDA5FvSCm7ilPDI229CmGsPWyytmtHeXynqQJcfKcA=; b=Nj9IKSKoOlb4KPyfeKfJMGOOfQ
	1HJCq0rLlZT88UaJLvjCSeubHLfrfra0XcUJ2OsOBEtPkr/NPqiQI7pTzoLMzogELzqNPi1q//Y01
	D2CPYGuiPBCw2xd7kLu41pz/eO5yQWcYGFJyF+tF1bANhiXCcDGXnhdiqOXlbGmD9Xwd5SCQ6aMAz
	mX4YXh5CWTFpKZ91W8e9Easj7zkDXaPgd88qcEaWq5Xycdi+v56OQ4ox4z8pIVYewmQMQoPB1mL2l
	SohXbXsKLpfeRZx8xA3t9WW0tDZyw0XVkEJ4TosVugOfXvCAIT/PeSUj/4jrk/wCjjdhophCwYmyE
	OlGkF8RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa69-0000000CCM9-0KLv;
	Thu, 12 Jun 2025 05:03:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa66-0000000CCLa-2VDd
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:03:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E66068D09; Thu, 12 Jun 2025 07:03:27 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:03:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250612050326.GI12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220330_774877_9181124F 
X-CRM114-Status: GOOD (  13.57  )
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

On Wed, Jun 11, 2025 at 04:13:22PM +0200, Daniel Gomez wrote:
> > @@ -2908,26 +3018,14 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
> >  static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
> 
> Since this pool is now used exclusively for metadata, it makes sense to update
> the function name accordingly:

Nah.  It should go away entirely pretty soon, so let's keep the churn
down.


