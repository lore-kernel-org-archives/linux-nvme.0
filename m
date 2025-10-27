Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46188CCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzT5f2l8P9H5bKPkTiXkFBlilFdsHX8kXjFws4YrFVg=; b=Y6HpMpFKnNB6NcW0CJBPBc9mu7
	zcjQO23dxKL7VR4NpKCE6qxWheD20i+dqhQVbhgYj68wbFdhmkfMW6tzircwpzluiBURGfFbXCXbE
	p9Dn9W/pqqlexZJnQ2WHcwRshZeDtPJR7ziOnmhJ/OgFAWrnXH9BZarVk1rTzD8Q32LNb4cn2tJO1
	wIUEuudGkrNc3XbEt8IaKvq0HzVaq17YZSEGjgzM+NRv3rv/oASgFrrzirxXwDQ632f/jqmeYiWmc
	FgDsE+7dCv2yZ52nvKU4dysZiPH3F0UNn3tBr0cLb2VsrvpdSU1u+sgWWHvXL8ntKRrhXh9MvtbgT
	u/tllJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDH2r-0000000DDoO-1Vd4;
	Mon, 27 Oct 2025 06:49:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDH2o-0000000DDo1-45wH
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 06:49:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4660C227A87; Mon, 27 Oct 2025 07:49:26 +0100 (CET)
Date: Mon, 27 Oct 2025 07:49:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251027064926.GA13214@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com> <20251022061418.GC4317@lst.de> <20251026123804.GD12554@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026123804.GD12554@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_234931_162206_7B083C14 
X-CRM114-Status: GOOD (  18.15  )
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

On Sun, Oct 26, 2025 at 02:38:04PM +0200, Leon Romanovsky wrote:
> On Wed, Oct 22, 2025 at 08:14:18AM +0200, Christoph Hellwig wrote:
> > This actually has block and nvme bits, so the subject line should
> > say that.
> > 
> > > +	unsigned int attrs = 0;
> > 
> > attrs is always zero here, no need to start passing it for the
> > map_phys conversion alone.
> > 
> > > +	unsigned int attrs = 0;
> > 
> > Same here.
> 
> It gave me more clean second patch where I only added new attribute, but
> if it doesn't look right to you, let's change.

The usual rule is do one thing at a time.  There might be an occasinal
slight bend of the rule to make life easier, but I don't think that
really fits here.

