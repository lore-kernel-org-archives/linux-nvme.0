Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B671600EF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B671600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SVI+mWWQu61JV93omT88sUbavYBb9/KwfkzToE0gaKg=; b=chBfPK9pA7qO2rA12988cLmUf
	rfex4mO95ZmeakT25xEIKxQwe0svzgHCaVao2BfIxmTzosTJwv215jI/FcWvBPI3B/rN0odEwpxWF
	pMbXIYqVswNQNnxCZbiZpt+qTm2igUhkZL29DCQLGdq3Gq+1GZuqWeQqp1xqmmz+4njNtORDzjcXV
	LaqEYz3M1RCimSfMuqpZVs3OcI2//W2WOz8v81PfA0T9Bg+CS/dqb4DQ30C0s3Teo+NXEZrAYW5jS
	FyZGvsg3q3jn4zRgjbFhe8GV/t7c6DDEc+3E2fESNAQcfrBpv72ZXCKbV764qyTE6lO1m1UwcnY5p
	jGKbH1oqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lH1Io-00023K-UQ; Tue, 02 Mar 2021 09:26:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lH1Ik-000222-VJ
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 09:26:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 020F1AFB7;
 Tue,  2 Mar 2021 09:26:46 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme: sanitize KATO setting
Date: Tue,  2 Mar 2021 10:26:43 +0100
Message-Id: <20210302092644.80701-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302092644.80701-1-hare@suse.de>
References: <20210302092644.80701-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_042647_143939_9CE81F44 
X-CRM114-Status: GOOD (  17.59  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
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
 drivers/nvme/host/core.c    | 9 ++++++---
 drivers/nvme/host/fabrics.c | 2 +-
 drivers/nvme/host/nvme.h    | 9 ++++++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f890b310499e..6d096d41a82f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1223,7 +1223,8 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work,
+				   NVME_KATO_DELAY(ctrl->kato) * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1258,7 +1259,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work,
+				   NVME_KATO_DELAY(ctrl->kato) * HZ);
 		return;
 	}
 
@@ -1275,7 +1277,8 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   NVME_KATO_DELAY(ctrl->kato) * HZ);
 }
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5dfd806fc2d2..dba32e39afbf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -382,7 +382,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	 * and add a grace period for controller kato enforcement
 	 */
 	cmd.connect.kato = ctrl->kato ?
-		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
+		cpu_to_le32(ctrl->kato * 1000) : 0;
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 23711f6b7d13..912830389997 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,7 +27,14 @@ extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
-#define NVME_KATO_GRACE		10
+
+/*
+ * The recommended frequency for KATO commands
+ * according to NVMe 1.4 section 7.12.1:
+ * The host should send Keep Alive commands at half of the
+ * Keep Alive Timeout accounting for transport roundtrip times [..].
+ */
+#define NVME_KATO_DELAY(k)	((k) >> 1)
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
