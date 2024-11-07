Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE42D5D66B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46zMNri+AGeiznjDoZX8tvclnTDWBiZ0BDALNHQI+e4=; b=wCtbiZq24MUdAdqMJnthXzm8O6
	MU56tVeai3cjAPUyZRBz6n+Zuw+G0qHSfLlDLoOxfmWFvwMWacKrzr0PQbClBnmhif3h08CA+8Pbs
	faHiMPtZp4Y1NDkTnYQNv+DHMesRM3hrMhdWny25sqDQ/hNi1pVk6ELfA8XdhIizbIrIewDAPR6in
	o+FThz8lE1dldhjIbTzUwBy1YbJUydBjr61TYTzdYUxEpD7s9Hka7brTgEFgkG55KgowMzE9agiMD
	B3h/SEPhgSSqgk4CLv2bkfzH7WMkaCJ4vFwDtpbE+zmnz/Me/FTdS6mhy55pyQ8Ea/BfZSJvRIbHa
	DNal7A+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t96AU-00000007n2A-3HHA;
	Thu, 07 Nov 2024 17:19:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t96AR-00000007n1j-1CGI
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 17:19:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F5D5A448A8;
	Thu,  7 Nov 2024 17:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE5C4CECC;
	Thu,  7 Nov 2024 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730999973;
	bh=oqZnj3nucJM60cIfyc8kf3ErFRrH9f1YRFHIGBlSDro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZO4aapRuNnHDr8oE2VhQbb6eD/aCiUzQ0QCwJtmx5kq9fLA/RKhVj2VZH1BQ+A2Pc
	 C7cJhTNV9krDdMGUU5BU10lPglIhzNPQ3Z4YqMt+ukpnYUOXU5LWjxdTUtI4opsGR2
	 cSZg0l1/JDjMcj2Gm4cnAfptdozTrTX8sgEGa4FlnMd4UYjpqtfpTJFb2LVwkFx4xU
	 Be8FrrN/yIeL2iCExkraxkZZTMeVyl/6Cz4Yjm1iy4OC0cMII4QN5i2691DAWECwjh
	 q6moo3TENq9iASogpJF+4J9XcMY4JxPcO0JC593P4qOonQYRsccYI75Of1EWGDYqh+
	 RLVMJz3G26sog==
Date: Thu, 7 Nov 2024 10:19:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Message-ID: <Zyz2oiQ2pco15HHT@kbusch-mbp>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
 <20241107165131.3462171-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107165131.3462171-1-bob.beckett@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_091935_408008_A29765B6 
X-CRM114-Status: GOOD (  14.94  )
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

On Thu, Nov 07, 2024 at 04:50:46PM +0000, Bob Beckett wrote:
> @@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>  	}
>  
>  	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
> -	if (nprps <= (256 / 8)) {
> +	if (nprps <= (dev->small_dmapool_seg_size / 8)) {
>  		pool = dev->prp_small_pool;
>  		iod->nr_allocations = 0;
>  	} else {

We have a constant expression currently, and this is changing it a full
division in the IO path. :(

Could we leave the pool selection check size as-is and just say the cost
of the quirk is additional memory overhead?

> @@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list small", dev->dev,
> +						dev->small_dmapool_seg_size,
> +						dev->small_dmapool_seg_size, 0);

I think it should work if we only change the alignment property of the
pool. Something like this:

	if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_512)
		dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
						      256, 512, 0);
	else
		dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
						      256, 256, 0);

