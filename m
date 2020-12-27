Return-Path: <SRS0=IHsK=F7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370DC433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Dec 2020 10:40:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B1B20784
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Dec 2020 10:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B1B20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nodbzkkcEvn75FHKD60XNg664dJs7Ivkw0fV6N6Hkw0=; b=GFE2iV+kf6u/Xxtqiu1VoUrgD5
	yVnHakiXDxcPPuHPYK/Ly+tawQYFNQQlPE1YPgvxBJiGSjTBtXWOiHg+hueaAwDno0xpaMEUihOad
	8yC3xdzbst8rCsA4d9eWFkbxzc+G/NZA7N8zUYacBPILUiULyS28oT3m2eang2hRhKxsjPV47I9b3
	2lKiVzLD2nCHCJ+L4f5V5F/vmkjMaHP9yJmErpyLPOJH+rI4FK1MdKBkOQ2AL1ZxkDVMQBNa6k0zf
	chf7WCZHaj3ifGAHzD0BzyV7EEoL5oalImXkfNyiLQgisip8QqQDuFEPNJNcSMGjJfCDK9Hygu2Cz
	ObFr9xEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ktTSc-00025a-6l; Sun, 27 Dec 2020 10:39:38 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ktTRr-00024y-9W
 for linux-nvme@lists.infradead.org; Sun, 27 Dec 2020 10:38:52 +0000
Received: by mail-pf1-x433.google.com with SMTP id c79so4791862pfc.2
 for <linux-nvme@lists.infradead.org>; Sun, 27 Dec 2020 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=jidtfynS9UXDoLvr5LtFiZVRMnY6rZor3CWwDg7rK+Y=;
 b=qIOobmgg++Ap76E8QF89JE/oCNe7ntG3PezUpv5rD7ouMwZISDgsrTydtA5M5Kzx2l
 5VWiwL1AevGCGkAwfAL7kEn1+EGycM/Kb4kqh/V5nDowMAROrwvi+H5VROeRvkPXLUgk
 0O9oHSP91xyZjNy7lsY8kw7OPxb4BXihbfg8EMYvC90oAa6iy0z2k87XrelG7VcvsVDR
 EjCdKbzML1xDZ9LEwzropfmERJ7n0HD4PWmXLskdWJJQfp+418dcMdBYa4/WMjmDnLkm
 eqq/x0xJYDopqupWWI48xBCjGMg9ZJFjqnewuQ51r7FLLnOjhOljtrMcBDbqokEEkEHJ
 Zgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=jidtfynS9UXDoLvr5LtFiZVRMnY6rZor3CWwDg7rK+Y=;
 b=KarMnzfmbEMazd1TfG9sJ79aM2i7YSs4CwkvOHL285vtMYrefszFeeuo2ygd1Mw5eK
 vUERPACmkmfvdRuSR+6QPXos65omwMt512csukDjUA4sinae/vADERNLB5iQjjxbQ1k0
 uxyZ7lVWksy695+xowd8n65cQYpp2P/XzffL/0ufkGicXsUhuM25ahaoNfN/iMHYj+5x
 6pXvz88mBSoJDdJ0tp58Rd1mi502lCl6FV0anqL/tmOTH+oOrjYVc4Qh9WgO/9hzofUU
 ODKjG8Co8M3dLoYmnG0XGmIMWTMlXiYuQxd884nCo6y+FpuRKSrfRtfnZ75v/Pvx3qph
 fz8w==
X-Gm-Message-State: AOAM532WYsmEXpx2eo9rltiO31T4vcF4fmavfWzDUdiphBer+TpzRS/z
 RdjLochSKtTye9RPvOGAosXYnYtGhgjOiQ==
X-Google-Smtp-Source: ABdhPJyX7KI1nZy7Gp7/lK1YHbTPkNgaNAxBllIQL7MCNyzgfaLoT1kDVoEesvX9zajvVuVv/376mg==
X-Received: by 2002:a63:6806:: with SMTP id d6mr38724503pgc.205.1609065527693; 
 Sun, 27 Dec 2020 02:38:47 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id a31sm35688755pgb.93.2020.12.27.02.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 02:38:47 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: unexport internal function symbols
Date: Sun, 27 Dec 2020 19:38:31 +0900
Message-Id: <20201227103831.22319-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201227_053851_372868_63802DF9 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Unexport symbols not taken from other side.  This patch also make those
two functions as static functions:

  nvme_reset_ctrl_sync
  nvme_alloc_request_qid

This patch has no functional changes.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 6 ++----
 drivers/nvme/host/nvme.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..70a63d7c1d02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -179,7 +179,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
 
-int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
+static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
@@ -192,7 +192,6 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_reset_ctrl_sync);
 
 static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -578,7 +577,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
-struct request *nvme_alloc_request_qid(struct request_queue *q,
+static struct request *nvme_alloc_request_qid(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
 	struct request *req;
@@ -589,7 +588,6 @@ struct request *nvme_alloc_request_qid(struct request_queue *q,
 		nvme_init_request(req, cmd);
 	return req;
 }
-EXPORT_SYMBOL_GPL(nvme_alloc_request_qid);
 
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7e49f61f81df..9c4fbfe44c00 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -610,8 +610,6 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags);
-struct request *nvme_alloc_request_qid(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
@@ -630,7 +628,6 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
