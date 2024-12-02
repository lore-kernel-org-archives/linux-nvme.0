Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37E3E69E81
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXsxnzZuPgwMnodAaXQwDNDfh6Bam2LfGg3Rx21DEqE=; b=ssv8OpdmH7tX0arp6QIQlxmNlH
	jo5uMUDubSYQWw9wCNbOeWVm8SC9D6kkcY5IZcrTaHHs34XBkad1I52Uf/md9DUZLqgW3tN6n+LaP
	cTM53uML6pXqkguLfiR0UN7g+7NJDKxkh2wY7CFQpwPbIsNU0aowGuNKCIc2kQuEaY4KOk2UWBKYd
	yor4gEwTgFuYv1AMRA55G/uvcLplOB97m8obo2Pm5H2DTtMLFeIYAAkyc77e4I618yBYyV02ygko/
	0EQVVDNoXjUHnTDCh1zGegyyuNvN4S1rFUSWogx21xZrFDTLy757OMWbpKrIiamGUY+AlI3Npf6mP
	YsLzxFPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBtj-00000007GZH-1qJT;
	Mon, 02 Dec 2024 19:15:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBth-00000007GYO-10fM
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 19:15:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DB564A411FA;
	Mon,  2 Dec 2024 19:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F3AC4CED1;
	Mon,  2 Dec 2024 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166951;
	bh=lb8RFXJ3GxbcLcOn36+gOw95lFB0jrbf/YX/dzMQ/nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mwwpp8mlfB/EsjUztevsJjHhlv6i9MzxRfuef6r9vF0/Qip7eAWjXwpT0JmgssL+D
	 NlWTChtZySiofjBeKyhGeYSf8U21nfFS/2W2HmsKYNua6TwH17fzm6Py1R2r8IQgYn
	 W7K6LeaKSqnyWEgD9HreIlqZV563HwpynVgJoO2amZFtlUvMpeidvQz0BLdbbwumqu
	 rz+k8WDywDSTiMZ4oK/TBHDlWC5EXPVhV5BGvDNJF0CdfecZgVMHSmWfvmDS3CEgmq
	 sY0sWx40eAFobd2S0x+xi2jfWhqlJHlp2pUHa6uXq/LxFcGWNnYPjCJ1Kxs91xyrfR
	 r8dsjqmrag2Bg==
Date: Mon, 2 Dec 2024 12:15:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-pci: use dma_alloc_noncontigous if possible
Message-ID: <Z04HZZVLJN8NBiW7@kbusch-mbp>
References: <20241101044016.405265-1-hch@lst.de>
 <20241101044016.405265-3-hch@lst.de>
 <20241202190541.GA2434798@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202190541.GA2434798@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_111553_345515_2594430C 
X-CRM114-Status: GOOD (  16.60  )
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

On Mon, Dec 02, 2024 at 09:05:41PM +0200, Leon Romanovsky wrote:
> I see at least two possible solutions, add GFP_NOWARN in nvme_alloc_host_mem_single()
> or the following patch:
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4c644bb7f069..baed4059d8a5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2172,7 +2172,8 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
> 
>  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>  {
> -       u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> +       u64 max_chunk = PAGE_SIZE * MAX_ORDER_NR_PAGES;
> +       u64 min_chunk = min_t(u64, preferred, max_chunk);
>         u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
>         u64 chunk_size;
> 
> @@ -2180,7 +2181,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>          * If there is an IOMMU that can merge pages, try a virtually
>          * non-contiguous allocation for a single segment first.
>          */
> -       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> +       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev)) && preferred < max_chunk) {
>                 if (!nvme_alloc_host_mem_single(dev, preferred))
>                         return 0;
>         }
> (END)
> 
> What is the preferred way to overcome the warning?

I think your max_chunk check suggestion looks pretty good.

