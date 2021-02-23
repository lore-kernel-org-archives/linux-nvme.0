Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020A6C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CD464E32
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CD464E32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x7df3VnfmZXtIBNnnl7R2E7HWJEXrYwha9Lw7FOpzK8=; b=f7z5bVjDxYILG7BNlV+Tkhtwi
	p3pfO9kvXzK5KirIDhw+SiAskercY6ESunab8nc5YY5Ao5t2EJ2AhUYU60VBPLVbjKHaXVgWFAb5B
	urY4a//9v636icL7QmIo/tOHl0LMek5yazlN0GJHZke9xuUlLhJbY0rtzAw7NqdRcIdPs9DJUdqiE
	ArIhdhosAc7TmkxQrRzo0tqcNBt4Fy74RsIIVaYZb/PCc+u1c7GPW7hU5ehcK+NEQlArBIHlJjA4+
	WJnlX6KMzh6yaGCHwtQyw8D7WmwgY8f+QdjbfUQONkEhqwTo122wzwAyodJI6Q0kpdjVPIioiMliF
	V0TM+DnUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWTa-000078-Eu; Tue, 23 Feb 2021 12:07:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWTT-0008Vw-Dc
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 12:07:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 69036AC1D;
 Tue, 23 Feb 2021 12:07:30 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme: sanitize KATO setting
Date: Tue, 23 Feb 2021 13:07:28 +0100
Message-Id: <20210223120728.104699-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223120728.104699-1-hare@suse.de>
References: <20210223120728.104699-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_070731_705578_0D049847 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
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
 drivers/nvme/host/core.c    | 14 ++++++++++----
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/nvme.h    |  1 -
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b8596eb4047..eedbee80b7b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1226,8 +1226,11 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 	    ctrl->state == NVME_CTRL_CONNECTING)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
-	if (startka)
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	if (startka) {
+		unsigned long kato_delay = ctrl->kato >> 1;
+
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, kato_delay * HZ);
+	}
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1259,10 +1262,12 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
+		unsigned long kato_delay = ctrl->kato >> 1;
+
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, kato_delay * HZ);
 		return;
 	}
 
@@ -1276,10 +1281,11 @@ static void nvme_keep_alive_work(struct work_struct *work)
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 {
+	unsigned long kato_delay = ctrl->kato >> 1;
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, kato_delay * HZ);
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
index e00e3400c8b6..de0b270f95fc 100644
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
