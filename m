Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F8BCDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlKcsQW08f7wS5oCE30WCfk+aFZs2vCRfqV0C91RGLA=; b=hw8lbp/S2KJJXvjv34fwkjhRel
	ApA/2Eui+NweIQrlrOX5QLQdE+Je921K/V43kBTsU56w6oOV3NMI1OeQy2ee/Y3eu1A1h9Jt5VUx6
	5DpHpRdGCZal9Dq1TQQP5aHFxMf/PXJ6bhgtYzvIXKj9H33/TIcYqEKf48Gu1tE3aGiebydcn5UoQ
	UIW4dWBEyafBZMEiE59Nns+YIcHODKOUVbYurPBRtluFCbMCXJRw/iag1U0j2pPaU6KJ+wpVizIwG
	b7oasHY/Y1l7UJpmBBbCA2lZY5fAF00LRRtDBzCgkVM2m5a9O3+N7FdYZxBDFN+wCK+lmo63u6nMG
	mKKIR4hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsSX9-00ALe9-1k;
	Mon, 16 Oct 2023 18:41:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsSX7-00ALdY-10
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 18:41:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6B7F261121;
	Mon, 16 Oct 2023 18:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DAC433C7;
	Mon, 16 Oct 2023 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697481700;
	bh=4lLBztM/xqv8MyrTOgkSgKcP2BzPDhrLJvms1pcmm50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8ovcYnalVcdKBkp84orNs+pZE+ZWUzik3f9rQoZqsY+CeBfcdO3Gvcpm9bELelxd
	 JzhNxOQ9djLJZZFhqBYP4xDxiQhTaZe9zR12Gap5QiK9ew/Jh/UTJXtE0UcQgB3adp
	 EXVQ5Bes8tScK2YuGeUXEYiwfXTsFWAAvjIeWvv90/gqZNE+p+1Z7gBCxIA1igriEu
	 zDTQj7ZlKdeGl2yPnwR7JxVfmE6eFgN0p25nQUaFRjrd++Q0D94DRPLugUTZ971oS4
	 OekCDSgosnjbnO+Dv1XPdWseEClHst9u9VB08Jfo1CLeIJQKFUpszeuc1hoNhG7Ltr
	 WNSefOdr+6k9A==
Date: Mon, 16 Oct 2023 12:41:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016060519.231880-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_114141_394168_7EAB2143 
X-CRM114-Status: GOOD (  11.51  )
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

On Mon, Oct 16, 2023 at 11:35:19AM +0530, Kanchan Joshi wrote:
> Passthrough has got a hole that can be exploited to cause kernel memory
> corruption. This is about making the device do larger DMA into
> short meta/data buffer owned by kernel [1].
> 
> As a stopgap measure, disable the support of unprivileged passthrough.
> 
> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
> following patches:
> 
> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> CC: stable@vger.kernel.org # 6.2
> Fixes: 855b7717f44b1 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Applied for nvme-6.6.

