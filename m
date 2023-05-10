Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5B1C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0KcbpbiXTQHNeIbsr6ll6DprKrGtGRsGqt5Wk2cbKw=; b=MyjcPfdzobAPTw7xpHYVF6Bg5a
	Hzz44D1vmbitxL06AyrkhqhUOmCb1gfxSnXemUJwWwbOnAK2ABitHJK6BGsU3JLOnfGw07WQHaBqT
	SRNdUagjuqvL1BsaGD8QcH8j0NJP3VjhuvSJCE+17KkZlRA/kLNXZGztEx0mVMMdsCYQRUdiCp+M4
	wBz6aqv/hIcqYcH7GCty8nOnIl3RvlfBnqt0ND5ElG3e+EIKPHU8eg3T5zboLBUkhuo6fqFvfQuDu
	JsftfpPZOMBCWTu0FHlG3v7o02kNwRMQHRpSluJeXBYEmM/2efTOMI7zfXa/8DPp6RXbt0cG+g7+G
	hYJtdaCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwoS9-006kND-0f;
	Wed, 10 May 2023 18:22:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwoS5-006kM8-2v
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:22:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 09515636C0;
	Wed, 10 May 2023 18:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA1C433D2;
	Wed, 10 May 2023 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683742932;
	bh=N/BoGk2dK/WsdrxH9VOAyg5YKhSgV6KBcZoP0C48qzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyYZGV0GAmZgwtS777c6bVS3xjvlwVKxWJdPWDo1lkSlaTrO1i721JfvZLrPqZmmw
	 mXv0waCgeLnDckU71bTU+sMXI8aBN7HnW1vAiWO0E02zEm/4FUlKPQMy9tJNk9nhRC
	 qEOO3Pmo0fxKBqNX0BzV6whoXMDjktLv6dKVq7jozi0ITTJsJHpQWSD/DwOapRrxUp
	 vjRGQhdUt5dxg6gzudoqfGzWFZXv/JC1LDm56PPeW0j1cETfBcMPI6oC9NgH9wyH2D
	 820Aet3NaNJ/tw2RNE1eCvrJEDZYO7pXRV+U03aNhQjEkwaIA5/mEwKCYvKuuCqiKV
	 C5If3bQzmlGmg==
Date: Wed, 10 May 2023 11:22:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, iommu@lists.linux.dev,
	Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
Message-ID: <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
 <20230503161759.GA1614@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503161759.GA1614@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_112214_004584_18CDB351 
X-CRM114-Status: GOOD (  14.15  )
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

On Wed, May 03, 2023 at 06:17:59PM +0200, Christoph Hellwig wrote:
> dma_opt_mapping_size falls back to and is bound by dma_max_mapping_size.
> So I think we could just do this:

Thanks for discoverying this even futher simplifaction. This looks good
to me.

Adrian, are you okay with the suggestion?

> @@ -2956,7 +2956,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 * over a single page.
>  	 */
>  	dev->ctrl.max_hw_sectors = min_t(u32,
> -		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
> +		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
>  	dev->ctrl.max_segments = NVME_MAX_SEGS;
>  
>  	/*

