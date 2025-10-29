Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F5CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRGw2SN5vARGYtFqRkYsGApfAXFVzAPvTpRbYb2K8jk=; b=YI5gbKaZ2IcEgnjHk/ynDA3wcn
	38sBiBo2YP1DOMI7ttfQeDiNo9vSE0NTtNLJBc+/MRPj7rk+IX91G4VvFMW3eWyXT5FclzdEnx16W
	RX04f9fTPzSz8BStqinLUCTo6I9ExAjCySpwgFSCiTBMd7P3lnxnGY7srboWfvz68oOYKoUhU5Tcc
	SzBmuzowVgum2mJvbxdfUrwsz/lbjVpW9HCCQOAmz455ifxLpQJbq3N66sipgIAfV7/IGNffulJCO
	0Cs4w5we8tMEYpprVO8qlZTCzZBv6x5y2lBFcstb8n5vI6ULuoknyZBZtxFJ+DdPdDTvELCO1Y/Yu
	khZ4FY2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE10s-00000000AGQ-1Hk8;
	Wed, 29 Oct 2025 07:54:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE10q-00000000AG3-2o0T;
	Wed, 29 Oct 2025 07:54:32 +0000
Date: Wed, 29 Oct 2025 00:54:32 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
Message-ID: <aQHIOJcEeGQnYBge@infradead.org>
References: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
 <aPnDLr2IiOQUQLKI@infradead.org>
 <aPo7c8aZ7GDqHFEO@kbusch-mbp>
 <c4iaipkglrhgjbovj3uvj4pxnbxdirzxm5yymidiqii55h3i6d@plehjivcjs54>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4iaipkglrhgjbovj3uvj4pxnbxdirzxm5yymidiqii55h3i6d@plehjivcjs54>
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

Yes, the patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


