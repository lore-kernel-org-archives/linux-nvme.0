Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD2C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E295E2065F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CYgUvuv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E295E2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jvu/Y7xApeTgccpC2I/jr4kP1Y2oixpYMeU5BgWGVD8=; b=CYgUvuv+TR5r1JZcu9K/CHnd2w
	VUGKU8SnxURh8atDFuAVXY0PfQk4CE2ioSF23jT2bWLVoxN752oqg8+7ukVZ71l7dzjiH8vydD7QL
	YJ9wLiyIEGGV/A3g7GYuSUwuuH3iTADs1oMjyTvyy3hqKln0QViYe7V/aHPP/eTWQw+YftY5vYSIC
	0N0uvtlH15VFYTMpgSjFhevKxAeOGxJmDBTaOWyvaWdvljmQITv7da/Zxmq4QTXYIRkr0ewOYQkzg
	B/VBbmjnlFtEtcAES/AUobTkcEAcaRDU9d+ZV3soUhbPLwP22vcg9YsrAbB72uTqAaIQeLDtNMFfC
	880kpn9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyBBN-0003Ts-P1; Wed, 22 Jul 2020 09:37:01 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyBBH-0003Si-D7
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 09:36:56 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 66CAD1FA07FEEEE29C1C;
 Wed, 22 Jul 2020 17:36:44 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 17:36:33 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-core: reduce io pause time when fail over
Date: Wed, 22 Jul 2020 17:36:33 +0800
Message-ID: <20200722093633.31347-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_053655_729766_E0B8E6F6 
X-CRM114-Status: UNSURE (   5.96  )
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

To reduce io pause time, nvme_stop_queues use
blk_mq_quiesce_queue_nowait to quiesce the queue, nvme_stop_queues wait
all ongoing dispatches completed after all queues has been quiesced.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index add040168e67..877dd75d8a8c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4323,8 +4323,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_nowait(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
