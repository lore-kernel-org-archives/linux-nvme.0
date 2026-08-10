Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3705CC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GewiwB3cD2S9Pj1CPghjzYqUEx5Va4tcS488slPahE=; b=1XMxiGG8kUOSwhXhHVByI/afHG
	ibkGvQC7SGp6+eJtzsM/agtPalmAdTy9gP6O+c4krDKQvpoFkp/d1UqyXf3OK7TtswEzseZZBmMvb
	2QuT0CdcdmMC+zUwj8DFT2OqtV3zYjF7LkxK3BEUCYv/vvku4BtCRljLC/4wFrMi4CwNhtJ2xGng+
	vBUnLPaQqCLN1g4+dJOz63zvc/l7rglVgTrAoCjCJ6baiGU47264r6iMjUKW9Kg1MFK1mN9XVhbPL
	NuwlRNtK+lqCPCJEKCV9jnPtcK7VoO8qjbhrP3Q6lpVW3RVfu6HJmeS1OGugtIYCFEalYkYQg5FHp
	mFBp3ppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtU2a-0000000CYUu-1Fou;
	Mon, 10 Aug 2026 17:44:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtU2Y-0000000CYUg-1cxC
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 17:43:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A944A600C8;
	Mon, 10 Aug 2026 17:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6C31F000E9;
	Mon, 10 Aug 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383837;
	bh=8GewiwB3cD2S9Pj1CPghjzYqUEx5Va4tcS488slPahE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEN66RmKw3F66RKHCksMqdMDSst5iEy4V+6tvzBfdkJkxWVjO5OaC4y7bypU1IUk9
	 pSW5bYeDtg6teSWpmbCUOJ9ZalptlbI3oZIVhIF3yVq73jAsUvV6qzrX6jhft3YwrS
	 KA9KxuwL8TdLHTbzAnWpE+9gmhacJQgQUqV93YuEajiKwbJmkMv4Bk+EaaAZRdq5vo
	 Ntjp7+8FQHg10+318e00WtZkP33DkPF7EEUMi2k2f1NVP1048XQ9ICixsCqa6Jmf9F
	 cUen0PjOOv9NqRmdBOS5WowSv8JBOtRn/E4eqSl/4S3L+X9J6rxq/+KiT6StAeEGj/
	 3NywW7E62BVyw==
Date: Mon, 10 Aug 2026 11:43:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yifei Gao <gyf161023@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
Message-ID: <anoN25Z3HHIpijuL@kbusch-mbp>
References: <20260804213626.3410403-1-gyf161023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804213626.3410403-1-gyf161023@gmail.com>
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

On Tue, Aug 04, 2026 at 09:36:25PM +0000, Yifei Gao wrote:
> nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
> reference on the controller and installs the completion queue. If the
> subsequent PCI address-space mapping fails or returns a too-small partial
> mapping, the function jumps to err_internal / err_unmap_queue without
> calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
> gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
> succeeds, so teardown never releases these references. A remote PCI host
> that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
> leaks the CQ and a controller reference on each attempt.
> 
> Drop the CQ reference on the mapping-failure paths. The err_internal and
> err_unmap_queue labels are only reachable after nvmet_cq_create() has
> succeeded, so this pairs the create/put correctly.

Thanks, applied to nvme-7.3.

