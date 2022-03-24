Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4989C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZINNwC3lf0Jck2tWtXx2mNLK0dmLSMNrJLQtwZiQ04=; b=ZuXqMb33bVNPW//9rMjORXiGyf
	eZuj2eLmw0kkRV9mpDXk9wbP71omvK/V0FPPapgiBWUCKAtx+AA8AY+XNvAWsMiOafLj8uuiYeB9R
	6xJ6BuQ/o2vecJNJUdTf4jhwE5KYwSE1+fkenCK3nmBkUhx21xZCiSNGBl6MX8bGakcxMdJw64fPs
	FIxJzyaXqmbBywsYgwWu7hmBLlZ9Lxp2A81cSR0UyhwLZxzGFYXm8nuyeulaDMASuZEeUReakz5u3
	oVRmSrelvQVXi/OInYht+8758FAGQ1cqmEogWhuCRVQGrm/vLPcOBqM9QBBjDjxbY4Ft6SM5ioSok
	zbI6tUaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGlw-00Fmzq-J4; Thu, 24 Mar 2022 06:16:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGlk-00FmxF-QH; Thu, 24 Mar 2022 06:16:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F2DA68B05; Thu, 24 Mar 2022 07:16:21 +0100 (CET)
Date: Thu, 24 Mar 2022 07:16:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220324061620.GA12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_231625_021456_B73A01BD 
X-CRM114-Status: GOOD (  15.10  )
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

> +
> +//#define DEBUG

This should not leak into the driverṡ

> +#include <linux/blk-integrity.h>

As far as I can tell this driver does not support metadata or PI,
so why is this include needed?

> +/* NVM Express NVM Command Set Specification, Revision 1.0a, Figure 18 */
> +#define NVME_OPCODE_DATA_XFER_HOST_TO_CTRL BIT(0)
> +#define NVME_OPCODE_DATA_XFER_CTRL_TO_HOST BIT(1)

Please just use the nvme_is_write helper where you are using these.

> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,

Please avoid > 80 character lines.

> +static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> +{
> +}

So where are the apple specific resources free?  ->free_ctrl is
the callback from the struct device release callback, so without
one the resource release can't be tried to the device release.

