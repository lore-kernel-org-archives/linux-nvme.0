Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99631C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZiSf0+THoeV0Bk8DGiw9PTXmqpNm4iQ8U3t1Rpbuds=; b=k8vHoEmbVu8CE/fJFQfExGHUas
	4aGCfzJmZfImemvONi8g3WPFe2pqVmkC6efJ7zb0Z4jqMmLNjlnGBsfuyRlcUoFr0L8cl3nYc63ww
	4TQJ/8+4CsYz9pf7FbskUBy/v5TNkM2uKAoo4AfvPm3d699xscdhcrVb64wkBy/RGX0NvpjRYEZ3P
	52HFPJMjRibfMxu2gBHLalsnkBdCUa4pXmI6JbEdnxB7sgb5mjAcEv388ie7n8V2RdJRNVkHDt2wT
	bR/mAhnrno40CG2neaNfvzCJF6u5VDafKUU4pDR2g60Pxs8nvnKGo6M4jgQolK0NUKKj6P0UIkU48
	LPzAl/TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nggTF-001akv-KN; Tue, 19 Apr 2022 05:32:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nggT3-001aii-Nt; Tue, 19 Apr 2022 05:32:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 253EA68AFE; Tue, 19 Apr 2022 07:31:58 +0200 (CEST)
Date: Tue, 19 Apr 2022 07:31:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220419053157.GA31530@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-7-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_223201_966519_597F0570 
X-CRM114-Status: GOOD (  14.07  )
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

On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
> +++ b/drivers/nvme/host/apple.c
> @@ -0,0 +1,1597 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple ANS NVM Express device driver
> + * Copyright The Asahi Linux Contributors

Is that actually a valid legal entity?

> +#include <linux/io-64-nonatomic-lo-hi.h>

Does this controller still not support 64-bit MMIO accesses like
the old Apple PCIe controllers or is this just a leftover?

The rest of the code looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

