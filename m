Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DA7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 02:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TBXUC8CWhlsnFD6bFJojEWOgtmzktmNzWCUUu+o2nVE=; b=tmIQsTeS/PwTVyHr1bhorzOhBg
	GolvImUsIJSuVKt8KxeccOQa4B5OnVd3Fhs+N57y5HdSVQi+Y5sjrpy9s7U7/OLcB/qrWnhQzET5T
	1AAeJ/ZAEro1xhiZejwKKB+xiBDmiH6iNFJm0f253APA3tHh0bvJaxhsc4dqKNyCf4xOU24Q//LBx
	foMgHt9kXIV5ccscqo6TjUgYhOLRYy1kpWDAOv+Cvuzol90LalC68Ot/3X8fIXrHLo1Qo4a5CaLt8
	uCLrad29E9eUVFwhE7A4as3wNdLtEvqM5wTG0gtTXmRVXqlASEJCOQknF9IuG10ngdX/zLunTFasU
	kkUqteaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWUMv-009jiN-AQ; Tue, 22 Mar 2022 02:35:33 +0000
Received: from out199-5.us.a.mail.aliyun.com ([47.90.199.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWUMq-009jfv-Rx
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 02:35:31 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xhao@linux.alibaba.com; NM=1;
 PH=DS; RN=6; SR=0; TI=SMTPD_---0V7tl0.B_1647916519; 
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com
 fp:SMTPD_---0V7tl0.B_1647916519) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Mar 2022 10:35:21 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: make use_threaded_interrupts mod-param read-only
Date: Tue, 22 Mar 2022 10:35:12 +0800
Message-Id: <20220322023512.98644-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_193529_207869_B91A795F 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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

When I execute "insmod nvme.ko use_threaded_interrupts=1",
I find it difficult to determine whether it is successful
or not, So I want to add read-only parameter to
'/sys/module/nvme/parameters/use_threaded_interrupts',
When insmoded successfully.
    # cat /sys/module/nvme/parameters/use_threaded_interrupts
    # 1

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..27cd20130021 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -44,7 +44,7 @@
 #define NVME_MAX_SEGS	127

 static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0);
+module_param(use_threaded_interrupts, int, 0444);

 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
--
2.31.0

