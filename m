Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAB0C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TevFLqmklZFQF2QDP0AG0oRIWd
	4rgSRXjx6lZP3194uomLZLiKvCk9BUtlyZvXzz94M6YSHFJI+3ix6H9WVbvA8XqLR2+QcBtX3Qt6k
	aAnreiVgJc4qGg+a7G1mifRBJwUTcezdbi1A+kDkwu9+qwUbaVhnmt95pSeTwptgBQfQU0EDoi6UK
	gxKNvCdtV4cslY1+I1HfZIXFqh1rFRyPJZoa0I7x4KdyFIx/JMCh8G7ywyF7yc0PD1rAJYGV2K176
	7BPHZt5qhyvDZr7vK6ZswdXQxJ842nCK4g65gRQrB4wh6aWVaORh8nE5+/OjUwkR82xgX6iZLrISK
	fhLwwUHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3bc-003B1j-0a;
	Mon, 04 Dec 2023 07:43:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3bY-003B0b-0t
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 07:43:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C995B227A8E; Mon,  4 Dec 2023 08:42:50 +0100 (CET)
Date: Mon, 4 Dec 2023 08:42:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <20231204074250.GA29244@lst.de>
References: <20231128122958.2235-1-nj.shetty@samsung.com> <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com> <20231128122958.2235-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_234300_479471_52AFC130 
X-CRM114-Status: GOOD (  10.58  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

