Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2258EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7fNOqLzsAD61odb1/ZLayHnZMjcu77FILGuKZ5rhl0=; b=yHBTI+9ru8YUIk/epJkSA+SmUm
	YsLnx5rfVdfM1cWMizQXxoX56m0KcbIk5LixhLlGfhGhClaEapoX9oEL1zlDJjnD1bo6Pskm04sbY
	uVlDimA8XE8pg9Tp7Vht/2JOdbxUoXO6cE8Jbn/aIxyi6sn9a8Z/bMvcJ4mXK+4zRKUfPGc2q8Lia
	yi77WsZQsF/JSWpyQ3mXCe4MUJTtDX4uObjQ2RNy1uxPgtfSjhRRPSc8tGTQygVcThzwaUSJbnixP
	4XmrBI5CduWpQPZ3XJ8vsck1BBROP9DHQSM0VyyfF5Qdze1V6txcx5mfLXL3bk9h7bAFUs8oWSyl3
	q6Oaa7AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWLhC-008abM-3g; Mon, 21 Mar 2022 17:19:54 +0000
Received: from rosenzweig.io ([138.197.143.207])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWLej-008ZkJ-HJ; Mon, 21 Mar 2022 17:17:23 +0000
Received: by rosenzweig.io (Postfix, from userid 1000)
 id 567F241E29; Mon, 21 Mar 2022 17:17:14 +0000 (UTC)
Date: Mon, 21 Mar 2022 17:17:14 +0000
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Message-ID: <YjizGmjlAhyU6bC6@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-5-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_101721_692462_807A835B 
X-CRM114-Status: GOOD (  10.23  )
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

> +/*
> + * Adds the region [paddr, paddr+size] to the DMA allow list.
> + *
> + * @sart: SART reference
> + * @paddr: Start address of the region to be used for DMA
> + * @size: Size of the region to be used for DMA.
> + */
> +int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
> +				  size_t size);
> +
> +/*
> + * Removes the region [paddr, paddr+size] from the DMA allow list.
> + *
> + * Note that exact same paddr and size used for apple_sart_add_allowed_region
> + * have to be passed.
> + *
> + * @sart: SART reference
> + * @paddr: Start address of the region no longer used for DMA
> + * @size: Size of the region no longer used for DMA.
> + */
> +int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
> +				     size_t size);

Might it be simpler for add_allowed_region to return a handle that
remove_allowed_region takes instead of paddr+size? Then
remove_allowed_region doesn't have to walk anything, and the requirement
to use the same paddr/size is implicit.

