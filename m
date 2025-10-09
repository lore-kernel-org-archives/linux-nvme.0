Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CDCCCD183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=18v3doqhdziIKfEEYBVSIdMYkXXeDhdBYls3R4kKri4=; b=yvHsqOeZvhPNG/uHMCzOPAez7a
	vyUnd9GhQEhO0jEet3h5L5sl7/zuajKdozmRqT7QDfob7YGl719ILqb+NoB2U4hx8fhv4MMCNFB49
	ZsxXZzSjLnowQWdt3d+JsAdVZOHJnTVKCmMTUj7TygegrbN14PIddwjkr8ezmbFB9FxKwFGX/nK69
	VxDxvAdlMnrhHpJocWpH5aOtg/DVW1NNYKOACqOvLuLxkhlhSWytYkrRuAHORvMzkB85u0DTfvYwW
	5UUtKmgWG79DOeCP3Bd0RNJS5n36NTVwSBdzwS7sRdB4QAmZitc5ebkXl6rW5FOu7803/4Sp6Lvp4
	LGjrtg2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sD7-00000006Qb1-0M3W;
	Thu, 09 Oct 2025 15:05:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sD5-00000006QaW-1ZQO
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 15:05:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8292C6231F;
	Thu,  9 Oct 2025 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5588C4CEE7;
	Thu,  9 Oct 2025 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022338;
	bh=18v3doqhdziIKfEEYBVSIdMYkXXeDhdBYls3R4kKri4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dcz5/b3RboK8P2Md8DxvKz/KDk/j7TaDBCnll9fGVOyOE5dA3AdrBP2HtrR3tFoLB
	 2L9KChrb5bpp8vgJGuyxLYmuDYhay/3iCfWAk/YQmi9YJXkq/NMfikaYb2gc9azsfw
	 uyEqXAiGu103HnenLy5L+I0pCSFYGytSySp/3u+2fTE7rWlCNUb6iIKaWL5xg4MU6q
	 eBMM8uMf0HCq0v4qhMelZdFLG5Ft/I0gjbPZSiif/TvTVwWgA73qXglnlA5NsUeHES
	 2BrBw5f7Zucc4mnH8olp5Dh/GgawLnJBCx1+MWKSdrLkh8tdl/AedRXiG0PTLjjCwq
	 eLcq5C2MBCF3Q==
Date: Thu, 9 Oct 2025 09:05:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] nvmet: pci-epf: fix DMA channel debug print
Message-ID: <aOfPP5m4R1M_dM81@kbusch-mbp>
References: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
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

On Sat, Sep 13, 2025 at 03:53:50PM +0900, Shin'ichiro Kawasaki wrote:
> Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
> print debug information about the DMA channels for RX and TX. However,
> both calls mistakenly are made for the TX channel. Fix it by referreing
> to 'nvme_epf->rx_chan' and 'nvme_epf->tx_chan' and instead of the local
> variable 'chan'.

Thanks, applied to nvme-6.19.

