Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D575606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nq0EaNOy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPykGLk2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S3C4PF2NhTXtOwd86DNKzdZ6H+3X/Jp2dMuy9ZXfI48=; b=nq0EaNOyHNh4uAzBBlwfKsDcLW
	kX9rwtPQY8xgnA9oAl0gBwaG1iMNwsx4AQfTSLZIsX678vIWTqCb3CK9YitCMi2e9p1XiLavvj1HP
	pIfUNrS4qK6AqBgYZLwmmwJR7PetWi2hzqZTYQdPuge4pTadRtTt6+KYeDm98V0bBBG/Q3RpH8zRw
	ISgzMQLiDyvO/utt6HeSVLmg3JE6N4XO5GA9YXP2IJax5ZwK/WbYFEhf3lOuJQ6ETaFgLjQb50lRt
	8NJlIActTtK1L2hnOY1Nt5NEA70ucDpseIM3FL8cmlrK4HsZx1PLWCO8jh48CAEWJ5n+NVTUP11w2
	r0PL1L3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2px-0000000AIIV-1vTm;
	Thu, 05 Nov 2026 19:09:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2pw-0000000AIIM-0ixv
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:09:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DD22600E4;
	Thu,  5 Nov 2026 19:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42501F000C1;
	Thu,  5 Nov 2026 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905763;
	bh=S3C4PF2NhTXtOwd86DNKzdZ6H+3X/Jp2dMuy9ZXfI48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TPykGLk2V8AFxU8ceCJzw5TrdoQQ40JzCPcvUX54d8+j9Xz6RlklXpn2EFGX5sbh/
	 DZaahmDw9RRGrpXt+erL4W+oskf6qSTu5uJXYyxETilBviY33tAUQv3JmHyZvWeFX6
	 k8WOCTmH8RaLNRVrqYO5GcWtkuQzjEzxcJhee97E55jGLecqJ6Q386aodjLomyS1kZ
	 RsTlPtvAtNCOhHg2w79kY/x2o4fetr+Ge5rEdN26ofXGdVxm+FZ4OaSksr4xnWrPCB
	 xaplOh0DkoRI4rmoBcbIfbV6w36egObtDFP6Hz6Emp+ofmwJ/4NbZOBnRloaGgp73U
	 Gwjfk1SvNHFFg==
Date: Thu, 5 Nov 2026 12:09:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <auzUYZxQYkprXuIz@kbusch-mbp>
References: <20261105182706.3700908-1-kbusch@meta.com>
 <20261105182706.3700908-3-kbusch@meta.com>
 <sashiko-outbox-199778@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-199778@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:36:52PM +0000, sashiko-bot@kernel.org wrote:
> When pci_channel_offline(msi_desc_to_pci_dev(desc)) is true, doesn't
> pci_msix_mask() now unconditionally execute readl(desc->pci.mask_base) after
> pci_msix_mask_noflush() returns early?
> 
> Prior to this change, commit 2e2f69fc8ae2 ("PCI/MSI: Skip MSI/MSI-X
> programming while the channel is offline") added the pci_channel_offline()
> check to both pci_msix_write_vector_ctrl() and pci_msix_mask() so that
> pci_msix_mask() would return before the flushing readl(desc->pci.mask_base):
> 
> drivers/pci/msi/msi.h:pci_msix_write_vector_ctrl() {
> 	/* The Table is unreachable while the Link is down */
> 	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
> 		return;
> 	...
> }

Oh right. That check looks fairly recent, and I missed the merge from my
older version resolved this incorrectly. I'll respin it. 

