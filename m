Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F0C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 03:52:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0459460EFD
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 03:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0459460EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yIp94OCE4Q3vPOUBpz4daIAlbikj0wd8igzfeqfdA/c=; b=23dwTzbzrdTbm4
	u3nzbRrd0MRAGoeXimbSgFvzbcw4YNFo/RRZnuXBFO5EmpgjpZJyaLCzNIfdwn1/X76AX7/3JTOMS
	kqHhv2lkbjnGRLaRMqtRfUisHUWn2fK+D/LbuSTGCXQnqKenMGUMkTM0jSP8+ioCZXpPKoaUal71S
	PF4qcVQx7G2hgc17CJdZuqOku9W1Cu5i9U4jAfewRKiqGjQb4A1z8ziiniIYVTSuxXntoU84hoO1Y
	7ke6MRTI8Unx8FcAKVTrzxPBbL2X7NIMSgfUO+Ro6bRfOZYQNB+IXd2gzNU2JO7wMoo2MqSUTgu4T
	dFM++D6vw3iibh2ywOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN5fi-00HClg-Ma; Mon, 06 Sep 2021 03:51:50 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN5fe-00HCl1-RL
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 03:51:48 +0000
Received: from dggeme770-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H2vVc3j20zQjBj;
 Mon,  6 Sep 2021 11:47:36 +0800 (CST)
Received: from huawei.com (10.29.88.127) by dggeme770-chm.china.huawei.com
 (10.3.19.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 11:51:35 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>
Subject: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid use
 after free
Date: Mon, 6 Sep 2021 11:51:34 +0800
Message-ID: <20210906035134.14789-2-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210906035134.14789-1-liruozhu@huawei.com>
References: <20210906035134.14789-1-liruozhu@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme770-chm.china.huawei.com (10.3.19.116)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_205147_091550_A1AE9CB1 
X-CRM114-Status: UNSURE (   9.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We should always destroy cm_id before destroy qp to avoid to get cma
event after qp was destroyed, which may lead to use after free.
In RDMA connection establishment error flow, don't destroy qp in cm
event handler.Just report cm_error to upper level, qp will be destroy
in nvme_rdma_alloc_queue() after destroy cm id.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
---
 drivers/nvme/host/rdma.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a68704e39084..042c594bc57e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -656,8 +656,8 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
-	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
+	nvme_rdma_destroy_queue_ib(queue);
 	mutex_destroy(&queue->queue_lock);
 }
 
@@ -1815,14 +1815,10 @@ static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
 	for (i = 0; i < queue->queue_size; i++) {
 		ret = nvme_rdma_post_recv(queue, &queue->rsp_ring[i]);
 		if (ret)
-			goto out_destroy_queue_ib;
+			return ret;
 	}
 
 	return 0;
-
-out_destroy_queue_ib:
-	nvme_rdma_destroy_queue_ib(queue);
-	return ret;
 }
 
 static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
@@ -1916,14 +1912,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	if (ret) {
 		dev_err(ctrl->ctrl.device,
 			"rdma_connect_locked failed (%d).\n", ret);
-		goto out_destroy_queue_ib;
+		return ret;
 	}
 
 	return 0;
-
-out_destroy_queue_ib:
-	nvme_rdma_destroy_queue_ib(queue);
-	return ret;
 }
 
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
@@ -1954,8 +1946,6 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-		nvme_rdma_destroy_queue_ib(queue);
-		fallthrough;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"CM error event %d\n", ev->event);
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
