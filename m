Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5D6C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/z9V7VJ+s9ZfE6RNY+clngHJsk+5nVJ3rFGlFrPOts=; b=tHWVpUfDoDs2QIFwVRHfZmQTUJ
	rb6Unchxpm2rG/WMrh2wyvjDPVfpGtm6eMfHQrDzlxF7ECHbKag3WbFVKGTe+BPU0Ok+/QbNbG7UP
	mMyq/ZdBDZS20yv5MuIFXOo+1DqlhiZcfvDjD0QzzhE5jPeYRjVxC0+hUz4+wPyYHKoOcSqIqhSxg
	hR2WSlHatZTAbyLbDEstiUlTypioIDY/JjoZ1o/LlQtx8HjUW7ntSW4864ULwSfYeDPegM8PwInvz
	CmeRmqFKv2hR7oBC8wiXiK8mm6Eor+ZjjluImIzSywHojB4zqdOTeOYpXNLh3xuGdsFvnkElkzW1R
	pcJYn0rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xoi-00EwEp-1r;
	Wed, 24 May 2023 23:22:52 +0000
Received: from mail-yb1-xb64.google.com ([2607:f8b0:4864:20::b64])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xod-00EwBL-0O
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 23:22:50 +0000
Received: by mail-yb1-xb64.google.com with SMTP id 3f1490d57ef6-ba1815e12efso1381113276.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684970563; x=1687562563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/z9V7VJ+s9ZfE6RNY+clngHJsk+5nVJ3rFGlFrPOts=;
        b=Bd9/VtsHAI53/47K2m5slaZ4JrEqyW5pshKSkPoXTfsBVTXgxqeZj5KKpi1N9y/OOw
         ZK7COG/mqQnJpfAzIp95H+k6fAUKFs03AzW2N/crIGRSXbioG7m572DH4KIQwku1Zebg
         9I0+MRDN/BA0z89S6kCPbdhJ9cqAYmTjiec3IUOI2wTDTGwX5lgLIU6s58eIWPD1cRrn
         2th8mW4NE/GL8P7Asl4KTBdHEnn8g3WVYWrgpk4AGhvKP62zd9g3AHNMtrGBG9E9XPud
         85qupYQ0A6cwwHY4vZ/KMsm/j0TodVUmSgRNfEIFSW21qkjps71Ka/C6qJ2/cerP5oPx
         SI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970563; x=1687562563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/z9V7VJ+s9ZfE6RNY+clngHJsk+5nVJ3rFGlFrPOts=;
        b=B5UO66LnwNOaF8XRGP0cjvRFCs979AFJKJfoT3/Yxde/cg3PwP/efVsDXpo7VevvXV
         WDKSmFeardcNuVdPPn+L4t/y9/yYSU0yAiaK/Ic9A99KwcQrZh6o94T2yF3l7rS4XvO7
         MLzKlfYYgp6iAINhD+O0FJlz058JTg4g8KYBHn4of73QUIdIcoO0L5hKxzARNrRSBzy4
         o32VHkLp7k6w2tDY46dAhXIDSHkuUQgT1/ou3sLURAtXwv5dGUvOYy8NMGXTOPb15sfa
         y8tifhzF4Q6ljZBOtb59qOeF55lFqz4CAEP/JBPMcwVnMdPM2QVwqNwviccKqXIys/qd
         5kWw==
X-Gm-Message-State: AC+VfDysVKDY6WLcT6oCJva3YjhTf+YafSllKPfF8vJ+Xmbzc6dE8C4R
	qD86FWs61CSbiRRBDDJfrfW7hIfSrsZ6BGfIZwIuzmmvEpijNg==
X-Google-Smtp-Source: ACHHUZ6lm5Geb/t9bj1Yw38ImAYI0IOXmXxoNlq3cBh0I2Ya2i7m02jgfHS+Y8zIoUSmjXr8o0VsaXxqHDOf
X-Received: by 2002:a81:75c4:0:b0:561:f6eb:d18a with SMTP id q187-20020a8175c4000000b00561f6ebd18amr19534214ywc.13.1684970563562;
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id x67-20020a817c46000000b0055d7ac6ad99sm1975725ywc.36.2023.05.24.16.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 16:22:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A84E0222A9;
	Wed, 24 May 2023 17:22:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A057BE400B4; Wed, 24 May 2023 17:22:42 -0600 (MDT)
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
Subject: [PATCH v5 2/3] nvme: check IO start time when deciding to defer KA
Date: Wed, 24 May 2023 17:22:17 -0600
Message-Id: <20230524232218.1584605-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524232218.1584605-1-ushankar@purestorage.com>
References: <20230524232218.1584605-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_162247_182207_4D77606A 
X-CRM114-Status: GOOD (  19.24  )
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
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ad2b9b0d3b9..0aea6cd8dea2 100644
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
+	if (ctrl->kas && req->deadline - req->timeout >= ctrl->ka_last_check_time)
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


