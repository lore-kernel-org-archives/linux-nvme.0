Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C06C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:45:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792B460FE4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792B460FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6XWcY9iUoLcxq+V/puzYQqZFJdtQbv6Fid8jitSran0=; b=DsdFsCE0ts77SMGebrjfuAH8i+
	KacAy8Fci2fnPl397PYxKLyary/JoXu6wLCZpxSOjFLImZbfruoOirXd8OSOkQMnsXRqgtL57cSya
	Sh3gqI4L8S85RSfllFkrx1LslYnQCGq/vHxGl/BRLF2McdWw60teI9yPy8diCFtdwq+C5LWUtDaZB
	MftmphL5UlxJSdhk7wuAOlqFp0PeTN5yC5vYP9fPACq+47fwoSN8TLJJggJxZ6mGUyATgaF5VMIcQ
	h6srEoV4cu9dzJAEEkInqxEkxJHvs5i5wPk+ouYwzWwZJbE6qjh/OHw5lvW40OPQPlOdkoFi0bmvj
	w58cPA7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnhu-000Iv4-Ly; Fri, 09 Apr 2021 09:45:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnhr-000IuQ-Lx
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 09:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=vbJUEoZ43cUheO1RTW0S2vC7BTyAGVfw97rFuCezhW0=; b=17UpjsHl5Yvdm14iScwPkfGNxw
 R9EM+9Mpfhd2awmFWtXbHNqlA8pAEb+sYgAVH3z1LGwFVqTOSorljeZwWG0JpLW2BQeDX+jUT2tA8
 TTivHgrl+7kMH93kwh9sdt56RJSSIoe3GMBQgIqASg88NXiSNGBAyUvFRvzFU2m1pRlr5F1vNpbBr
 qmSyaHMSr/sLZjsj9AFJlmeZPY5v9jpbYnU4Z0KVmcvendY1y3r0zQCfuVB2bh+0uMNKOwHFZgSbu
 8X6yPti96ObPiQwwdifCbZQDFPwjfNga/kBzkJiCPOzIjYw0hWoEZiivFjTW3DdPGYvppqYVSndK/
 nBer8gVg==;
Received: from [2001:4bb8:188:4907:652e:b389:8276:453e] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnhp-0043FL-RO; Fri, 09 Apr 2021 09:45:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: cleanup nvme_configure_apst
Date: Fri,  9 Apr 2021 11:45:24 +0200
Message-Id: <20210409094524.1920584-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Remove a level of indentation from the main code implementating the table
search by using a goto for the APST not supported case.  Also move the
main comment above the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 148 ++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 314705da2c1076..78817190099040 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2550,28 +2550,28 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+/*
+ * APST (Autonomous Power State Transition) lets us program a table of power
+ * state transitions that the controller will perform automatically.
+ * We configure it with a simple heuristic: we are willing to spend at most 2%
+ * of the time transitioning between power states.  Therefore, when running in
+ * any given state, we will enter the next lower-power non-operational state
+ * after waiting 50 * (enlat + exlat) microseconds, as long as that state's exit
+ * latency is under the requested maximum latency.
+ *
+ * We will not autonomously enter any non-operational state for which the total
+ * latency exceeds ps_max_latency_us.
+ *
+ * Users can set ps_max_latency_us to zero to turn off APST.
+ */
 static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
-	/*
-	 * APST (Autonomous Power State Transition) lets us program a
-	 * table of power state transitions that the controller will
-	 * perform automatically.  We configure it with a simple
-	 * heuristic: we are willing to spend at most 2% of the time
-	 * transitioning between power states.  Therefore, when running
-	 * in any given state, we will enter the next lower-power
-	 * non-operational state after waiting 50 * (enlat + exlat)
-	 * microseconds, as long as that state's exit latency is under
-	 * the requested maximum latency.
-	 *
-	 * We will not autonomously enter any non-operational state for
-	 * which the total latency exceeds ps_max_latency_us.  Users
-	 * can set ps_max_latency_us to zero to turn off APST.
-	 */
-
-	unsigned apste;
 	struct nvme_feat_auto_pst *table;
+	unsigned apste = 0;
 	u64 max_lat_us = 0;
+	__le64 target = 0;
 	int max_ps = -1;
