Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A63CD1284
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=04EWYPQ3tqA1KddlrE0T62PVcteMsovJRtjGtyQ4xS8=; b=0YwZpW9AZEu4hHhcu1Ss0/9JXN
	DkXIzKDyQ63CeZHzIRST5nT31P3VVRN/U6I/8+tFsz6KWj0p/b+UV0c3JxhAYeg4yk4yooaHMWZKD
	CegV8tH36Ks2Wms+8jtWt3psR7f9pD36qQB9Ir+ob74t5mBFCGSb1mnm2XbwpDFlVDJ80a+7twa1u
	W536+Bjc59/DyjwZNP6/hKFsqBkvtxD5D/crvd/ZeI8+2gl6YkMZ7WgEILPQj6FhXn9H6S3Kw3Y/t
	dyQWqpDq8jwEPEB6v1CnFWw1qWJeZKcgbKZvz0RJLkbDFsZiKPYjUiRazAdmeG4mSaxgnKFVOo9YX
	4GwbWa0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtIHL-0000000BUZG-3AiI;
	Sun, 07 Apr 2024 02:29:07 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtIHG-0000000BUYL-08gO
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 02:29:03 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1e3dda73192so3423525ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 06 Apr 2024 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712456940; x=1713061740; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04EWYPQ3tqA1KddlrE0T62PVcteMsovJRtjGtyQ4xS8=;
        b=ILcwT3AuL1eRDHDMQ6jG3sd5LJAUhk3NVpCrFYXDe4T07YqQykkHRJ7aSMFEdSxqpL
         eLNwO1O9U4/zeX4yKlQVVLfrNLm/f5SJ+eaM8wk9zrts+uL07yl9tG5m6amZKQLO5wO2
         9iUPpcDRMIO3UF63K20dyxfBpvHKx3Kdd73T2NMPAVSIY961R54fWvZwhccSp73EayHJ
         W4lPnyR5E5wC4hTsxMCCB/+chLREeC26gIFUUK7ovJZGFXxM8qFjNmLNacqukb91VFXb
         YSUvVLtK1Azy9ZMu6THTm9Cf/jpyKXMihlYVqc5plCVQafkalSs1d8LomD0Q6IakW0eJ
         yhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712456940; x=1713061740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04EWYPQ3tqA1KddlrE0T62PVcteMsovJRtjGtyQ4xS8=;
        b=WRq6V3Rh9WviQEpZfG8m/dMfTiIs6AU6lWaWgbRzVE4cSKlqbWhNaz3jxIi2xlk5qo
         FDdX2btzsFqt6dd6wr2w7SI7SXKBh56vj0+ncYglXKFqnY8k6IvH77X2lYBCvrryHdS2
         HP6muZunr+CORTyZU7radHKBy0FroZKJVuv7mvtR386bGyhSidLWaz0wVxJI8rCJZ5fE
         MoXWVu/aSicGV3q75/RAaYmgjRe0PuwvNU6OBFzpuWr7dYHmYTWncv7eiyg8J/HfaxZW
         i17+VmaW+YXqcEfy7v/qWSwIr8C6bLjFT0auFsQ1VzKXwYkE0AiTnjfaXNvzOX+D6P5q
         LffQ==
X-Gm-Message-State: AOJu0Yx3MYtcBjnVC/WPR66hA3iwzFr35ls+pDkHOB/0vNTYTrf1ACJ+
	7x12De8wx4SL4RWp1S7Jg7EvUWfvXHTOENCtHuq/xT4QsCtOnXAt
X-Google-Smtp-Source: AGHT+IE37hWMmWkGJVGt79PlmEPyrgaqf8R77pgZrS+jFSfFKBChcG6cWpzfyia+njZbES3gFaYjxw==
X-Received: by 2002:a17:903:44d:b0:1e2:82fc:bf71 with SMTP id iw13-20020a170903044d00b001e282fcbf71mr4616512plb.22.1712456940493;
        Sat, 06 Apr 2024 19:29:00 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f052:3362:3c6a:3999])
        by smtp.gmail.com with ESMTPSA id kp11-20020a170903280b00b001d8aa88f59esm4044516plb.110.2024.04.06.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 19:29:00 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH for 6.1.y] nvme: fix miss command type check
Date: Sun,  7 Apr 2024 11:28:36 +0900
Message-Id: <20240407022836.6148-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240406_192902_104680_9A15F1FA 
X-CRM114-Status: GOOD (  16.08  )
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

From: "min15.li" <min15.li@samsung.com>

commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c       | 4 +++-
 drivers/nvme/host/ioctl.c      | 3 ++-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/target/passthru.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7516e99275b..20160683e868 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1151,7 +1151,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1167,6 +1167,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 91e6d0347579..b3e322e4ade3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -147,6 +147,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -181,7 +182,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a892d679e338..8e28d2de45c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1063,7 +1063,7 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index adc0958755d6..a0a292d49588 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,6 +216,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
 	u32 effects;
 	int status;
 
@@ -242,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
-- 
2.40.1


