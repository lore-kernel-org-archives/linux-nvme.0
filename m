Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A739C369D1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZVAIov90/gT5IGiDtQ/DrbEvSNrFR/J2JRW1fQ9QE58=; b=fP3mRgAZ0+rcT8rtDvk5n5z1R4
	a4DowM7pKUatS8XWPZxxqrGr0EaB+BpOJbP+PeTPvRjKUQU29jGThiFYtUy5IVYrk+reZbBaUXRU5
	CynNWSfJiF6ZcclfRQRZvmUEeqdKutcYP97IAK72XgeEz9QaJumCC4rMdeYL3edQVBA5OaVluLPFu
	X5hht1x9Yaz18X5xu3X3FjscQUJaiUDPZSXm3JRBtHtGxblD7J+vC2l0XHzCsIsQRrcCoRVqej+hv
	JchgRlcJ+N9t0QJapTETZ/koGPpWYYuLWVdaPIvI4Wz9VGzjaanHgry/dETzroqOIoVZ13xjtIega
	RQVXAprg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ITD-00000008BY1-3IsO;
	Tue, 22 Apr 2025 18:35:47 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GZU-00000007vlm-2pGe
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 16:34:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 80764A4BDCD;
	Tue, 22 Apr 2025 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2852C4CEE9;
	Tue, 22 Apr 2025 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745339647;
	bh=2HX9NnIdWdyEKGSVqKyROEqpVfX1aEeaCkk+QgIbE2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ygfp0wn02RZZnWptASc2GOcVr3uW5p1gSPFTeEYMLPZVxU4TWqJ0CHAcHbLAWtb0h
	 NcwH9r/PCuHaHq/SoWCLdk83KNK6jXdNw5nO39qzi4OrLF7DU9jhFCpZaXNB+HXjI8
	 Bs9gTFhqGmmhDc+qRw9hxt3YNMsXTa/ZHnh586VBNVph+nmUzqTXeR7e4dnatGvl4Y
	 ZsmBGL7IfrktutcMlsrEYJo/lGE+//KIIsviTLBaLEA4nK8YikHiAUjWJW9kA7lWqv
	 mEj/mCcETLvVDkfDGc/FMWYUUoB6FQx4Vlxtog8WIltv/J/pSl6JPAv/QXMpUe2qp7
	 FH5T4p6YZ2zRQ==
Date: Tue, 22 Apr 2025 10:34:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <aAfE_eofwrOIQ3Sw@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
 <20250422161959.1958205-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422161959.1958205-3-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_093408_791082_5D167481 
X-CRM114-Status: GOOD (  15.95  )
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

On Tue, Apr 22, 2025 at 10:19:59AM -0600, Caleb Sander Mateos wrote:
> NVMe commands with more than 4 KB of data allocate PRP list pages from
> the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
> to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
> These device-global spinlocks are a significant source of contention
> when many CPUs are submitting to the same NVMe devices. On a workload
> issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
> to 23 NVMe devices, we observed 2.4% of CPU time spent in
> _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> 
> Ideally, the dma_pools would be per-hctx to minimize
> contention. But that could impose considerable resource costs in a
> system with many NVMe devices and CPUs.
> 
> As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
> nvme_queue to the set of DMA pools corresponding to its device and its
> hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
> about half, to 1.2%. Preventing the sharing of PRP list pages across
> NUMA nodes also makes them cheaper to initialize.

I was hoping for an even greater improvement, but still good. Maybe we
can do slightly better if we also pass the numa_node to
dma_pool_create() and allocate the 'struct dma_pool' on the same node
that's going to use it.

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

