Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C89C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VSK6BWlet+DoVtcjwj8rjXz2BRKlc1Zulmd3773o8k4=; b=B8IHys2x65MBXCeR/S5odyEAZE
	JD2XkQWt60AMQ/CBAML3OC7rRU2WSn/CzqCIIjz1yCjHzpcNv0E1LtjFv6PmjlCjiQoXPrdvyzEE9
	pGR0d7+59H3gRbOOL/JTaFyghaB01xUs1zWiPz7hGhcaCTjciI9ew5lEToxGANM0+IeYk9P4hJ87V
	88Qqzh5VS1p3VE75GzFF+TR7ry1eOXtEcV6mp6CmDPCvHOM9pXbDiacF42LBiBiRMiT1bsRyGns/f
	I2X0WB1W38TYg7e3w8LkMrdK8VnnRIezvT6G7bzqmgtggRUw+tOzmM+DaadAxCxrvYxVodOunmDsx
	2DB3MDRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mregu-000WTi-3Y; Mon, 29 Nov 2021 11:19:24 +0000
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mregq-000WS4-8Z
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 11:19:22 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423;
 MF=zhangliguang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0Uyht2tS_1638184736; 
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com
 fp:SMTPD_---0Uyht2tS_1638184736) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 29 Nov 2021 19:19:04 +0800
From: Liguang Zhang <zhangliguang@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] nvme: duplicate NQNs check if devices needed
Date: Mon, 29 Nov 2021 19:18:54 +0800
Message-Id: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_031920_493845_D62ACA6E 
X-CRM114-Status: GOOD (  11.21  )
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

If a device provides an NQN it is expected to be globally unique.
Unfortunately some firmware revisions for Intel P4500/P4510 and some
other old devices did not satisfy this requirement. If devices have the
same subnqn field, after a kernel upgrade from 4.19 to 5.10, if a system
has >1 affected device then only one device is enabled. Error like this:

nvme nvme2: Duplicate cntlid 0 with nvme0, rejecting
nvme nvme3: Duplicate cntlid 1 with nvme1, rejecting

In these circumstances, if subnqn did not begin with "nqn.", we assume
that devices did not need subnqn check.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4c63564adeaa..80abb4526932 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 
 	lockdep_assert_held(&nvme_subsystems_lock);
 
+	if (strncmp(subsysnqn, "nqn.", 4))
+		return NULL;
+
 	/*
 	 * Fail matches for discovery subsystems. This results
 	 * in each discovery controller bound to a unique subsystem.
-- 
2.19.1.6.gb485710b


