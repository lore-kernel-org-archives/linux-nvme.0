Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F814606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dVcyBWIM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=le5Sy5w5pera8NhNCpSZ7/jVTZr08rgUs1TNqJVm1nY=; b=dVcyBWIMc+8s9FP3tUcpgtGJAS
	3puKfMyehHTx7on7p+k+mwfuZ0Td2Nv2ydHOLgnVDNh0v5WCVi+S/uXCmojeGBGPOUcHb4qGuWTcQ
	8/FDOsYTB/v7A3S5vmB3OJBRfdhuwYVx4ybfgzGnCrzzinilomGIqvzFgsOISZ+JcDi3k2FBq9LbV
	GqO56GU1SugaqolYU4gK0wYeRbC6TxIX+cRWqLNsLNAFmlP83wjSEQLgcfKLOC8W938iYkJzF9yhU
	EPmJlIcrcBRsOna2PbvdQnBBVW3k0xFxI4ePc/O7IQuTbdGp9rOAs62Myl5MMdwfpEd/es3jdmDdR
	ib1Q1h4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHai-0000000C3Di-2dd1;
	Fri, 06 Nov 2026 10:54:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHag-0000000C3Cp-1RWA
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:54:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2052668BEB; Fri,  6 Nov 2026 11:54:35 +0100 (CET)
Date: Fri, 6 Nov 2026 11:54:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Liao Xuan <liaoxuan@open-hieco.net>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix performance regression with completion
 batching for Hygon processors
Message-ID: <20261106105434.GB5905@lst.de>
References: <20261103063249.3212198-1-liaoxuan@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103063249.3212198-1-liaoxuan@open-hieco.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_025438_534183_1C030D62 
X-CRM114-Status: GOOD (  14.84  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:32:49PM +0800, Liao Xuan wrote:
> Commit 4f5022453acd ("nvme: wire up completion batching for the IRQ path")
> introduced completion batching to the NVMe IRQ handling path. While this
> change brings performance gains on mainstream platforms, it causes a
> severe random read performance regression on Hygon platforms.
> 
> The batching logic defers CQE processing until after the doorbell is
> written. On Hygon microarchitectures, this specific execution order
> accelerates the NVMe controller's interrupt generation. This leads to an

Why?

> Instead of hardcoding a permanent revert, introduce a flag 'use_comp_batch'
> and disable IRQ completion batching if running on a Hygon CPU. This
> preserves the performance benefits for platforms that favor batching
> while restoring the optimal single-completion fast path for Hygon, and
> provides a scalable mechanism to disable it on other affected platforms
> in the future.

No, these kinds of platform specific hacks do not belong into the
nvme driver.