+	int state;
 	int ret;
 
 	/*
@@ -2592,83 +2592,73 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-		apste = 0;
 		dev_dbg(ctrl->device, "APST disabled\n");
-	} else {
-		__le64 target = cpu_to_le64(0);
-		int state;
-
-		/*
-		 * Walk through all states from lowest- to highest-power.
-		 * According to the spec, lower-numbered states use more
-		 * power.  NPSS, despite the name, is the index of the
-		 * lowest-power state, not the number of states.
-		 */
-		for (state = (int)ctrl->npss; state >= 0; state--) {
-			u64 total_latency_us, exit_latency_us, transition_ms;
-
-			if (target)
-				table->entries[state] = target;
-
-			/*
-			 * Don't allow transitions to the deepest state
-			 * if it's quirked off.
-			 */
-			if (state == ctrl->npss &&
-			    (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS))
-				continue;
+		goto done;
+	}
 
-			/*
-			 * Is this state a useful non-operational state for
-			 * higher-power states to autonomously transition to?
-			 */
-			if (!(ctrl->psd[state].flags &
-			      NVME_PS_FLAGS_NON_OP_STATE))
-				continue;
+	/*
+	 * Walk through all states from lowest- to highest-power.
+	 * According to the spec, lower-numbered states use more power.  NPSS,
+	 * despite the name, is the index of the lowest-power state, not the
+	 * number of states.
+	 */
+	for (state = (int)ctrl->npss; state >= 0; state--) {
+		u64 total_latency_us, exit_latency_us, transition_ms;
 
-			exit_latency_us =
-				(u64)le32_to_cpu(ctrl->psd[state].exit_lat);
-			if (exit_latency_us > ctrl->ps_max_latency_us)
-				continue;
+		if (target)
+			table->entries[state] = target;
 
-			total_latency_us =
-				exit_latency_us +
-				le32_to_cpu(ctrl->psd[state].entry_lat);
+		/*
+		 * Don't allow transitions to the deepest state if it's quirked
+		 * off.
+		 */
+		if (state == ctrl->npss &&
+		    (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS))
+			continue;
 
-			/*
-			 * This state is good.  Use it as the APST idle
-			 * target for higher power states.
-			 */
-			transition_ms = total_latency_us + 19;
-			do_div(transition_ms, 20);
-			if (transition_ms > (1 << 24) - 1)
-				transition_ms = (1 << 24) - 1;
+		/*
+		 * Is this state a useful non-operational state for higher-power
+		 * states to autonomously transition to?
+		 */
+		if (!(ctrl->psd[state].flags & NVME_PS_FLAGS_NON_OP_STATE))
+			continue;
 
-			target = cpu_to_le64((state << 3) |
-					     (transition_ms << 8));
+		exit_latency_us = (u64)le32_to_cpu(ctrl->psd[state].exit_lat);
+		if (exit_latency_us > ctrl->ps_max_latency_us)
+			continue;
 
-			if (max_ps == -1)
-				max_ps = state;
+		total_latency_us = exit_latency_us +
+			le32_to_cpu(ctrl->psd[state].entry_lat);
 
-			if (total_latency_us > max_lat_us)
-				max_lat_us = total_latency_us;
-		}
+		/*
+		 * This state is good.  Use it as the APST idle target for
+		 * higher power states.
+		 */
+		transition_ms = total_latency_us + 19;
+		do_div(transition_ms, 20);
+		if (transition_ms > (1 << 24) - 1)
+			transition_ms = (1 << 24) - 1;
+
+		target = cpu_to_le64((state << 3) | (transition_ms << 8));
+		if (max_ps == -1)
+			max_ps = state;
+		if (total_latency_us > max_lat_us)
+			max_lat_us = total_latency_us;
+	}
 
-		apste = 1;
 
-		if (max_ps == -1) {
-			dev_dbg(ctrl->device, "APST enabled but no non-operational states are available\n");
-		} else {
-			dev_dbg(ctrl->device, "APST enabled: max PS = %d, max round-trip latency = %lluus, table = %*phN\n",
-				max_ps, max_lat_us, (int)sizeof(*table), table);
-		}
-	}
+	if (max_ps == -1)
+		dev_dbg(ctrl->device, "APST enabled but no non-operational states are available\n");
+	else
+		dev_dbg(ctrl->device, "APST enabled: max PS = %d, max round-trip latency = %lluus, table = %*phN\n",
+			max_ps, max_lat_us, (int)sizeof(*table), table);
+	apste = 1;
 
+done:
 	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
 				table, sizeof(*table), NULL);
 	if (ret)
 		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
-
 	kfree(table);
 	return ret;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
