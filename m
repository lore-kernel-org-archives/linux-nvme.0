Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4788C7EE2A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdlvUnd1p2RiyryXl27Uzd+TOeMVwtqX1iLwJlP0Zro=; b=V8DdvEp+jfpRen3o2cre+MMV5+
	9zazO8zPlZa0PN1WzPkniQRFgLJmKWJUPb/sEjx2BZSIKfTNmLS+u4Fzlg/Cq6pzIbaHYatRMCbRs
	kbP/DR3DyoX54ULjDMffyLlV3uipNo2npFsi5vokQ6kDxrSOPsA3Ygp8YtQqvmV/rSOgqniThtttI
	5MuLGE58C1v6g0/UiBSHTqLuKN6G0gN450CqsRJXz2hX9Qb+PCUTxZ/mT3QRf9fIkaZ5zUiuLk0p+
	MPjm+QezK59/nmLrQExMtmiHEvzHoQjC5bIcu9ligGo3RnCM5fmtWap5Kv3fH8t5kDufupL/e2ku8
	bPqKwcLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRn-00DpPe-2M;
	Thu, 18 May 2023 18:33:55 +0000
Received: from mail-yw1-x1162.google.com ([2607:f8b0:4864:20::1162])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRe-00DpLP-14
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 18:33:50 +0000
Received: by mail-yw1-x1162.google.com with SMTP id 00721157ae682-561c5b5e534so30058597b3.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdlvUnd1p2RiyryXl27Uzd+TOeMVwtqX1iLwJlP0Zro=;
        b=GCn+zhWbZNeLlTSEhK+eJJEgZWAdzPdgb3PI0cBFeNoDPzV/SeNnRLczzvZv53o6ml
         alSQcuw5pzY4ABYSXyQ/grpITIfPuJK3woJiZFbHaQobuqxs0DPloc9vZAMHjWgv1bMa
         YDDiomWtMC5muqc1o7QEHWJVMXXE2RmyOsniO4NEA3db7O08RxAFTD6twRolImQ47GUb
         LU1O075mG1y88xmsaj3jBHjyAf76xQZtSf+hG3CezvBhrdtIn9ilF18UA6yAmckK3FH9
         7xqogHXrX8+iZSrl5Nez3l5x5gt5t9bVxCTXEeJTmaEYkikzdqSEajlXxkIvAylmvKWT
         +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdlvUnd1p2RiyryXl27Uzd+TOeMVwtqX1iLwJlP0Zro=;
        b=A4QMEqwVVCcTeEg1yFYV5WEltje12TMzUm/G62ysmbhrsGyEAjcafVgeCryDHlPt1J
         fOJxAxJ9oN+EwEoSfNfZwErBA/E+AwUHjV6hcmnkP7R47FVoqrAodxP28fDE9PZyFJpQ
         VpymUVapS2g+BESnfyUOVXV5fFt+acEU+lPHMdpaQtWopkpjPXX8mX4/etcHs+/mb1w3
         r2Lt28KPIFdi73bNGUkevT+Fjp/GUnl1V8SxSfgfHzBe9NR6prbO6w9mQfazCZA48fI4
         XPVppaLKKguvYjRY6ys8GVKjUFRdA3QGvAtTva7tN1S4tSaPtCFSz6yOmgy+uB17On+0
         HpNw==
X-Gm-Message-State: AC+VfDxGI6Qx7ZeebKTipcwwVdJnsFRFhC9ZEoD8aDHUiFqQEOmaTwD+
	Y2FBPvdoTUpOO/m7/pBSTVwqliEklzltH4IWfZiBI4co3XlBwg==
X-Google-Smtp-Source: ACHHUZ7dH4Ib+l/xL6EUVOzqePE2o0DMy+hLow78lKaSxwGKlwnpLioXgtwStxB/Qzi0mtdjO5tgdOA601U3
X-Received: by 2002:a0d:d985:0:b0:55a:ad64:1b62 with SMTP id b127-20020a0dd985000000b0055aad641b62mr2180368ywe.16.1684434823310;
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id r124-20020a0dcf82000000b0054f9352dfebsm97776ywd.66.2023.05.18.11.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A81AB222B3;
	Thu, 18 May 2023 12:33:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A371BE44A65; Thu, 18 May 2023 12:33:42 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/3] nvme: check IO start time when deciding to defer KA
Date: Thu, 18 May 2023 12:33:10 -0600
Message-Id: <20230518183311.3224326-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518183311.3224326-1-ushankar@purestorage.com>
References: <20230518183311.3224326-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_113347_467892_75E2F347 
X-CRM114-Status: GOOD (  18.95  )
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
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7726277b951a..a31c04b5f849 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,7 +397,14 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (ctrl->kas)
+	/*
+	 * Completions of long-running commands should not be able to
+	 * defer sending of periodic keep alives, since the controller
+	 * may have completed processing such commands a long time ago
+	 * (arbitrarily close to command submission time).
+	 */
+	if (ctrl->kas && !ctrl->comp_seen &&
+	    nvme_req(req)->start_time >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1188,6 +1195,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
+	smp_wmb();
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1206,6 +1215,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
+	smp_wmb();
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f0a84e390a55..07ed39ea43e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,9 +162,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
-#ifdef CONFIG_NVME_MULTIPATH
 	unsigned long		start_time;
-#endif
 	struct nvme_ctrl	*ctrl;
 };
 
@@ -323,6 +321,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
+	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
 
@@ -1032,6 +1031,7 @@ static inline void nvme_start_request(struct request *rq)
 {
 	if (rq->cmd_flags & REQ_NVME_MPATH)
 		nvme_mpath_start_request(rq);
+	nvme_req(rq)->start_time = jiffies;
 	blk_mq_start_request(rq);
 }
 
-- 
2.25.1


