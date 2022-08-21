Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FF5C32789
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mf77CmjWV4kQHHK45RCXHm5xMsQH/lVHeyNvJtsn8uo=; b=tlljuZ0GAqkmfZ50iFptoJOBzA
	vq+LwAUNau/ZQW1XIpigCGZHS0WfyqB5l28CgY6yADVZOmHvKc6pFIY1LZHWmi7n2iROCrtTOCfcB
	41wnuSBWKCyf44c6tRhpzwHNRQouR3hCxhYFosdOKyZvirCAHha91/MKRggkLu4HjVeW7+R6Z6pFi
	gmG6Atal3pp+5qvVo3URqHRTq/aHYx/evULbA72xAQ9vy0cyNU9JjS8jZv7C4niO73ueEWQqHYdto
	a2pVq64cfg47e4SMxzkrglwKEmS1i8PPEsdPeDoGiu4mpJi9tl3x+6ynch2jMC+YiMdnYHBnHWkki
	KMDsH+gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgcy-008NBP-7A; Sun, 21 Aug 2022 08:48:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgcr-008N6F-4S
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 08:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661071688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf77CmjWV4kQHHK45RCXHm5xMsQH/lVHeyNvJtsn8uo=;
	b=I9xHY+c1MTCvb2aNpVUrdno8BzXJBg14TR9cJ+WUKb3Qm9CNBCSp6UwSysh0GqJDBebtQo
	29JL+GWgzXdxVOO02eOSbk96dRuNhbrkRWAB8e9wBY4Wx0Ae72hUO3xNsFHAgnrZ7jx4ww
	B9/IZvl+bTiw/bYsvVwYk6nahteDLVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-s63PZXLtOqmSB8KBSXABbg-1; Sun, 21 Aug 2022 04:48:04 -0400
X-MC-Unique: s63PZXLtOqmSB8KBSXABbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43F2585A581;
	Sun, 21 Aug 2022 08:48:04 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 727139458A;
	Sun, 21 Aug 2022 08:48:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] nvme: make NVMe freeze API reliably
Date: Sun, 21 Aug 2022 16:47:53 +0800
Message-Id: <20220821084754.340585-2-ming.lei@redhat.com>
In-Reply-To: <20220821084754.340585-1-ming.lei@redhat.com>
References: <20220821084754.340585-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_014809_709436_FEA1A734 
X-CRM114-Status: GOOD (  13.30  )
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

From: Keith Busch <kbusch@kernel.org>

In some corner cases[1], freeze wait and unfreeze API may be called on
unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
freeze APIs more reliably, then this kind of issues can be avoided.
And similar approach has been applied on stopping/quiescing nvme queues.

[1] https://lore.kernel.org/linux-nvme/20220801125753.1434024-1-ming.lei@redhat.com/

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r

Add comment log.
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 16 +++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..fe4ae3616ed1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5028,8 +5028,11 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_and_clear_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		blk_mq_unfreeze_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -5040,6 +5043,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
@@ -5054,8 +5059,11 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		blk_mq_freeze_queue_wait(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
@@ -5065,8 +5073,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		set_bit(NVME_NS_FREEZE, &ns->flags);
 		blk_freeze_queue_start(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e..702ba19b5647 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -484,6 +484,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
 #define NVME_NS_STOPPED		5
+#define NVME_NS_FREEZE		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.31.1


