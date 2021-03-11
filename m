Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2925DC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:38:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9216D64FC0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216D64FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MNXhZRS9dx7dibHoooeMv/ew+LWQuVRVt5cmsLmbeRQ=; b=DJFRwTZAWzBCFhLBUyOkDJgcR
	6Hf3RCwFNe7NR0fSdrfXKAsF2fraccuQ5kf3ruljfEv+q+wLHIddilmuvslx4DvralJ2/38yYgzdJ
	xsXmFRiYHkqkQoMcJovdSIJe6jnDBnxM6RnO4sqw3LvLZeXRhj21+lr2xJojEcq01y0B4//FBuSiE
	RxqmgzbDCdQkL4RaPTc7VPJ7n2UzGDXXHx9NGfm1zTRZWYAdIb3fjc4EHYPziUMOsYWyEiFGsaW7u
	+oWeOGvYZS8Jwvpexp4RrRjpgreLVErNXlNFtCSCFRB6fVQW7VuArQjLfPM69DUddg4ORnYcHOpIn
	sWeFTtTrA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIhR-008qPR-H2; Thu, 11 Mar 2021 10:37:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIh8-008qMw-Sv
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:37:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF91BAB8C;
 Thu, 11 Mar 2021 10:37:29 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme: sanitize KATO setting
Date: Thu, 11 Mar 2021 11:37:26 +0100
Message-Id: <20210311103727.47381-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311103727.47381-1-hare@suse.de>
References: <20210311103727.47381-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_103731_101295_A2F43287 
X-CRM114-Status: GOOD (  14.46  )
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
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/nvme.h    | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82ad5eef9d0c..b56903982b27 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1223,7 +1223,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		nvme_queue_keep_alive_work(ctrl);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1253,7 +1253,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		nvme_queue_keep_alive_work(ctrl);
 		return;
 	}
 
@@ -1270,7 +1270,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
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
index 07b34175c6ce..cc74b9f8d5ff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,7 +27,15 @@ extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
-#define NVME_KATO_GRACE		10
+
+/*
+ * Recommended frequency for KATO commands
+ *
+ * NVMe 1.4 section 7.12.1 states:
+ * The host should send Keep Alive commands at half of the
+ * Keep Alive Timeout accounting for transport roundtrip times [..].
+ */
+#define NVME_KATO_DELAY(k)	(((k) > 1)?(k) >> 1:(k))
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
@@ -583,6 +591,12 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 	return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+static inline void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
+{
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   NVME_KATO_DELAY(ctrl->kato * HZ));
+}
+
 void nvme_complete_rq(struct request *req);
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
