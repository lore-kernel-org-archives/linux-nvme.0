Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84631C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBJVgwIMBc0OtKffrPDe5IrSkExe5ZBjgyVhSgX1N2M=; b=Mmy8IORZk3B6jTI9qzz2ZYPy4k
	S86J2QutuKvhQmOb9H1WHdRN4daVfNQWngRLxy1Ykg7uiG03LJ1tlt02LHZUQ/GbFJC1Y752BguTq
	0apyZWnuG8vOg5WVqezUwZJRDzRM9Xsf2rlk1xSalWLCMnaIIdGgD3V8FHtRt0fpLDKHUjqFSQ0F3
	0g54TZT8pBi8vOuedA41ATJ3R4FwFmZ2Qhg3TGO5cT+TWktRhtb2+VEvoRiHLEtdR65veXoGKC5a0
	2f3Mv7f5EdJm7czJUBoZMPgdQpsHiUo2He5KveX3GPOaO2YO1QHDPNRPDC4OJ0UtKd/ELA/fTQd/O
	/6NnRgPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbg-002h1u-BC; Fri, 29 Jul 2022 07:40:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbH-002gkI-Db
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 07:40:02 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvK9y3ZFzzmVMK;
	Fri, 29 Jul 2022 15:37:58 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:49 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<lengchao@huawei.com>
Subject: [PATCH 2/3] nvme: improve the quiesce time for non blocking transports
Date: Fri, 29 Jul 2022 15:39:47 +0800
Message-ID: <20220729073948.32696-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_003959_691976_677819D3 
X-CRM114-Status: GOOD (  11.86  )
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

When work with nvme multipathing, if one path failed, the requests will
be canceled and retry on another path. Before cancel the requests,
nvme_stop_queues quiesce queues for all namespaces, now quiesce one by
one, if there is a large set of namespaces, it will take long time.
Because every synchronize_rcu may need more than 10 milliseconds,
the total waiting time will be long.
Quiesce all queues in parallel, and it is safe to synchronize_rcu once.
The quiesce time and I/O fail over time can be reduced to one
synchronize_rcu time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eabffbc708cd..fcfa27e1078a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4924,6 +4924,30 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 		blk_mq_wait_quiesce_done(ns->queue);
 }
 
+static void nvme_stop_ns_queue_nosync(struct nvme_ns *ns)
+{
+	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
+		blk_mq_quiesce_queue_nowait(ns->queue);
+}
+
+static void nvme_stop_blocking_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_stop_ns_queue(ns);
+}
+
+static void nvme_stop_nonblocking_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_stop_ns_queue_nosync(ns);
+
+	synchronize_rcu();
+}
+
 /*
  * Prepare a queue for teardown.
  *
@@ -5017,11 +5041,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
+
+	if (ctrl->tagset->flags & BLK_MQ_F_BLOCKING)
+		nvme_stop_blocking_queues(ctrl);
+	else
+		nvme_stop_nonblocking_queues(ctrl);
+
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
-- 
2.16.4


