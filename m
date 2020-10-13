Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32BC433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 03:52:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C5320790
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 03:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MbmCxhRw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="YnGXk/vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C5320790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MeyMefG7qTqM/XS8v2sXDnQueHlfZ365PydcmkGN7Qg=; b=MbmCxhRweJL0nzAziLUtcCA7z1
	Am3x7NBHcMtOE2KwE7yMatyMvEFzlpoTK7PCqhf7yZLUUFrfdn/ckp1JqC2/grUTQZGpbmKFDOFti
	caejOKxN+AhqNtldnYFdHkMNLbBFoH6ydng1eFfvTtISqebTw4CR2ZGK7m3m1zDPwWFTkvJVx8+ZN
	1BIDwgSFNbXmyZE9ArFDWNMmXFCWbta2Cmn8CImyhidDCuO9jJVPulJIypLQ4cxcuVCZsQdUhFn1n
	QEDct7sx4Z4QR9vq4K69HCwydbb89Qr5Qs2LSUg7eRXozFH3sOrE0mboaXP3SszenRcyWt6MpHL3u
	hCwNVDXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSBMp-0006Gm-C0; Tue, 13 Oct 2020 03:52:51 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSBMm-0006Fl-Kv
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 03:52:49 +0000
Received: by mail-pf1-x441.google.com with SMTP id 10so6306969pfp.5
 for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2020 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=rF/GowI+OvAJ42uQFXbwsIX+HPaNK2t5N3RW/GQ/QE0=;
 b=YnGXk/vAcRXCgBwy8MLksps3rFt3p3ilEoqr/MCgzGpqdjS0z5FF2xnKyEAjmriLQ7
 wwhuG32Mmc+3b4MaDcVazkZiweM2/QJKCZRhQwT1g9J8Bnq5qKdauFwCnfGZTn6JXNiH
 MlUjpXwKUWjt3HRw96gNWPidY/8kHyFjfnHNgB/Ju+z/AHZWKRp5eA9UQ0Y4qfIM6aMm
 RMZFpQJCgZyi8zn1sV1FVMAd+NYHLr9xbSyr4ZRJRLOEjhxwx1dTnV67km3/xoLbv/Mf
 d+crmL5AP9Xk3+0PFI/w1ZZdcFgdvUuMgTG8AG4Px3OyDzWrXVuyBjrV9imwzqwwmE8a
 f5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rF/GowI+OvAJ42uQFXbwsIX+HPaNK2t5N3RW/GQ/QE0=;
 b=rcn8dA+Dt28JEO1QJUQlpdr7uirsgnWVNCB7EG6LCZ7Fh44aWFxnBqBcMQmUo33nDR
 Miac3gPiPFqDH7iCkkuM++tr9G44nl3HpzBWCZpnHt2QI74kNVZ9KCq5UKgV5RSqePYJ
 s0Zsvw5p9lqnGe2yEIrzUQt2qdwz4IKBrxKmeJVbGBUTUu/bc22MNfH90fEqWXy4MJzP
 ETjkXVEKJEFCcPvr6xKRXGF9E+J458Dh4QwB8HZNqhhdP0ka5anj9IDQpCMysGBZ2Kjg
 KToBRw4uulM6721PDn2ZCpJ4+n4uBRWGnpwA34NlYYAxRjaWF4ZulEKKc7XCmjkdrQ20
 TzDA==
X-Gm-Message-State: AOAM532nrGHb4K3JIAIjC6kEx3yp5zVNetPrPahi6giF8K1cfXXICmDV
 X7k+R9xG+Ye+Gphxpcj7z10cww==
X-Google-Smtp-Source: ABdhPJwD3ti6zCilmn+dyiNX0Tjm1BhdN3h/LPiYH1j8u1eWaPE9HJ7Kub+GBj9WvRI/SyJOoi9TkQ==
X-Received: by 2002:a17:90a:348e:: with SMTP id
 p14mr23656062pjb.75.1602561164203; 
 Mon, 12 Oct 2020 20:52:44 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id s10sm9343998pji.7.2020.10.12.20.52.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 20:52:43 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH] nvmet: fix uninitialized work for zero kato
Date: Tue, 13 Oct 2020 11:52:33 +0800
Message-Id: <20201013035233.923889-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_235248_693280_8FF33BDF 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hit a warning:
WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
with trace:
  mod_delayed_work_on+0x59/0x90
  nvmet_update_cc+0xee/0x100 [nvmet]
  nvmet_execute_prop_set+0x72/0x80 [nvmet]
  nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
  nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
  ...

This could be reproduced easily with a keep alive time 0:
nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0

The reason is:
Starting an uninitialized work when initiator connects with zero
kato. Althrough keep-alive timer is disabled during allocating a ctrl
(fix in 0d3b6a8d213a), ka_work still has a chance to run
(called by nvmet_start_ctrl to detect dead host).

Initilize ka_work during allocating ctrl, and set a reasonable kato
before scheduling ka_work.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7b63330b5ef..3c5b2b065476 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -19,6 +19,8 @@ struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
+#define NVMET_DEFAULT_KATO	5
+
 /*
  * This read/write semaphore is used to synchronize access to configuration
  * information on a target system that will result in discovery log page
@@ -385,6 +387,11 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	if (cmd_seen) {
 		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
 			ctrl->cntlid);
+
+		/* run once, trigger from nvmet_start_ctrl to detect dead link */
+		if (!ctrl->kato)
+			return;
+
 		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 		return;
 	}
@@ -403,15 +410,11 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
-	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
-	if (unlikely(ctrl->kato == 0))
-		return;
-
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
@@ -1107,6 +1110,8 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
+	u32 kato = ctrl->kato ? ctrl->kato : NVMET_DEFAULT_KATO;
+
 	lockdep_assert_held(&ctrl->lock);
 
 	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
@@ -1126,7 +1131,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * in case a host died before it enabled the controller.  Hence, simply
 	 * reset the keep alive timer when the controller is enabled.
 	 */
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_wq, &ctrl->ka_work, kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
@@ -1378,6 +1383,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	/* keep-alive timeout in seconds */
 	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
