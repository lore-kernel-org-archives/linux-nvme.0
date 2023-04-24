Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6176FC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bktBobLIQJBz6F6go4CLUNj0dTun9zbovKDyLGLgKPw=; b=xcfo1UAWqEOc3BCsJLGdm4mssT
	ISEPW4q2h8B82Lf8x8wpVS7+nJIpUTZ16XsCM6RoPJHEH/lS7oYeOmgoRqhmU3wgam7EJeA20kj5/
	NF7sJzWqSXYxjSnK69eYiTEr9yhK0N4wZdR8bqOh1jYvJVsZPy274rOAzsIESUqWwNsQ+YJhxnWyY
	YvU5hVYALh19gLQbTkheACKFOh8km0wwjW+UzLeF+Qxnp+NoyYeGa9o/phl05p25yOk+FpvQkH378
	o5rMqa55wWQrWyVxLDbIyONlHpkxzQ5g/YIMy8V3AKGBnRo745bC+r2qVjAY/d1gKkSzcwuZdSo+f
	sukDFHHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr6ZZ-00HVo6-2L;
	Tue, 25 Apr 2023 00:30:21 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wg-00HQ1q-1q
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 23:23:22 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-6a438f0d9c9so4000943a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682378593; x=1684970593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bktBobLIQJBz6F6go4CLUNj0dTun9zbovKDyLGLgKPw=;
        b=Oad9z/Gkd01t1AINSUmgObMIPb69YaB880oc9H8P5yLpSYCOJVRw4oubMKp+Pe0XCA
         m1TNBiBkfMJveJ+eWlnvRXELSzsrYOkUbEo0z2I8hbu67DYkiWnhTzqHlMKDfLQEvzbB
         9S+pWmFUClvTdXxnz5jk8b5Ra4TWoqsNJC45DFGLXZmFZRuXM7+8U41DMPhz2mtc6aVc
         uGaE4hvSZhghNwK+iY0OtNoUHEybtn0r+IoBFOVqIdvnhfaqopkE1UiXpvDCqSzDzJjh
         8Qy5urqiqK9pHMzrS75jxoTqGU7kg9yQ6FFaWy3fUrcSQGF2TvKGh1Y0I34KjVrr4RTu
         FEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682378593; x=1684970593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bktBobLIQJBz6F6go4CLUNj0dTun9zbovKDyLGLgKPw=;
        b=J20dEgnyxSsQ0ZfFyhH+m9C+y8HhbEMnHn/xRAMsGhQ0A9fcZbP7ijeGx6Dk0EmmBc
         csE+0G7Z9W+OvvKPjGCRalKN/bVNw5ysA+RZ+alzmsM5LkxioG5qNnGTz5eqZf9neVLJ
         0dGB46SAZTtlQFr8BhjKSx9/oRIl2S/dpVnsyz+UwodCWVpXqz9lT89qnvhS/tTKTnFI
         63i7Q1KRHF738LJFvDCQ0P1b+JHESTgbnbQ51FJDwpdvLsW2CfHYd4d1SnJOy0Ti7/S7
         YpAmo823l9xgK52P6HJ++aJfFFspXtRxjOADatZEhv2RZ/Bh6yOfV4M2LWNil90tv0w4
         Lhmg==
X-Gm-Message-State: AAQBX9d467g0TkZ3j0LdgJJtQqpD0aLuLY9wU+pJCiQNpDVR6yr8q1zc
	6vp9+iJFVesaKuxBzIDEGApuAUFaNM/AD49gci+30eC+CGCLfL77MPXP4itKwALMUA==
X-Google-Smtp-Source: AKy350Z1XuhZpaEOicwQU/EfgH5XTEIR/xKbniDPnMtYCGyxn37Z21pFGwV9t6cH8Yp8vF029O+Jl2yeK3V1
X-Received: by 2002:a05:6870:f217:b0:18b:15cd:9b45 with SMTP id t23-20020a056870f21700b0018b15cd9b45mr8829410oao.40.1682378592598;
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id v188-20020a4a7cc5000000b0053b829feeb8sm1112916ooc.22.2023.04.24.16.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 955EC221BE;
	Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 82DEEE41C08; Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
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
Subject: [PATCH v2 2/3] nvme: check IO start time when deciding to defer KA
Date: Mon, 24 Apr 2023 17:22:24 -0600
Message-Id: <20230424232225.1975793-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424232225.1975793-1-ushankar@purestorage.com>
References: <20230424232225.1975793-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_162318_619602_489F7650 
X-CRM114-Status: GOOD (  18.09  )
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
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1298c7b9bffb..0215dcf643ef 100644
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
index bf46f122e9e1..b7f9a93b2d33 100644
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
 
@@ -1028,6 +1027,7 @@ static inline void nvme_start_request(struct request *rq)
 {
 	if (rq->cmd_flags & REQ_NVME_MPATH)
 		nvme_mpath_start_request(rq);
+	nvme_req(rq)->start_time = jiffies;
 	blk_mq_start_request(rq);
 }
 
-- 
2.25.1


