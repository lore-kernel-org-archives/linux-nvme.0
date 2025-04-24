Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14ACC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NT59oTYpIFFERxI2Phki2xY/ZupFq3Pn6jMztcz5xfA=; b=nnfLPZrPQu9h6KZI1jkTiPCrCb
	V1oQxbHrDY5sQmI/sVsxe25mEv0v45pKGI96fBBR2bXG1B34mdbHGfWy0vQBAJlVMlnyyfVfmODEd
	8Ah0X8jdPXPtGpMii8iCwYcTvkuKaBDVrw+zblnNqox/Y5EDGe+jqmkXsp8nlP/FbvAGpTJAb5b9W
	VrXh+9UTjWZ+4FBxqJEdUEY2BXtnSiMJknngiLxaBNgwAu9jT54iCjhhixyLFJESzoJs6fUONBSZX
	9UN/IWeo8aVn0droqGZVuDXIpESW6scTzYCLnHnvYhrqpSQ2FbTpJNOWKYTMiqKMKIJwgpcAk9gIm
	fqQe0qyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z4K-0000000Ebks-3DJf;
	Thu, 24 Apr 2025 16:04:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wRo-0000000EALm-2th2
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 13:17:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0909A5C0F53;
	Thu, 24 Apr 2025 13:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5253C4CEE3;
	Thu, 24 Apr 2025 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745500619;
	bh=g4Pr4HhPsv12XdZwgDJSlePpycOQxNs+tcCz891xfD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gorNdi8zPElBZJDB/odqKCcOtYBtt+69qUOUyzKfEddJ2PFpEz1WANNeFPYbBg0Bq
	 Yohx8zhzSSaRINxt4opiMQU/pj8TYEU9v5UpkNjbbnMLfY9h/n0rNJbf7bvax/+ZNQ
	 SM0ojRpQEoMCVQ2vbztJ1ArCv/xjyz0IJ1+2r0m0nV2Z5VBnMwX+nBSJFmFj0mPJwV
	 HuaNOqcM7j1avvlkC47LMf/G/7uiDAUNB4UVgvsmVQxF9k7KmjQg///voOeLWF9H7e
	 7ZVQBrlS5Tr6OKh7hI3g9PmaUjjyswiQYgGPA2P9OPjymF+MbjvEl1Pxe4BOXcyTFQ
	 Pkntlei11gs2A==
Date: Thu, 24 Apr 2025 15:16:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, dlemoal@kernel.org,
	alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
Message-ID: <aAo5xgVOgf0HeFl6@x1-carbon>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_061700_769878_3DC579BF 
X-CRM114-Status: GOOD (  19.41  )
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

Hello Wilfred,

On Thu, Apr 24, 2025 at 03:13:48PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Hi all,
> 
> For the NVMe PCI transport, the NVMe specification allows different
> submission queues (SQs) to share completion queues (CQs), however,
> this is not supported in the current NVMe target implementation.
> Until now, the nvmet target implementation enforced a 1:1 relationship
> between SQs and CQs, which is not specification compliant for the NVMe
> PCI transport.

Perhaps it is a bit too harsh to say that we are non-spec compliant.
We don't implement every feature in the NVMe spec in the Linux drivers
on purpose, because there is a lot of feature creep in NVMe.

Perhaps rephrase this to something like:
"While the nvmet target implementation only supports a 1:1 relationship
between SQs and CQs, the NVMe over PCIe Transport Specification does not
have this restriction."


> 
> This patch series adds support for CQ sharing between multiple SQs in the
> NVMe target driver, in line with the NVMe PCI transport specification.
> This series implements reference counting for completion queues to ensure
> proper lifecycle management when shared across multiple submission queues.
> This ensures that we retain CQs until all referencing SQs are deleted
> first, thereby avoiding premature CQ deletions.

The patches themselves look nice, however, I do think this cover letter is
missing the answer to the question "why?".

If you need to modify the host-side Linux kernel even to test this feature,
why are we doing this?

Is because we want to be nice to other host-side operating systems or NVMe
stacks, e.g. SPDK, with might actually use this feature?


Kind regards,
Niklas

