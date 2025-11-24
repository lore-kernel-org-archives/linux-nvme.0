Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF2CCFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=k4dlKu8hv6icTSZv/ufQvTc7EE
	kWSpLC+t+njOeWixfuI9iZzAwSvlMyVcHLt4nGf34bkYzrMleJA4MjGRgxcgjSpJxRnkztFGERsoZ
	bcGv3PpbZJIqYWODTpGBjCymJ2WnuxFbP91PsU9cEoFu+84O3llBF88yUKfHpIgDeyG9owo46ZBlv
	WqAmDvemyJBZXqY73rZdZpz2VQU9XZAG+Fyl+9F/7wmMFEelasZ9E3SpyIjIW3u4z9IcP9o5y28Cb
	NNOQQ/WgbNb4amWAVB2+PrSVDNBQw0+MPD80kKWPpRIgc4JVrAnyiIpKRCHU/k2/2OONWjeameJdG
	M6Spo6cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNXV7-0000000Bq4Y-2yGJ;
	Mon, 24 Nov 2025 14:25:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNXV4-0000000Bq48-2CI5
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 14:25:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB4AD68B05; Mon, 24 Nov 2025 15:25:00 +0100 (CET)
Date: Mon, 24 Nov 2025 15:24:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: Use kvcalloc for commands and
 responses arrays
Message-ID: <20251124142459.GA16697@lst.de>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_062506_699224_A96A0196 
X-CRM114-Status: GOOD (  10.14  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


