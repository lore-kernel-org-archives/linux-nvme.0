Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69476C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvLfQT1BwJUi3KDJhAKVPOhNmq18tLfrLwuKPxEJxvo=; b=Ttp4cdcSOxt6DzdO2bn6snYh7t
	0q4JQWefzO9Q/gv/kybOEHszQB0Zd76pPOEEhLOnWmLfWpQYA1w9RWwY9QxKexdKAmegL8dSETPLd
	5BwR36e1Y61MqZb7lHZLVWKAMrVfYsnWTmwP0UWZno8PSvmTPqgQWgQs5x6Cu4BD+HGTxPUeX2OeY
	FTmqsclSCJvH911BrUsktxlliDnVsIE+3QlmRHQQfLsxaNvOoby2Xtq62woUFYtHEyN6nHuNfgq3S
	KrwSmY1HDhANuTCWeHlsGua9rUTAYrqYm4UPhamTM6fw3D7cBj3FcKdDzD8rJnguK7aDqIyRvPsET
	NcutBkbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHa5-0000000238i-0AYA;
	Mon, 14 Jul 2025 11:42:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHZk-0000000231A-44cC
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 11:42:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D396227A87; Mon, 14 Jul 2025 13:42:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:42:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Message-ID: <20250714114213.GA1998@lst.de>
References: <20250711112250.633269-1-hch@lst.de> <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_044229_151202_D2F67ECF 
X-CRM114-Status: GOOD (  13.17  )
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

On Fri, Jul 11, 2025 at 07:46:08AM -0600, Jens Axboe wrote:
> On 7/11/25 5:22 AM, Christoph Hellwig wrote:
> > Not only do IOVA mappings no need the separate dma_vec tracking, it
> > also won't free it and thus leak the allocations.
> > 
> > Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
>          ^^^^^^^^^^^^
> 
> b8b7570a7ec872f2a27b775c4f8710ca8a357adf

Ah, sorry.  That was the commit ID in my tree before I sent the original
patch out.


