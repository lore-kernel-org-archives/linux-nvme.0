Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D0D597A4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+9JSsktWVZqstyIy5I+c8AEuP4HF+gzqcauCSt1o4o=; b=QI9azOZ3pBYbcpxJ7CVr2eh8Nq
	Vxi3Vr86nmW2mgd1CAfealZl7BQdly0GED8jF33LIzRyiJnqeIPS61nAcKtRNZi5SpHYsvnVcKGjL
	Gecup2Ldo7MJWsky0cuhwSwF0Tcz3o5MdpOFtJ6l2nz0foy3W5ixYH8IoOndc6wNzDsTt7C61iOwI
	wGE/sU5811iDvwqXBqjcuWKG+x3zkIVv9u7czexd7tgf6ss/9JS548T8+ZZJVtV1/2P3YaoRkD3KU
	fSyTCwODsDCnQ93tvxG7MCiozmUGXHt/d+rS9LErFlX7fTp5dyfJdH339oetugpWNl5CVve95bPgj
	7EPJguIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxn2-00000004uby-36H5;
	Tue, 12 Nov 2024 20:47:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxmz-00000004uaJ-1j66
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 20:47:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EB8A2A42538;
	Tue, 12 Nov 2024 20:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55918C4CECD;
	Tue, 12 Nov 2024 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731444423;
	bh=cNdLSa1e0i0zJBM5n+pEe+12XHmggYolrYFKZI/3xsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny5bp63sriCqj14P3XlrY0XVodLKFsv6PK6Tv2Of55OHSYDus2vOfad5fihelCBtb
	 0dmzB8g7y6MNMS5443gaCTioao6GjzHxG1h91P1kpsvGvTDL6ei1Hty1C01qeaklQB
	 4/SibMPYNZzjiCaKVkA8sPnckWGZa8T5n/8pmhX/3wU4kPPrrNT5bCUCLzO2K+kJbj
	 OTRRoKUUXM8kY5Joz3ttJelQZsASaSvwZDT8daNp1TkkfUQw0uqguiMlUa6zz6z9Nn
	 gI+rmaINuzSnp+kWvrLdGMZEzP673cIUqO7LQ0lbYDk4sTlBIEq3fjI/XZHQB2z7vN
	 z4EN96gP9ckBg==
Date: Tue, 12 Nov 2024 13:47:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzO-xdUJLA1wSUeu@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_124705_531922_D0DAF231 
X-CRM114-Status: GOOD (  12.29  )
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

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> @@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
> +				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);

This line is overly long and a bit difficult to read that way. I changed
it to this:

---
@@ -2693,15 +2693,20 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)

 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
+       size_t small_align = 256;
+
        dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
                                                NVME_CTRL_PAGE_SIZE,
                                                NVME_CTRL_PAGE_SIZE, 0);
        if (!dev->prp_page_pool)
                return -ENOMEM;

+       if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
+               small_align = 512;
+
        /* Optimisation for I/Os between 4k and 128k */
        dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-                                               256, 256, 0);
+                                               256, small_align, 0);
        if (!dev->prp_small_pool) {
                dma_pool_destroy(dev->prp_page_pool);
                return -ENOMEM;
--

