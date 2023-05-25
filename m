Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC95EC7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abY5k5Fw/onHLxtJvX5F9dyv3JrqPa4Rkd5D8rHKPeM=; b=Z9poYjhmHoKmadAcTLKPWQaZs3
	4ROo7XxjZk/Ts7GWq9O42ti9tbSAKlRKgNYhZFAw4OdYaDTMBo/wMC7cYCRiZogwH0KWSErcKheOf
	veXS1oUyHTrHkosVFUVIknArOrUr6kF8D8Wf5uOf+MKH0KJyyYzo3O4rQsmYk1grF1wGQamLYU5Q6
	5kbAswkEE+Mfeb64HaDzsj6ReE97LeQ5WjWZ17gS35Fc1sW3/hfRaHRFPpZRTYI8kAzZpcozzbbpu
	FoHuj/nYOBghLFY7w4/Ed0eA6J1CMrXv49Ewj3bynToNE0aZzJucE/1ASoxXpKr8JjOtCZv2BaP8E
	4d/7Jnjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbW-00HNTz-2h;
	Thu, 25 May 2023 18:22:26 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbP-00HNQb-02
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:22:22 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-1ae6dce19f7so13222795ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abY5k5Fw/onHLxtJvX5F9dyv3JrqPa4Rkd5D8rHKPeM=;
        b=FieO1tVxfPwbg3S4uXo1py9c3NEGWEktTjt2Y/vXIOpsXOpGZeJL96lTs7T9lVuQab
         qM5dKr6K+7NF1VemyK8uDwYYi0nfLTCXkW1SILImesRfEUUKqdxrO52CnU0pUhjAH1Kl
         1Nq6tKIxyxWZhiHNd0y9aiAO5cf7ZbN6IuXLmCRGTEiKmmUv3R1PRkfqircsKt6WYFLO
         Du1F+mNh2NfFoaQv1fZE1a2StG+g1/7Ru0H1BVZId7WIBPzjadImVoCAZ5C8/P4SnPAz
         3B85JTOFw9dJNKtMBxy+xVne2qZ6NWbcURcdkKNeUMwsR5GcP6vXv6MAl2CFuoWsRbHf
         NXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abY5k5Fw/onHLxtJvX5F9dyv3JrqPa4Rkd5D8rHKPeM=;
        b=WcqEpfo7CGTu5dc1dCLHN2SQlrqUEal2GXKmkq3JnsD/w1zTjr/BGrOgKDfAGMAk5V
         KZXguTCs26MednOYxNSKfL6hmFalP72aEZKJkobpjEc2FIBY4QIAewiakocmWXRK0mD6
         tPjHXFMM0ucFlDqmqgqwXz3dm6fUnHlA4cJkvI56D1QHJhkq7I/KRELXtpRTgnIIOeeD
         m0BQmAKWldSr5yRYan5K6GYx/ZGpT4ExoysckV3c3FcO2spFN8aVNLdE0Dbrfahj2aDg
         FKzCOTA1TIIi/u54IlkkYSdQdRhzDVKksxVAOBjqb+HU6J9gH0DFE/8OOrCyYGp94PKV
         diVA==
X-Gm-Message-State: AC+VfDyMxLAGBFlIQA1mVIj7pVqHwEqrDQqcvsx7z8unfHGkqnpwwtbd
	ZpzRU4GnGoBwqggPbN/HQ/aseJgnWLmEX/R/VxGhpkP2/zSL6Bu0EfwaKpUZhmLrog==
X-Google-Smtp-Source: ACHHUZ5lchCTtnRJ6eVN5qDdKzOkdNsF3S10Sj7105GusQ9zQjEcDno5o8ONPYDYYyC0yQ83PPwl6ONbdU0/
X-Received: by 2002:a17:902:7e42:b0:1a9:20d6:3c3f with SMTP id a2-20020a1709027e4200b001a920d63c3fmr2324418pln.55.1685038937035;
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id e12-20020a170902ed8c00b001ac3f74f49esm125637plj.4.2023.05.25.11.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id D0567222A9;
	Thu, 25 May 2023 12:22:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CB013E44A3D; Thu, 25 May 2023 12:22:15 -0600 (MDT)
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
Subject: [PATCH v6 2/3] nvme: check IO start time when deciding to defer KA
Date: Thu, 25 May 2023 12:22:03 -0600
Message-Id: <20230525182204.1954429-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525182204.1954429-1-ushankar@purestorage.com>
References: <20230525182204.1954429-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_112219_276442_5415D486 
X-CRM114-Status: GOOD (  19.53  )
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
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ad2b9b0d3b9..1c86780342fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,7 +397,16 @@ void nvme_complete_rq(struct request *req)
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
@@ -1198,6 +1207,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1216,6 +1226,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	ctrl->ka_last_check_time = jiffies;
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f0a84e390a55..2953400e5590 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -323,6 +323,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
+	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
 
-- 
2.25.1


