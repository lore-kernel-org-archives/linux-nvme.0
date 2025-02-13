Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD3DC021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zUXvjP767giaxTFqRmiZwy+k89Vuvu73PWlklX0vYs=; b=pjoSUGwjo5PoTrNQ2E/xGGXYNe
	Q1TNPJjh28Qe1apnvwXU+eYKTy8yD8rb2/ZyGrz0Nk06q8UJnlTb8IQCMlbsww15Ef3SbKFnYIUO/
	BevbzO/OZbD/MISjGo02US9uPS/i/cy6/xCZ/A4Kj3s7wAI3lnF2aosaVexDuol3uVycGgV1NV+LK
	jClOn8S7FSXCmH7sY86tfsIKTTRHYNkPodwIGGrFwB5jqf+VBv5WwqcVLMkGhwZnyORUS8p/vQdBt
	Mp5d/a7pSUaTYE/wpac4Av5XgJQTYtDemM+oMwLKJoF9/BkPgGtoDirh5/KSz0SdWq9mXMhBW2sRY
	91VggMdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSFP-00000009rf8-1dFT;
	Thu, 13 Feb 2025 05:58:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSF3-00000009rc7-1mRs
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 05:58:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 364FF67373; Thu, 13 Feb 2025 06:58:25 +0100 (CET)
Date: Thu, 13 Feb 2025 06:58:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI
 P2P DMA
Message-ID: <20250213055825.GD19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me> <20250212170444.16138-3-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-3-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_215829_602979_3976BC24 
X-CRM114-Status: GOOD (  16.05  )
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

On Thu, Feb 13, 2025 at 01:04:44AM +0800, Icenowy Zheng wrote:
> +	/*
> +	 * Controllers may support a CMB size larger than their BAR,
> +	 * for example, due to being behind a bridge. Reduce the CMB to
> +	 * the reported size of the BAR
> +	 */
> +	if (size > bar_size - offset)
> +		size = bar_size - offset;

Nit: use up the full 80 characters for the comment, and maybe switch
the above expression to use the min() helper.

> +	if (!IS_ALIGNED(size, memremap_compat_align()) ||
> +	    !IS_ALIGNED(pci_resource_start(pdev, bar),
> +			memremap_compat_align()))

These compat names looked odd to me, but it looks like they are indeed
the proper interface here.  So modulo the little style things above
this looks good, thanks a lot!


