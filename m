Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F8CC7EE31
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsOUxnE1u5JbMpcR2JkNgI63LoZPnIXj7YxT/oWSNb0=; b=BeX/c0EJ/YWalGhtRsSWElQdKm
	/KiGANClPSCDuHiFIrNDhJYjVOmH+jeqpoMHiiitO2BLXMBTSBqhoPiztRPdGQVU3uWI+1ZtjLC06
	2u0mZ/aQaPqrwbO/pUpcihtxATRBHH4jpdGcsZLIsKfZSS6LDEXGjmAMK4+IE0mpss0YaPEKwVEXR
	UF2DzRTrbOH+GPoyKXO3VQkohF8v4VI/sX75gdSvhXT7Q6kTsXqvgeokmBSH29DkHQPtRFJgwakQv
	TnBMCPxE4hxRTXKakGMQpnqYAqoYCS/BOnWPRPIRspCNNQ7BKpBNZE6mM8sknlFc5MNDn2w5xALny
	2j1J+jhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJo-00EUa3-23;
	Wed, 24 May 2023 19:38:44 +0000
Received: from mail-yw1-x1163.google.com ([2607:f8b0:4864:20::1163])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJi-00EUY3-1m
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 19:38:42 +0000
Received: by mail-yw1-x1163.google.com with SMTP id 00721157ae682-561afe72a73so20771737b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsOUxnE1u5JbMpcR2JkNgI63LoZPnIXj7YxT/oWSNb0=;
        b=M3AlS3EF+jlW0EJVziFyO25p+h2hUaqa+m5cIHoLc4aqXKT+DvgBXJw7hFa03VqU3B
         NZ2FLwKYkoMy9HdomT7Nw5xx+icFq58pDJazzX3b3qTnkIuxIM/7nC93glvibIUJ5KS1
         0RrDGiMOWkJArIVpu+J0TDOZAIvcZQduY2qvQTg//1F9rsLrQ2L22oAj1GrZuME1xM+X
         +V6WtjPRoIBxvqWOPkBnbOjKoUxOjG7xf/z6O8CTb6rSh7aWgKUKTOiYa7kud57NQGEu
         69rpHRqw9mu7iV1jatl8I/Y3Tg810JHJ8U9LYNIsQskcvXWr89RP4w4QuxOx83vSr4Sl
         lN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsOUxnE1u5JbMpcR2JkNgI63LoZPnIXj7YxT/oWSNb0=;
        b=Q1OwK6jD5JS0UJRUjBQ0udxxnNewa5gAZojLL4FPlkCcJ9iA9wIFW88niW8V/AC3bm
         rvXPxM7DEcgwNAQSEYWWE1ceAbNhLWwMA4GuzMLtf0aMwjplW//QEpcmo2l5cBGkHEa6
         iAq7CO1OccWRPTPHSUIFdVRjBT7G7tZSPfpVfP9owJTkaKEvDU4bzBAZIzZwitdwJyB0
         n6LcDOCP0kSxiFqNKldjQ9iD3Zx5uqt1n9PIJSEy+TabtaySm9HFRsDW5zVOtO57gFVZ
         alAkT2/XdQvN1G/s44SmkZp4MsWeU90t1DvUW2VbRJzTgO5pzzn+BrtAPWAr9drDDyHb
         G21w==
X-Gm-Message-State: AC+VfDxGPc23GNuSKhKk8tEQWtcHRUcUXAUgNE+kphrV+emTrde8ZD25
	72lyEpoY422XQ+BcJWPgsNTgh8DYky8G7IgkVtuUuLy1J0DKEqhJ+9WQFkxPfXwy9Q==
X-Google-Smtp-Source: ACHHUZ6m/FVECvFn3ceLHlq6Dtixj2EipV7xUg3D+AjH+KgpkjmuzlUuHS8Vtxax0o+4jKWXdb72Lt/bKVNj
X-Received: by 2002:a0d:db57:0:b0:55a:f410:4ffe with SMTP id d84-20020a0ddb57000000b0055af4104ffemr20012571ywe.19.1684957116003;
        Wed, 24 May 2023 12:38:36 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id n187-20020a8172c4000000b0055df581d44bsm1895209ywc.18.2023.05.24.12.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 12:38:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 32596221E3;
	Wed, 24 May 2023 13:38:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2F6A1E42EE4; Wed, 24 May 2023 13:38:35 -0600 (MDT)
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
Subject: [PATCH v4 2/3] nvme: check IO start time when deciding to defer KA
Date: Wed, 24 May 2023 13:38:08 -0600
Message-Id: <20230524193809.1360269-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524193809.1360269-1-ushankar@purestorage.com>
References: <20230524193809.1360269-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_123838_844193_A01FCF57 
X-CRM114-Status: GOOD (  19.14  )
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
 drivers/nvme/host/core.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ad2b9b0d3b9..54f5440a0b83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,7 +397,13 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (ctrl->kas)
+	/*
+	 * Completions of long-running commands should not be able to
+	 * defer sending of periodic keep alives, since the controller
+	 * may have completed processing such commands a long time ago
+	 * (arbitrarily close to command submission time).
+	 */
+	if (ctrl->kas && nvme_req(req)->start_time >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1173,6 +1179,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 	 */
 	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
 		delay /= 2;
+
 	return delay;
 }
 
@@ -1198,6 +1205,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1216,6 +1224,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	ctrl->ka_last_check_time = jiffies;
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


