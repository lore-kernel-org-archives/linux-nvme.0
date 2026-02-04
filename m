Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F4E9D3E2
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHTzhkxGlaYvoHferihGs6XUw4hXEp48K4M0bawC+zU=; b=zRuqEhLvCVTJf1B4X/odLAl2NS
	Oi184kWQSeEoe2Lok/5KZezAOgOFS43JIBCzta3xS8kW0VN4IKdG7ygMr2/N66v4XCesPPw2fwuC/
	BsOZdjOuwYOBZni8GYFoFoJHOAvm4sTp6pbm/SZ8wq1KWdg7z6lNapoqGyqr0ZZ6Po/1suWC4zahE
	3DFMSZBexc4p6uqZnXbrSz6lNqV9lNs/ZLA8mrQxz1HUdRQGPOOs5t8ATGjept030S5bvZotXwy0l
	3wx1ho5VA2QU8cXJi+l3irer2OiGhYJjPAPghZdH/pCVaCNA/+PUDU+U0ygOY80ie7UgfWBUjob88
	dUzbBt0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndrH-00000008ai1-1SJ3;
	Wed, 04 Feb 2026 14:27:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndrF-00000008ahp-2CUP
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 14:27:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 883C46012A;
	Wed,  4 Feb 2026 14:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DBC4CEF7;
	Wed,  4 Feb 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770215272;
	bh=bHTzhkxGlaYvoHferihGs6XUw4hXEp48K4M0bawC+zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkpgufGwl/iuwN7lb8qU2AMlPNNy4tRtgXBoWjHkuQEC/nB/Ta4cafuOA1HmWjtvo
	 kZ3F5CQJtfto/dPD7FusyFK98+bt3Qa7aFpArfws624QtwI2CRJcfgmTAIrZENkBO1
	 mov13e4eCJCVoirnSw2W6t6SP94dcnDmq93zOw/fhWxnB4Y+8JJ6F3g4Yw2yH3BGK7
	 3KhGL1ZDu6JenXB7LLPxvfZVzqM3naOVjJiEV9BPgZ6Ozu75Gxneadx4cDGRrTnZJe
	 1YlPhdWdWmJ48U9XAH5WsjyJreqCDQVWFGJWgRdl0gwzieVd3EZrtnMPVjJ2o1H8CI
	 gYJTvm3PSCPBQ==
Date: Wed, 4 Feb 2026 07:27:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYNXZTu_L5AcFj3i@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
 <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
 <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>
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

On Wed, Feb 04, 2026 at 07:34:42PM +0530, Pradeep Pragallapati wrote:
> I ran testing for over 20 hours and did not observe the issue on my setup.
> It appears to be helping.

Thanks for for the test! I'll put a real patch together with Christoph's
suggestions folded in.

