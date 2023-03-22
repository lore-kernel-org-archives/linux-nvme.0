Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB6C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=o9vmH63KcTpnrSmpZ/P5x+82c3
	KbrQpIuW6MGiAiZMULXFmG7MyKk2swmMuowFPy/jvRGgvAw1s6lRTg4s+jeF+XAhf7klEuzkWV9pq
	dwHSfDb4+JYeoIViIMInLn3h6vWeZwJcktqXpkRqxNrA+G5DpZTH07BUyoTBu8r24+srkae4yIqgo
	iD9m6wl05TnFWAL34g7hyb0BedtKeExzh/HpooWTbLY7sJP3GCwUtKejDaE3r1KMeuBhEQTaKRpzQ
	7BqnFTRb8fefOktZOfQt5mUoZCAXTGNOMeLi8I0FB3bKGilfzYhcCvFrBZ8NGJA2HfadGuARb6mPF
	sUx0UeQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peti4-00F9Fo-03;
	Wed, 22 Mar 2023 08:20:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peti1-00F9En-1h
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:20:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8245567373; Wed, 22 Mar 2023 09:20:34 +0100 (CET)
Date: Wed, 22 Mar 2023 09:20:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to
 allocate an io queue
Message-ID: <20230322082034.GB22321@lst.de>
References: <20230320133334.57325-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320133334.57325-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012037_711001_07405FE2 
X-CRM114-Status: GOOD (  10.25  )
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

Thanks,

applied to nvme-6.3.

