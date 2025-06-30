Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D62C8302F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ia8h2ATXXLuM1qA/MiiveH5tbXl00IQTDhLjjCxpLqc=; b=PH5ImB8EefOYw2R8E5BBhC9mK/
	oafeyh62MzBiRx6FoctJtsupUsqH+oUIVvaU3iOM3eNJyl6E9R3gWkrDNrgYfl5ORx55kpfIwairg
	+wdqwrN8kuAX5ywboDue1J3NCPFdrzWcZvlFDt34W1ant90KLeKY4cYrZNfDzghRS+6EUPdfnrZGj
	1qA6KLBWhUAHNvWis6jzoMMJEOHU0mLfhjSaM7YkEuk4hrv0XnKUMA89Uh7IApeFkZf+rL5T2EXd0
	dOp9IM0cKiz9+5Lt1fO2m1wh49Pevg4hq2OqLVg4/4ny+Q79DxOTB1n0hLLeqkkZ8gSsPDMTheWxJ
	ScMBGtnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWMAH-00000003Uyj-0MtH;
	Mon, 30 Jun 2025 21:35:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWL4I-00000003OUf-2xf1
	for linux-nvme@bombadil.infradead.org;
	Mon, 30 Jun 2025 20:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ia8h2ATXXLuM1qA/MiiveH5tbXl00IQTDhLjjCxpLqc=; b=meNkKkpc49UOnGOxW5ULMNM6YZ
	IiD4ZENcfMG7HKHliNoj/QaHNlrYqBkpcji0cUyjg4bPz9YlytEV8t3H6AEfYU3sw6sjGCqVl6rou
	8/IuZesSATQZxdYobnZNTZ/Jemaysb3kgvAToPD+U5XZX1JkEMxF3WDFW8ViY4O8q4J+2FBXvPqNG
	9DVp4HFbZcKh32x63nwcs+ToK5uID8FK3jUJjrJGoiUksfI9NcMVXMlZJigpH51giA5qUyMXDt6qo
	ByJneaib+u7A3VIULeg5pKARjD6o8lQVjiy3s3RKVfnpfUpmVwds40KKtGLjpihEVzHaARSTxZGJA
	O/080eIg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWL4E-00000006szG-2ABf
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 20:25:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0BB655C5CED;
	Mon, 30 Jun 2025 20:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43772C4CEEB;
	Mon, 30 Jun 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751315125;
	bh=ui5hCeBwRvRdhzOlPRFBifufw7HRiacGECkcNfw+A/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGR4UWsWzR7g4+LhGxEPHvJBF2Y6j8XhE2knGrHs4Af42IDEzIZZWZmFsT4uolG2o
	 Nk8aQwIbKcT8dtvkpRMM8TlDlCfuvFTdd92yrgeq8cAE1k2SEJcbCImLiyi7giYxFw
	 9F41lpiCKhvWbnTJem8i5UbsQkX8THJSwANmP6s/nDR6PS9Cj2hmJVbqAh7/OvSk9v
	 +g7WOcnsfsfggE+l5+suj77KKoG3Mg2QMX4U2dFDrplrwm1M245oQrrdL36fluZYkt
	 WyB2mFBaIJv14r64KhB/Vj+FudX5cfmH76NatWknmo/jMOABwdUlUpgQ24r6d/YJ8O
	 u5jxY04iWUYDw==
Date: Mon, 30 Jun 2025 14:25:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGLyswGYD6Zai_sI@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630133343.GA26040@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_212530_836131_B47138C0 
X-CRM114-Status: GOOD (  16.33  )
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

On Mon, Jun 30, 2025 at 03:33:43PM +0200, Christoph Hellwig wrote:
> Hi Ben,
> 
> > [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)
> 
> Can you resolve this to a source location for me. i.e.
> 
> gdb vmlinux
> 
> l *(iommu_dma_unmap_page+0xc4)
> 
> Also what IOMMU driver is this device using?  It looks like it
> might not support a 4k IOMMU page size.

I think the PRP handling is broken. At the very least, handling the last
element is wrong if it appears at the end of the list, so I think we
need something like this:

---
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -701,7 +701,7 @@ static void nvme_free_prps(struct request *req)
        prp_list = iod->descriptors[desc];
        do {
                dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-               if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+               if (i == NVME_CTRL_PAGE_SIZE >> 3 && length > NVME_CTRL_PAGE_SIZE) {
                        prp_list = iod->descriptors[++desc];
                        i = 0;
                }
--

But even that, the PRP setup doesn't match the teardown. We're calling
dma_map_page() on each PRP even if consecutive PRP's came from the same
dma mapping segment. So even if it had been coalesced, but if the device
doesn't support SGLs, then it would use the prp unmap path.

Ben, can you check if your device supports sgl?

  # nvme id-ctrl /dev/nvme0 | grep sgl

