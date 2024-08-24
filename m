Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BABC52D6F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKjohj4cmw7kHXRBBqx+TRPt/+b5ozL4bpx9OTxM95E=; b=tk5C5OnnJMB6WXf+HulJkLdYz6
	iMKOvRvBKZpBx6sSCt9X14SckigQzZh4BRciekNiNQ3JMx7A7ywh8iOqdJzkHGVMaAqbgjXj2rPdy
	nqXDc3zTxdHuLyk7SzGxBF14udCOmkX+qEqCvcfg6D7dJ/W4gYkJ+BXXOHUgwuGmp4BKS+qC/MY/Q
	iaCfDKvPOp0X0m2MVjGMTF1OJsZnkRPoMzw0uCQeOWhL6y9DuKby/s6PTtLYvQvsEksf2Ib9pDL7m
	Fznsw6XpUYmF9V5tDwS4/uGatKfw/rO1PEb5qpzLKfXOKsYnCsTWjwNfyUxTjsfdmhEo2qMIfnviw
	CaBeIN+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shlm9-00000001nQk-2OgZ;
	Sat, 24 Aug 2024 08:05:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shlm5-00000001nOw-3OLJ
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:05:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28730227A88; Sat, 24 Aug 2024 10:05:15 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:05:14 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240824080514.GA8527@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com> <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org> <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_010530_234345_64686E78 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

On Fri, Aug 23, 2024 at 02:20:41AM +0000, Michael Kelley wrote:
> Christoph Hellwig, or anyone else who knows the history and current
> reality better than I do, please jump in. :-)

It's not just interrupt context, but any context that does not allow
blocking.  There is plenty of that as seen by the moving of nvme
to specifically request a blocking context for I/O submission in this
path.

That being said there are probably more contexts that can block than
those that can't, so allowing for that option is a good thing.

