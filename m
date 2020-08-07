Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BBC433E1
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1BF2177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zLW5PK9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1BF2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPgz5lz2kJKDI8m6Zb1t4G2oNOqC0uz2uMwi/kdQsXc=; b=zLW5PK9bIP1yfngLqhRwy7zoEB
	ATrA2SSdekOd16trjGG5jEvHbUEp87OEIe/Eroy/9Gcsi3BdM6zU1RgV65cufdqgEiwsLR6YTzg8k
	MAYf/qLihmkpmyAsaPWskMz45nstT8PXbp2q2XWKY2fQS+HZyOOUY7iqIDE9GIv/wW2WrizVJjiSl
	Rhg+TIQHSEI9TXQzKSrrzAE8edhRrJND6woJJXHl6FNUacoGZCKMNB90xp2NaeGfEGoF5x82ZKvuV
	LsR1kDtnj47M82wu5LUO3a20SzIGqvYrf6qA8uudOf5+kviGJN2w2G8QnoHvV9ZaPBYZXsyIT7015
	rv0iZUqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3yKz-0008RH-U1; Fri, 07 Aug 2020 09:06:53 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yKx-0008Po-39
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:06:52 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 619953548C054214279A;
 Fri,  7 Aug 2020 17:06:44 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:38 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2 3/3] nvme-core: reduce io pause time when fail over
Date: Fri, 7 Aug 2020 17:06:38 +0800
Message-ID: <20200807090638.29748-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_050651_897372_84D77261 
X-CRM114-Status: UNSURE (   7.07  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We test nvme over roce fail over with multipath when 1000 namespaces
configured, io pause more than 10 seconds. The reason: nvme_stop_queues
will quiesce all queues for each namespace when io timeout cause path
error. Quiesce queue wait all ongoing dispatches finished through
synchronize_rcu, need more than 10 milliseconds for each wait,
thus io pause more than 10 seconds.

To reduce io pause time, we introduce async mechanism for sync SRCU
and quiesce queue. In nvme_stop_queues, we can first call
blk_mq_quiesce_queue_async, and then blk_mq_quiesce_queue_async_wait,
thus reduce serial quiesce queue wait time. Cancel io will quickly,
multipath will fail over to retry quickly.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4fb702..2716ba89bffa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4313,11 +4313,16 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	atomic_t count;
+
+	atomic_set(&count, 0);
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue, &count);
 	up_read(&ctrl->namespaces_rwsem);
+
+	blk_mq_quiesce_queue_async_wait(&count);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
