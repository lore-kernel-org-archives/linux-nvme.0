Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F85C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:48:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D43661057
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43661057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xzsk+EcCfpdBXPv8Gi63diamkH6xiEgS/yzIDw4dWXk=; b=ZW52sB5qxpGWCT61Bs6b7Rnm4
	rQ8KgliwkDY6LYHPOiSnT4OpXxwkkoIakr/kWLqOkdaQxDno0wZpl77o9e8S7t5kYmJnvDV/dKZsJ
	vo+F8xNOl4DEibY9Cly8KdxBmUIxoNZHQPOWoNJQB9dZePwT86Cpa6o3zldGWlGk9pd466kLrOiC2
	Zb4wxnHA30zk/6eTZwnLkkAjkLx9YjecO6LDZzM9gaxFo3FyjvW88DC/T/m6aVTiiaOkGEWXwHgGW
	64zyW5uBGZTcgUb1gRfwxb6wHtx5FHnHneCK2ckHxJ1FWd29qLHZk6CxdWQHc9UOrHy6+EqziYkmW
	cpZxoq82w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXMwP-001yVs-8J; Fri, 16 Apr 2021 11:47:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMvf-001yNH-32
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 11:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PjUz+a4ic/EtYrlRA7e3gt0ZwtuKqKnQoSeqKX4fEBo=; b=D2iA0YhxYktlu2u0vpIbY0wAq3
 1f43DT53IDXXbU1AFpqPH2N63xX/vJ+d802GJGyX0IBiFVVL81/AEQNK35CSkujHccTB6xBTIXFwl
 XpwOEDPGTGSDG+XFZ5fdYrMQjGv7CC4W0w43eDopZaPoN4tKf+SeTFayGbiY141Iw5ij6BvDiBfBr
 3LCDdjew0AV1ksbfVNgPWyXsnxPREBfVznBZgII8ihhGgGeF66NN5XFT8xICAqlLBwKsRcwxKf/bj
 rrKO+QGM4sRfKPIn9pMyBVCIJUzcTO+9pyPus5PxgXO8DQL9d5pH85TRa0pxloKX8mpFCZ0dE8KVB
 wEKruh0w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMvb-009KRm-90
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 11:46:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B7457AE5C;
 Fri, 16 Apr 2021 11:46:25 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme: sanitize KATO setting
Date: Fri, 16 Apr 2021 13:46:20 +0200
Message-Id: <20210416114621.129736-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416114621.129736-1-hare@suse.de>
References: <20210416114621.129736-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_044627_630154_A76CD960 
X-CRM114-Status: GOOD (  14.04  )
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

According to the NVMe base spec the KATO commands should be sent
at half of the KATO interval, to properly account for round-trip
times.
As we now will only ever send one KATO command per connection we
can easily use the recommended values.
This also fixes a potential issue where the request timeout for
the KATO command does not match the value in the connect command,
which might be causing spurious connection drops from the target.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c    | 18 +++++++++++++++---
 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/nvme.h    |  1 -
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40f08e6325ef..f58e196d5b4b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1109,6 +1109,18 @@ void nvme_execute_passthru_rq(struct request *rq)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
+/*
+ * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
+ *
+ * The host should send Keep Alive commands at half of the
+ * Keep Alive Timeout accounting for transport roundtrip times [..].
+ */
+static inline void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
+{
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   ctrl->kato * HZ / 2);
+}
+
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
@@ -1131,7 +1143,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		nvme_queue_keep_alive_work(ctrl);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1161,7 +1173,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		nvme_queue_keep_alive_work(ctrl);
 		return;
 	}
 
@@ -1178,7 +1190,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	nvme_queue_keep_alive_work(ctrl);
 }
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..13c2747e3d00 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -379,10 +379,8 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
-	 * and add a grace period for controller kato enforcement
 	 */
-	cmd.connect.kato = ctrl->kato ?
-		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
+	cmd.connect.kato = cpu_to_le32(ctrl->kato * 1000);
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c6102ce83bb4..49276186d5bd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,7 +27,6 @@ extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
-#define NVME_KATO_GRACE		10
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
