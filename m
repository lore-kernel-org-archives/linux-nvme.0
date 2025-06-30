Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52464C83036
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TharGn6RiWbXxTyhQmBANq2iG9yGVxlUROLfglE4IjM=; b=Y+iHTPgqZu0It7cjyRshWt9pLR
	kdJCvQqoS4jUn9kXpkGqbaB06tn3975DLThzS+6ZQ8MW5kcimh9t6bqBHMK1V9wyDENFMcBrLo/S3
	OPJuBcrEH+AaUBeT152XeBLWQUzhCNxhniSu+u1DtmMIORvJYdUFX5fPLi4hW5dzrI1sEHlx9zUBJ
	CBT4JPpaeMVeHLvg3SCsiMT8fQmfIrJe3ax8lOSG9MG9Lk26qt7OnXV2RR3WUxJjm/2xOLNbI6SOU
	3k0Ee6LogE3HNkxPw5Q4goPT068lzqTOJFUaMoQi55yUBKpCoy5cTF9FqLzsqQ/M4f8TLrNigSNKp
	LCuIUqsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWErV-00000002Qb0-07yL;
	Mon, 30 Jun 2025 13:47:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEdv-00000002OBX-1T4G
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 13:33:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2DF5227A88; Mon, 30 Jun 2025 15:33:43 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:33:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250630133343.GA26040@lst.de>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_063355_522000_373279A9 
X-CRM114-Status: UNSURE (   8.91  )
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

Hi Ben,

> [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)

Can you resolve this to a source location for me. i.e.

gdb vmlinux

l *(iommu_dma_unmap_page+0xc4)

Also what IOMMU driver is this device using?  It looks like it
might not support a 4k IOMMU page size.


