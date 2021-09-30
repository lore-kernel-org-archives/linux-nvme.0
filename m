Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3E06124B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B3E06124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/FpmYxVLdXkBIltHCDsXE1yUOY3D4nGGikg0KAf7GBs=; b=ZVSJivEJmWIYpE
	Fs9LeHRS8YY6usyBG+aagmBdsugg0lmwmqtDymUegJfnxTR2tdVPp2mokaIQ/M4sFW/32f96m7WHO
	5guDW3T2Nk28GlwzUWAIK8/gJvmpaAtMHzjXtJ0TeI695rDODnU8IqnVxPDvuHBp5lvqPfNJ/vG0X
	AKHLOVCjPCaUBhql48HeWD+D0mxXggToBuLgDHGLre4mO6PEi6QoJEHNHTPaMjn1QVUlQZX8X+I9H
	HKEcGd2yZMmDY+yELfBROkQ7GUZ/loOG0DZNFSfYb1smNN/+gyU+5NwQgNLjYH7r1t5LMEy+VL79H
	OJ5DjMFE1jpMm62sjvkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVvcr-00EJvj-1Y; Thu, 30 Sep 2021 12:57:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvce-00EJrh-RX
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 12:57:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633006631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kv5fvG9KZriDjoofQEBWp898Mk3hvdOZp76TKP2/6jo=;
 b=fcwzO63xAWbF2gp0l7R0Ft9YorPWztwsS3JpoWgfbz/4IpHwbuXUdU8/8SBNQBCrLqwaRs
 NCR6YXXgBoeOAvyBNx8Fyh/XKh0rZV/lcce4ayMsz8ZOm/+iok2B7Rm54pEnq+MGaBtVEk
 1xc1P0fhEURDM+2dZkK48JiNfGk3WNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-nYsoULG-P-GNKoJ9w8m35w-1; Thu, 30 Sep 2021 08:57:08 -0400
X-MC-Unique: nYsoULG-P-GNKoJ9w8m35w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCDA31006ADC;
 Thu, 30 Sep 2021 12:56:57 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 561D6843C6;
 Thu, 30 Sep 2021 12:56:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] nvme: prepare for pairing quiescing and unquiescing
Date: Thu, 30 Sep 2021 20:56:19 +0800
Message-Id: <20210930125621.1161726-4-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-1-ming.lei@redhat.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_055713_003197_B24904B4 
X-CRM114-Status: GOOD (  14.27  )
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

Add two helpers so that we can prepare for pairing quiescing and
unquiescing which will be done in next patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91d91d4f76d7..23fb746a8970 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -119,25 +119,6 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 
-/*
- * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
- */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
-{
-	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-		return;
-
-	blk_set_queue_dying(ns->queue);
-	blk_mq_unquiesce_queue(ns->queue);
-
-	set_capacity_and_notify(ns->disk, 0);
-}
-
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -4469,6 +4450,35 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+static void nvme_start_ns_queue(struct nvme_ns *ns)
+{
+	blk_mq_unquiesce_queue(ns->queue);
+}
+
+static void nvme_stop_ns_queue(struct nvme_ns *ns)
+{
+	blk_mq_quiesce_queue(ns->queue);
+}
+
+/*
+ * Prepare a queue for teardown.
+ *
+ * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
+ * the capacity to 0 after that to avoid blocking dispatchers that may be
+ * holding bd_butex.  This will end buffered writers dirtying pages that can't
+ * be synced.
+ */
+static void nvme_set_queue_dying(struct nvme_ns *ns)
+{
+	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+		return;
+
+	blk_set_queue_dying(ns->queue);
+	nvme_start_ns_queue(ns);
+
+	set_capacity_and_notify(ns->disk, 0);
+}
+
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -4547,7 +4557,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		nvme_stop_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
@@ -4558,7 +4568,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
