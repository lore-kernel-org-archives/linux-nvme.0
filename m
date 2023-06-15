Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA364EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXSEItdK4rO3COdOa/9GlF06OLEh2OZJDOLSmBH6lVE=; b=19VVtY5f3X4fhtFpuE3rBikbD1
	cwvhcM3Kk9hnZocMN1DXBTmz3ulITzazoRtCqlut/TG65O5mSL6oq87ozpfH3NUOHOtkDNUbTj99i
	pSMfMfp7OoM3M6Zw1VJbQAwM2Vb6wNKkfjAWOnwL+ExEzQYdhSjDvDQwbYa+ZjS/7Rj/dJY2pwq2s
	S0LvTr49tr/tJ3dJ3qfVvoahcrNkikaPfNAgReNseA8rlieY0oWvbz0GXdU3QtDKvXrrORpLHHhGG
	8fscfjuj3JyL9Y+GDFjPyv+0jpGSoVEwiwq2NkKVKXbPIhGdY/tILswW5yqVbjRkEIYGl1Bz8t6S7
	eYWZVpsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lJW-00EjBI-2k;
	Thu, 15 Jun 2023 11:38:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lJU-00Ej9c-1T
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 11:38:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F33876399C;
	Thu, 15 Jun 2023 11:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F50C433C8;
	Thu, 15 Jun 2023 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829131;
	bh=gkEUkTKKDqISeH840eDNW6Zy1Q0fZKHBArlkBoQ+9A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUdktGIjH+hpc0mfBHzNNbje9LHLJGSK8DhgtgiLT14HW5SnzwB/OnpCE/wwcq4qU
	 SjAEoXTmoO2qgn8p4d9IdB56aurGBKH6iXdYxm4utq4NTInPX5sc0PsygwEXzJvxn2
	 QUaow3F3Yqyraq5R6rtzuiIeb1Hmyk6EwmXBWGskuEYVQOnxpKyy4oHzBvYB4+TYLo
	 lwAI3CIDA/s1UxAhcPJsPsAOkX/qOX7sYAXU/vXIdNuvVAR3nSXHi5o9dMnCSw1H80
	 fzpQD8sLn+vNMMPT/YZ67qm6/IDioQAFGha9ZBVUXbuqfhBi1/b+agTBgRnaJ28zHg
	 Vl/76bwffd9jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 14/16] nvme: check IO start time when deciding to defer KA
Date: Thu, 15 Jun 2023 07:38:14 -0400
Message-Id: <20230615113816.649135-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_043852_568131_8C877C50 
X-CRM114-Status: GOOD (  19.88  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit 774a9636514764ddc0d072ae0d1d1c01a47e6ddd ]

When a command completes, we set a flag which will skip sending a
keep alive at the next run of nvme_keep_alive_work when TBKAS is on.
However, if the command was submitted long ago, it's possible that
the controller may have also restarted its keep alive timer (as a
result of receiving the command) long ago. The following trace
demonstrates the issue, assuming TBKAS is on and KATO = 8 for
simplicity:

1. t = 0: submit I/O commands A, B, C, D, E
2. t = 0.5: commands A, B, C, D, E reach controller, restart its keep
            alive timer
3. t = 1: A completes
4. t = 2: run nvme_keep_alive_work, see recent completion, do nothing
5. t = 3: B completes
6. t = 4: run nvme_keep_alive_work, see recent completion, do nothing
7. t = 5: C completes
8. t = 6: run nvme_keep_alive_work, see recent completion, do nothing
9. t = 7: D completes
10. t = 8: run nvme_keep_alive_work, see recent completion, do nothing
11. t = 9: E completes

At this point, 8.5 seconds have passed without restarting the
controller's keep alive timer, so the controller will detect a keep
alive timeout.

Fix this by checking the IO start time when deciding to defer sending a
keep alive command. Only set comp_seen if the command started after the
most recent run of nvme_keep_alive_work. With this change, the
completions of B, C, and D will not set comp_seen and the run of
nvme_keep_alive_work at t = 4 will send a keep alive.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50a83306bea7b..06dd1c0780bfc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -395,7 +395,16 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (ctrl->kas)
+	/*
+	 * Completions of long-running commands should not be able to
+	 * defer sending of periodic keep alives, since the controller
+	 * may have completed processing such commands a long time ago
+	 * (arbitrarily close to command submission time).
+	 * req->deadline - req->timeout is the command submission time
+	 * in jiffies.
+	 */
+	if (ctrl->kas &&
+	    req->deadline - req->timeout >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1235,6 +1244,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1253,6 +1263,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	ctrl->ka_last_check_time = jiffies;
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 01d90424af534..ce668268b2c32 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -318,6 +318,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
+	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
 
-- 
2.39.2


