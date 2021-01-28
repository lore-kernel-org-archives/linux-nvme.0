Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B30C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 03:34:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9309060235
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 03:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9309060235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VKLlamjXSWIzLdH+kds3utnidb0TwlUJZCH60enRTMk=; b=rtXbXJCaMZHGo4SnepNIbQ+Z9n
	gPgtHKMSzAHCGSI+37XvcELMoWKEaNti/MrOWwqTUGKlI9Y4Hs3i39Qxys4k7HnrlwWHu4JPwgaW3
	/FvGHhA1p9hrDMWxu3wEst4eIdJIwJaGDijx3m+Br5YK2WvzS2IZlowO9wy8emDnG74lwzcNdM1aA
	y/PwkEaMF96WbaESTHdwwDkh0y1+XhDDckk+YJgXwUdUEd8mQ/JD0fjL+/5r1Q/8ssUXkhwwL2/p4
	mVUQ60fs3NsY7f7I49fTaWW058jspiy+UPx3P8Penpo3S28tyLWJQCqyP8X28ikCjNxvJ4+KcfTmh
	MxgO/+yA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4y4J-00066Y-3g; Thu, 28 Jan 2021 03:34:03 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4y4G-000669-Cd
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 03:34:01 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DR5dP4z3Cz15ykp;
 Thu, 28 Jan 2021 11:32:41 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 28 Jan 2021
 11:33:51 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-core: use list_add_tail_rcu instead of list_add_tail for
 nvme_init_ns_head
Date: Thu, 28 Jan 2021 11:33:51 +0800
Message-ID: <20210128033351.22116-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_223400_706470_1D9E32B7 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The "list" of nvme_ns_head is used as rcu list, now in nvme_init_ns_head
list_add_tail is used to add ns->siblings to the rcu list. It is not safe.
Should use list_add_tail_rcu instead of list_add_tail.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8caf9b34734d..f13eb4ded95f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3829,7 +3829,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		}
 	}
 
-	list_add_tail(&ns->siblings, &head->list);
+	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
 	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
