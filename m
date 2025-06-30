Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8272DC83000
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lQyPGKhSq9KW7FgWNucgL1V7RFNBeyUyiQqzpmoX9o=; b=DOZ52I92vlYQR1vqo70wUcz1XW
	SZM2mJjBRMfCXUC3v4MsJKc8R78hpPa0kvvCElA0qQLcJ6OqUA1Ob07jReG/psWeIB4JL7pKcbCbr
	nPQbE35Y6/bNTPzi1WQh/kQRm3lmQQzkhAVUoQvgV5zd4MKuii2ZSZijXK5eBksVoOMPWxGIVSbSD
	cxnDJq6Tm596JDYow1p+aA/92hfQG8oD3XryXcj6Cg9zuPq64A5rqsaHEbCFhMJR04hGsZUt5xfPD
	fMDxGLoampI0lVGnd1h5CidWKfajiKuPLyZWdr7fZi3EbkCheezcEt7G4nilF1uUzjyzCylfVz7pJ
	v7wuAtzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7ay-00000001InN-2n0u;
	Mon, 30 Jun 2025 06:02:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7ZC-00000001Ic6-0i9b
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5C3368D05; Mon, 30 Jun 2025 08:00:17 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:00:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <20250630060016.GA28775@lst.de>
References: <20250624211444.2835077-1-kbusch@meta.com> <20250625060915.GB9391@lst.de> <aFxzXOZUFtt6hyPA@kbusch-mbp> <20250626051413.GC23248@lst.de> <aF1nUYSXvLE33osR@kbusch-mbp> <20250627072524.GA1329@lst.de> <aF66IGSMATG9-sLy@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF66IGSMATG9-sLy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_230034_346306_EFD9249A 
X-CRM114-Status: GOOD (  13.81  )
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

On Fri, Jun 27, 2025 at 09:34:56AM -0600, Keith Busch wrote:
> Back to this patch, I get that this uring_cmd path wouldn't be able to
> use the more efficient coalesced mapping when the IOMMU is on, and
> instead map each segment indiviually. I think that's still better than
> the alternative, though.

My back on the envelope calculations (for 8 byte metadata chunks)
suggests otherwise, but I never got around fully benchmarking it.
If you do have a representation workload that you care about I'd love to
see the numbers.

