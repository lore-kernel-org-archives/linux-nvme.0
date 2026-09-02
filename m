Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ADAC624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WdTw/vlyD9Hzgb1hL9IPAQTjjV
	riYLi+wS6jIHvADV4KymlE7FpPDiGIIhnSkxGIdDs6C9XCcymkd0r1rxpi9RCZWDaRPQn/Dzwo99f
	tXQ96dUNuSEowhZaeeLvRq17i5jLy/R3egJJkpPtokDlKfFeJTP9pu9mxp52pAac1oJTx6O7K6NH0
	b1UioqVuKOynpjPVDeqqAX18Wl7Rt0O6Q3VXoXrrCYMdzd0x9XLLUUnyeQdY7qTjKfwZV4u6MgEeL
	0wLio2vXDnEkvL414CtCTDYuxwu8ANQuYqSCowk6pWjdYePD+YbqnWu7eJG6udBNUdrvnJx4wvaeb
	W4x7NCUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lBm-0000000EpWT-1jhg;
	Wed, 02 Sep 2026 13:39:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lBk-0000000EpVG-2Kup
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:39:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A51CB6732A; Wed,  2 Sep 2026 15:39:35 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:39:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/6] nvme-mpath: No need to protect req->bio with
 requeue_lock
Message-ID: <20260902133935.GA21649@lst.de>
References: <20260823084903.193188-1-sagi@grimberg.me> <20260823084903.193188-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823084903.193188-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_063940_750514_76579592 
X-CRM114-Status: GOOD (  11.33  )
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


