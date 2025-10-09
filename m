Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FF8CCD183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdorPvjo+aUSFxUSyHzahMdzIHyJ4cXzVUVBTnG0Sog=; b=M2Ei3sBCEq7jHj1tO/s3IrEnMu
	RHvDU9I+YmbJdzOe+mWpa/z+5SX7U0RzloCUlEUVwE433O+PClHuRAXHVKYum1Ps7MnOeGp/Bmjy0
	FWH3+rLhX4MWIuexIAsEEIr8FyRkvCYUyCE4pUejLwEFNT2s+M0R0dZXrrkSQF4tpbCJxAJ9oADUG
	Ml6jdfuAa5YXR6wd9/hXQVvpxZYWrBcIQdbThZugTJ1p7+aFv1WNvsdC/nfJwWn9IKEosw7AqcJZI
	xefvsKcGEk/bQi7bFbrmoP8p3euIDrJeziiplqW2cfUZW1t7jPi7vf/nOEyFNEo4yJxh+jhbZUMKw
	XkDjYxbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sCp-00000006QXx-12uY;
	Thu, 09 Oct 2025 15:05:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sCm-00000006QXc-2yzs
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 15:05:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E46564510F;
	Thu,  9 Oct 2025 15:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF4BC4CEE7;
	Thu,  9 Oct 2025 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022319;
	bh=+PfzU55CzMRWuC5DZTzFvraslKE+s/HjnZAQ9HgA+hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT5m/GGBcj8AI5oW3x3/YD+0FQK25YLW4Hn3evhC8Xsbwo95t2oX5j6sP/7x09B5K
	 KQ/UcYlsRVJfCqf7HZaxtNEYGpkCGYxvtlUfcwF8r+fRQ8qKTWpYeK9Kj6ShSSSyDb
	 Q1JDzS/9KxmdBLHb1JJ8aSrYuqqWpig8tK9VcvvEoBVuHOyK1fDanWe51Q2Pi+BuZM
	 q0GoWa/PGujm+8SRRv/KyQ8qrB7jXQlR5w2MRwSFS7EtE6UfZNCmDdp4d8sNd+boBB
	 RxRLJsmDbw9L+EfyXEd2v9s5SGPhwDmUa33XmTvVdp0udaRxxO1E8cspPhz0s/8181
	 fIIbmZg3tE8qg==
Date: Thu, 9 Oct 2025 09:05:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
Message-ID: <aOfPLXJlQwu5cas0@kbusch-mbp>
References: <20250909112121.682086-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_080520_795030_71D69D2F 
X-CRM114-Status: GOOD (  13.48  )
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

On Tue, Sep 09, 2025 at 01:21:22PM +0200, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").

Thanks, applied to nvme-6.19.

