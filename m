Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB68ECA5FDD
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HgyQa4vV1rNlqqw4iwuB9Lp9hrN+ZpCfzbiYv1PZxG0=; b=N7APsBxeavBKjJSgkds9OIiSKH
	xyvHFHKnJg2gWMv0edlGmJz9qzA7J7AlziiXcyccgyi8PUtLRq5Xg03XmnVX85FG1VMxdCW1piJvT
	qopm4w0aYLYf+TqbhMDtRnZgXHb6Se8Zhr1oVazZ53rZa36OSJQtpTJ5h6j7vSlASFuxGaNdWrkCy
	hTHWSiAhr7QhCanqPXGdREY0zghWDfkVg+hw+YvqUtfH8T2wpgwB38Tb0CgWGQ0mXVE5bRlT1FsTT
	XYHDOiAGtl+jwHuXix6WVqGRbMVCsDzxTTNsqlUi9C1J5u4s2+WfpuV/nPG+dsupRJiVXuHxxyndW
	vKm2e3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvZ5-0000000DDym-1Wrw;
	Sat, 03 Oct 2026 08:57:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvZ3-0000000DDyb-3QBa
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 08:57:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D9C20602C2;
	Sat,  3 Oct 2026 08:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8731F0089B;
	Sat,  3 Oct 2026 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017872;
	bh=HgyQa4vV1rNlqqw4iwuB9Lp9hrN+ZpCfzbiYv1PZxG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dY7pxJ6q/KIZnEdOm9B5BBcrxm88s4CLtrHiZvlVPmlEdxJa9ZritNXBrGfPaqmJH
	 FqbQVQ2/6rahM9MQyY0hoVaP8sBSlg2D36nOdmydB851A8EG05+5CH/v6tG/J9uwFG
	 S0FSAT5yh1LiEcrZhMaSbZmevkWSd8dLMnC402hMnM+9HJG3KW/kgOpIk7jaUXFB+2
	 qgGawtbtjgjpkbSkMlds8jE3IfDfYuRz9NeIuPkM9lOr5WVQd8rV1uCHrsvcvA42ID
	 jbTSYSpF/B0xYy1p9jXKHPJ1vzpR80/0wzBemX06PE9Bb9tSVSPLAUIAs349w6JU8i
	 iahCKJ8u74xuA==
Date: Sat, 3 Oct 2026 09:57:47 +0100
From: Keith Busch <kbusch@kernel.org>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH] nvmet: use the local P2P device on metadata allocation
 failure
Message-ID: <asDDi5Fmgsh1JWEa@kbusch-mbp>
References: <179075213853.3.11747926147721077082.idr-bug-90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179075213853.3.11747926147721077082.idr-bug-90@gmail.com>
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

On Wed, Sep 30, 2026 at 04:08:58PM +0900, Sang-Hoon Choi wrote:
> nvmet_req_alloc_p2pmem_sgls() assigns req->p2p_dev only after the data
> and metadata SGL allocations succeed. If the data allocation succeeds
> but the metadata allocation fails, out_free_sg passes req->p2p_dev to
> pci_p2pmem_free_sgl() before that assignment has taken place.
> 
> Pass the local p2p_dev argument instead, so cleanup uses the same PCI
> device as the successful data allocation.

Thanks, applied to nvme-7.3.

