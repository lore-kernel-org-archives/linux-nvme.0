Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E269E7716D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnSYdMN86mbaRzJhBT52JOkILQ6CDdK3tY8TII5XHHw=; b=WOGP+cWDEq5nSwXprjZs+6A+GI
	DGg5AMXSsgDcvsED5eJV5cepEs6mmkLIMBGQ9ZJg+xzeW4VmIu7rYRjaBjIbF4W845DOD+VBOUv5d
	D9ghE6MDi545cHS0jSGG9A9wtO3p3wWgISDy5GHjT/+Ht+5asu879aucCH+Rx3nPjKWo8ZV6ZWOD8
	m+DI4rOhuBMjc2q3lvUdDggpaeeaN8dAGOCDPZQN/viqfDBS1up9serw9tJd32keCR6fWUsOw1UcZ
	IreUF1aQEw+K6/zBmrVFNV4P90VnXnSKwRAMTkRwEnXmhGMV+KbpeCmAyoSyT5yBJezLVfhcFymp3
	zwK9Rm3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIt8c-0000000DMHI-0ZV6;
	Wed, 04 Dec 2024 17:26:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIt8a-0000000DMFf-0P3d
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 17:26:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 98CDA5C6FCC;
	Wed,  4 Dec 2024 17:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D27C4CECD;
	Wed,  4 Dec 2024 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733333167;
	bh=DnSYdMN86mbaRzJhBT52JOkILQ6CDdK3tY8TII5XHHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PngIcAX1L9L51UHo9zLGxzMC8PHncSYV6DlkyivnLFZb13mheW4G0zr4egRL9csdc
	 xD/Iph/wwoWqzTZsZaJQtwEg16+p3QUML4gfEa927KAyR4MIMrXybS7x9hr5qzDMzz
	 9jRCf8cj7CvvRItGclh6ZmASzHC5U2rcnJYLk4EjDJ9X/8FWjYnYCjUN+wCdeS1pN4
	 Dyy8uau39zAbfbqomG2LW2b6fwr3jXH9b9mP6q7uGksi4ibXozJZ8Wd4OUfsCh2zXr
	 LlISEeQU8Z6mCunU8w6F+AsQKu2nehhxor3KQxqRZA7HZqU497bfxM1ipj5zL8aeH6
	 3M/6+bbfY3BVA==
Date: Wed, 4 Dec 2024 09:26:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
 boundary
Message-ID: <Z1CQrRd2F04MvsLT@kbusch-mbp>
References: <20241204004240.687875-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204004240.687875-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_092608_174323_041617F0 
X-CRM114-Status: GOOD (  11.21  )
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

On Wed, Dec 04, 2024 at 09:42:40AM +0900, Christoph Hellwig wrote:
> Only call into nvme_alloc_host_mem_single which uses
> dma_alloc_noncontiguous when there is non-null dma merge boundary.
> Without this we'll call into dma_alloc_noncontiguous for device using
> dma-direct, which can work fine as long as the preferred size is below the
> MAX_ORDER of the page allocator, but blows up with a warning if it is
> too large.

Thanks, applied to nvme-6.13 with the mentioned spelling fix.

