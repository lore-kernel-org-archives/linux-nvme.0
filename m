Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152FEC55178
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:16:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C47624180
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d6535x5L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TeiJuGJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C47624180
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mFpvgnWuu+k6ACh0QX5WIDCkoeCkQYGb/cT0r63sdPc=; b=d6535x5Lx34NZPCqZZTu7U8S8U
	+PFMBLs3vvnBc3ARfcsIPcqkM6R6OtbbOp/fX7PbE2noUbUNy3s+xs+wYx4aUvYPwmB9gquX2ERaQ
	1mviLdNqCiE1H+w8ARlQUeufcOpxoLgqvynAzbMPuZorko7bETg4lXPi6QHan0Cyk1+nZNI6SeWva
	eWr5bHemmSOetILa2HfzYYAcR2snLb2JLbmJNOta1IWeVCgWSvarFUHULO70w+3SVzsgQqPLwBw4l
	a/WqCr/dpNGlkllF0piIXxM7jLyAZqFteWFMlj+zZUqhKnaaYIOKJ+K+w3pollMM5QK1NkczuWNQw
	u1PX3xxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXNtf-0005b4-R0; Tue, 27 Oct 2020 12:16:16 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXNtX-0005YI-TQ
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 12:16:13 +0000
Received: by mail-pg1-x541.google.com with SMTP id o3so668995pgr.11
 for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2020 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=bY5Jc4p/lAT1HicP9cd/Mn/jdG/DRC+C+OaLB9BQQ3E=;
 b=TeiJuGJCVoHmMoYbKJvqLEBWQJhUZP/CYJYRHyD5aVsom0TC6+gFpkLnWGBNOgt3CW
 obWrCGPdkXut5lB5KCM5g5V1jIXjhRe64OZw4Aiwzp+5MtALI9OQEl8F2oYE4PsoVDaw
 9PMYUjIFDIRpzMnIVERSlVwkaQ2U8bWsdAzQiU5cTEuin0d92iiuxjT1NuQrDT3zINvD
 V8koTpY+qP2HzLmW+Vk4cfFEEiv1i3wDXaYRWbAycuCcZ3yaIWQH8RBWOxelc334ijLQ
 /nZQfDLTMGR19Wna1xlZ351NpJrMNWj6Pa1bCR2oUdSl4x7BglxrcZDIhAAePLwsjjbz
 t0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bY5Jc4p/lAT1HicP9cd/Mn/jdG/DRC+C+OaLB9BQQ3E=;
 b=gNEHbLNcTJqZ3RxOTOK9nosTXisbG4bSWJHRRfvcz7nkwvSHkhIdTuQVRv4knKn8+w
 Ys6lmsDURKpDnri2N001D7GUq3gZa7dTcJ4eyCPAAZ83B4fmuS8U/NMse62p2EZsTR/e
 7GT2yI89gLXFkvMq5z2gUGFTihYBFq0Pq6S/ON7f3PlN9fu2HCjkY8v1DPdn1/Hsxbb9
 JV/7dBbRuej3UwfE8s1NYoWU7la8KIu7QsmkrfBa/bA93Mn5MEobpzJ9u6KaNf1Q1yeP
 4qw+Toohpf6YKIU+vaVs/165c7wKOIH0OWGdgkp8JGNSSLdRQ//7NLYAV2yITpB9ABlM
 96kw==
X-Gm-Message-State: AOAM5323bfKs5QlBBWjdYvHoygcdjCaLq5BvrFqwJOjoD6ffqWmkTUK/
 ZDTbiJp0OhmfgTdarjxuELrAtA==
X-Google-Smtp-Source: ABdhPJxHeSly8oz22VuLpqoaRqUtAAdOV+3tgRhEhtamE/+0BJ2yGwTe5Hqn91b1hhcGKQkK/1UqkQ==
X-Received: by 2002:a05:6a00:13a4:b029:163:f435:28b5 with SMTP id
 t36-20020a056a0013a4b0290163f43528b5mr1978685pfg.45.1603800963925; 
 Tue, 27 Oct 2020 05:16:03 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id t12sm1820747pji.26.2020.10.27.05.16.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 05:16:03 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH 1/2] nvmet: introduce transport layer keep-alive
Date: Tue, 27 Oct 2020 20:15:45 +0800
Message-Id: <20201027121546.1776104-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_081608_065975_ADAA8519 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: linux-nvme@lists.infradead.org, pizhenwei@bytedance.com,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the zero KATO scenario, if initiator crashes without transport
layer disconnection, target side would never reclaim resources.

A target could start transport layer keep-alive to detect dead
connection for the admin queue.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 14 +++++++++++---
 drivers/nvme/target/nvmet.h     |  3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc..53fbd5c193a1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -729,7 +729,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
 	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
-	nvmet_start_keep_alive_timer(req->sq->ctrl);
+	nvmet_start_keep_alive_timer(req->sq->ctrl, req);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 957b39a82431..451192f7ad6a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -395,10 +395,18 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	nvmet_ctrl_fatal_error(ctrl);
 }
 
-void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
-	if (unlikely(ctrl->kato == 0))
+	if (unlikely(ctrl->kato == 0)) {
+		if (req->ops->keep_alive)
+			pr_info("ctrl %d starts with transport keep-alive %s\n", ctrl->cntlid,
+				req->ops->keep_alive(req) ? "failed" : "succeed");
+		else
+			pr_info("ctrl %d starts without both NVMeOF and transport keep-alive",
+				ctrl->cntlid);
+
 		return;
+	}
 
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
@@ -1383,7 +1391,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
 
-	nvmet_start_keep_alive_timer(ctrl);
+	nvmet_start_keep_alive_timer(ctrl, req);
 
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..de1785ce9fcd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -305,6 +305,7 @@ struct nvmet_fabrics_ops {
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
+	int (*keep_alive)(struct nvmet_req *req);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
@@ -395,7 +396,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req);
 u16 nvmet_set_feat_kato(struct nvmet_req *req);
 u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
 void nvmet_execute_async_event(struct nvmet_req *req);
-void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
