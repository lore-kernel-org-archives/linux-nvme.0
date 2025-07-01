Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C532C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 19:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJc2jeo6B9EbYb4il7K4jTWN7p7rYxXf6q+RIwz9OY0=; b=bKtvBFn11erBr1Uct63aexZ7Yk
	sYbqQFoxPfMNk7UcjtN2ZP67t1UO9lzYqP7Fa1bxAWDCM7RypXxox4aPa4jexdVcORNpxmVhEXLhq
	mWtjZ8EF4kddGETqKeKNzvBHCkGqFRVmmnZLGNIZlWP5O8xixgd7XeIyyEM1s9CZOMcCGwyyrUpXW
	zK2t1LqqUmJqMeMOIv3fJetFAYzNs1VLr8ecKexeCnLYz91aNx3qBmh0YyvplMQ20OjQh5L1NWZEt
	5A0R5WDvzZyc4eZq2eE9qqaaTTdmI3nwUBwEHlskQ3IULiC7kfJ4MPxOgyXcaCkrlSQzhgpfOzrQe
	Ld/iYFPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWh4l-00000006VtU-4AKV;
	Tue, 01 Jul 2025 19:55:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWgtb-00000006Use-0QuS
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 19:44:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E2EFBA532C5;
	Tue,  1 Jul 2025 19:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF6C4CEEB;
	Tue,  1 Jul 2025 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399037;
	bh=YHWVpqomr7XSftU5O/rbq46bOk35329T72HjY7oYZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQDXDVy3ZKakm5WAJdfVIKx08TcO85H8tT3HOcSYLKPL/qca/hS3RR704o7q5AXVi
	 yIejjXkd9c6G/Po6Ka+wrYFvmR9JrnqjRiX/oSD2gu8669fK24/94LnPDLnuCqcgY6
	 9jGc9dmCmuXNLHJygKpop1tr8B5JB5Z9PChrYFN2RsxRoxXAW6RZmTWZ+otI07EI9B
	 nmBW5rth4IJH7a7/zS5fOmoP6FvwYCbgr3cul9J9vf7iiqEVy12qbkggnZjTygInPJ
	 dbstu3lXbKNH3EcKeFsomP9Zp1KtGkw+lhixVgoVSssHCLoKrEiu34tqb732+rU77x
	 oGIvZLs6wgmdA==
Date: Tue, 1 Jul 2025 15:43:54 -0400
From: Keith Busch <kbusch@kernel.org>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGQ6eiL22KIMjSGo@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <CAL0q8a7sE4a00ehKrkyepA_xA3Z2HiGv0LazvYe=2NciTkkPFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a7sE4a00ehKrkyepA_xA3Z2HiGv0LazvYe=2NciTkkPFQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_124359_208531_988CE9C0 
X-CRM114-Status: UNSURE (   9.45  )
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

On Mon, Jun 30, 2025 at 08:51:01PM +0100, Ben Copeland wrote:
> 
> [    1.083447] arm-smmu-v3 arm-smmu-v3.16.auto: option mask 0x0
> [    1.083460] arm-smmu-v3 arm-smmu-v3.16.auto: IDR0.HTTU features(0x600000) overridden by FW configuration (0x0)
> [    1.083463] arm-smmu-v3 arm-smmu-v3.16.auto: ias 48-bit, oas 48-bit (features 0x0094dfef)

Neat, I have machine with the same. The iommu granularity appears to be
able to take on various values, so let's see what the iommu group's
pgsize_bitmap is on mine with some bpf and drgn magic:

  # bpftrace -e 'kfunc:iommu_group_show_type { printf("iommu_group: 0x%lx\n", args->group); }' &
  # cat /sys/kernel/iommu_groups/0/type
  iommu_group: 0xffff0000b54d0600

  # drgn
  >>> hex(Object(prog, "struct iommu_group *", 0xffff0000b54d0600).default_domain.pgsize_bitmap)
  '0x20010000'

So 64k is the minimum iommu granularity in its current configuration.
Definitely too big to guarantee coalescing nvme segments, so if yours is
similarly configured, that explains why it takes the path you're taking.

