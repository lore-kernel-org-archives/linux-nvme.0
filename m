Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF9AC77B78
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4PdEwfiwHcYwRwGjOshKc2oOcDzEyISXXmj+N6X3/I=; b=njxlsTTaNnV+80JFoEJEAKEPLA
	2HPDLz0ZJ8En61gn3IrJBPcH4vShXPL/0PAODLO14COtFQIz9G+tQ/3Oyf6l04UBYNNQZF3fQDX0A
	6YLx4k8ZQ55MxbtUawK2HEMIWbjQCnA4Ir7dSV1lWcVs1rPwdscoOtrEdH+y2GZbZhwOw66u44NoA
	QzbUKvrZkzu1s6I1/w2akytt3vnrTJKadcv+Zp0aSvmv+KIyzJY52xYH9CeCeJyjOLWzq2BegfL6D
	30W08JPquum4DYjRw1MqgPqjAhQT4l3PBOphPv+aht2D1/scSw04HrYeKXukJlvLg51Dx+hrOZqiC
	KTXAaXcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poXld-000Kqs-1B;
	Mon, 17 Apr 2023 22:56:13 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poXlY-000KnS-0X
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 22:56:11 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-63b51fd2972so1245955b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4PdEwfiwHcYwRwGjOshKc2oOcDzEyISXXmj+N6X3/I=;
        b=D7nTSAYEG1n40qPjUIwgQha9kOl4y2SPiMeOATwuPPt/njycjzrcVBiAo4wh5fgUji
         1tolGjffy7tGjsi28aY3HkPNMFR8toCWj286r7UO5sCzeKdj/Cq2bBYWPisak49RFyr/
         7vDhAuHAh2ia22xp/yNIFVnMqyilqYzHKmSb//M7G7Am7sDesS9D9SZJ2BLK6Xn/2zrD
         zehnMVNo5lnSn2r3q+OhNGj14wZBDa12MIbjzqk+AcF2n64jv4FaI0gLzVbsqCyDR877
         kqCUhW+yhmNAJ1pbbolzkjPyPMOSkUov60JePu3hmzjoJbeHMOWO2Cj6yNUvkI6RmlwL
         n35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4PdEwfiwHcYwRwGjOshKc2oOcDzEyISXXmj+N6X3/I=;
        b=Rd9uJozTuOlVRvSup4DfhGhenPjSYVPz4KGTTGQcVCf7hkkmLuJ9Ri77ejErvFVh5I
         pNWuy59AZ7xCsSXtjIdxC7xAFurBELFw8aNRm//9I31CUOSO50JQzFFt+k9OK+buRltl
         681yDa/Cn+HSU2vYKf8NJPHY7YIvNpttEvYhQ+T4MieOS3t+VYP5sCOwspOqpKRrwf0d
         f3+N70DCBUUjLbnUE5m0wBcqsl2WSuXwab57wxxsKzlWXg9jt5O7XK2ai+A1Y6N4Np7Y
         Z6oXYrGTROEglpbIpA5GAZgn6Rz1M25ZHQutagU1sFtrlzEYod/aDO5CPZytkrz9x8if
         i/Xw==
X-Gm-Message-State: AAQBX9cVGln59QyW0EWFzEgcyZ1IiDBUx1XSnzqRRe5ziUJEbk8koG4n
	S3X69Jot1XJN+zZnxPofE22z+dOzOv32M2L9raPuP+4vESrlgJVTk5keJ4vyYYdTNQ==
X-Google-Smtp-Source: AKy350ZQwg1hSEE9IF+A44NMDzPQAOb+by3bE9TYx3UzrJ7oCl8iaOXP19+mo01AhymSUHwelLY0G3K+Z5o4
X-Received: by 2002:a05:6a00:b43:b0:63d:23a7:ca51 with SMTP id p3-20020a056a000b4300b0063d23a7ca51mr5943552pfo.2.1681772166556;
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id fd22-20020a056a002e9600b0062ac50b1a9fsm6409078pfb.17.2023.04.17.15.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 8DEEC221A5;
	Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7ED6BE47A53; Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
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
Subject: [PATCH 2/3] nvme: check IO start time when deciding to defer KA
Date: Mon, 17 Apr 2023 16:55:57 -0600
Message-Id: <20230417225558.2890062-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417225558.2890062-1-ushankar@purestorage.com>
References: <20230417225558.2890062-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_155608_423375_8BB64BE3 
X-CRM114-Status: GOOD (  17.87  )
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
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 drivers/nvme/host/nvme.h |  5 +++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1298c7b9bffb..8a63051d7b5e 100644
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
+	if (ctrl->kas && !ctrl->comp_seen
+		      && nvme_req(req)->start_time >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1178,6 +1185,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
+	smp_wmb();
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1196,6 +1205,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
+	smp_wmb();
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..f044ffb9ce10 100644
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
 
@@ -1028,6 +1027,8 @@ static inline void nvme_start_request(struct request *rq)
 {
 	if (rq->cmd_flags & REQ_NVME_MPATH)
 		nvme_mpath_start_request(rq);
+	else
+		nvme_req(rq)->start_time = jiffies;
 	blk_mq_start_request(rq);
 }
 
-- 
2.25.1


