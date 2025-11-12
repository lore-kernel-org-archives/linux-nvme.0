Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E39CD37BB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3lF+hUA6kSlyRAlRdrAuygeHb6j4ihwrSjvAEL6buso=; b=boZ80j7ZD6/dVqENO8GF1bf8pS
	M+CAM7iKu/wCbPo0bgXP3x+wmjYCJev/LIUfPAATQw2F1Qdbhj/vJTN+ijWIWJC31B5JX3fyuNFX0
	sCMl6J4n1wleUVoeneZpm2cQ7XZKqVhT6JmvEvD4jJcCHNqlc2Le/OA5cRxI5N8r1HFf+VeIWcMQq
	X8Sv4Ypk5FASYbDLq6zD1e00GRjbk1XrMgsBOs3vXUGVvmtm7nS8KiP358Rsl4//CyiBDXTeZzzpt
	UIE6OwXeYav75LoSQvduaE4u0HkJZvyoEJW3MuPDwTVn7Z0QNXz9t2SriSp0wBB3RGs7De9QLbvC8
	NMQO8XVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJH0r-00000009Rx7-1ozp;
	Wed, 12 Nov 2025 20:00:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJH0q-00000009Rvz-0but
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 20:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 42DEE601A5;
	Wed, 12 Nov 2025 20:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE71C4CEF1;
	Wed, 12 Nov 2025 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762977614;
	bh=4fG9Ur91w+X52ehK5y6ywRwOWBbDk4C2OU5cqPLS6qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz3RlSFMzfhxAjnIGbWv6+VutJ1mc8y0R0OXJZ+AiCE5iK8k648cSq58T9fF/+xAr
	 cp41t0ixxleQGV6wz07fHZUH5XthX8cT5FIreElVIvx3fXFes6rGuvyiohaGxrkixC
	 CZpcKIO23sCzbzsLgnNitJwl2qRuu0pBgr1zoMuIhIGDduYNqhbpT6rfePMRw1OTMa
	 1WMFH2O8yXnR5peGoB7NXQEMJsmLJrSrvk5wKgahhab3dq7UenZNpQGjDSCYcEhsMH
	 ElaHtdQxArigqBrZPUDIoXMnFbapGFJLHYnVOCZWDNgfnpR+GOhyuDB3cO+mdkpehD
	 dDbaybw44Mcmw==
Date: Wed, 12 Nov 2025 15:00:11 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/2] block-dma: properly take MMIO path
Message-ID: <aRTnS1NZ0yEL0pJl@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>
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

On Wed, Nov 12, 2025 at 09:48:05PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
> indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
> MMIO addresses, which require to avoid any memory cache flushing, as
> an outcome of the discussion pointed in Link tag below.
> 
> In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
> treated this as regular page and relied on "struct page" DMA flow.
> That flow performs CPU cache flushing, which shouldn't be done here,
> and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.
> 
> As a solution, let's encode peer-to-peer transaction type in NVMe IOD
> flags variable and provide it to blk-mq-dma API.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

