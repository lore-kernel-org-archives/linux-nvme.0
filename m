Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121EC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 11:23:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FC020791
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 11:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FC020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4GuQdI1gD0ZfxRXZuzwGlObndB4qg5g7tp1Nv9DlJow=; b=Xzsh74WZcKiXitiip2FKNjAq1r
	8vUGDIC9GvDxZDC6kNI0q5GcAk+AgI4YbRy8B6ICNqaqnD5g/IBLKc5DgIsf/Q70ONWKn9FTbm3fq
	DwPYm9XscqVfaAaG3k3TcBEYJmZDCQY7b2bXfk8w7y/0n9kbR2dFmmyBS8omBaquqA6PpKB5eTjz7
	1jI5X4UWu/XanXgqNXCgJfPpC3SwwYoRu/N2j0FUYlS8RU0XnUNCNNSby800a4go9rqFHc9zJdlGs
	RGtR0H5GLvHNh59nlILOUTg7CQhMak4Gd4t2MxhHjs+SR1+Ha1pxbEyCjOGAksBkwZeeoVcq5m2xc
	+IK2J2zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kuZZD-0002sq-3x; Wed, 30 Dec 2020 11:22:59 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kuZZ9-0002sQ-Hi
 for linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 11:22:56 +0000
Received: by mail-pf1-x434.google.com with SMTP id c12so9543837pfo.10
 for <linux-nvme@lists.infradead.org>; Wed, 30 Dec 2020 03:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=9drncfQWew0LLoHItgktm+a+6ndpB5m2mQLH20mcKbo=;
 b=o6vf+xC7ETEob0hYubnqVUxfDfD+8UAFL1+4YJk/X+7/eoGx1p+9HKBV+O10wuWQCV
 D2guvsLeLBCP2OUyq/pkxTyP+Cmwxv4D7KGyUV0G39EJXTmmUQR59UMuXVSKTDOIF0tr
 vtiFwcYZArckrV9isFEg5t6WVWwTid6va/7NrD/2h5VnM7niRgNcP2mUqDNi54wnNv5A
 A1CTtxPw3u8rMnxRyTb29DOuTBPol/9hvHUBR9HY5FgpDowHjds3nKSVGH5Qs9NZNm0W
 Ej7Zqj9o5hjqX5gg74mJxn7O+jbRUM+imrbNJVs0oHrUjaxvpgiIFt1ukOHCPZuwEtjE
 nVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9drncfQWew0LLoHItgktm+a+6ndpB5m2mQLH20mcKbo=;
 b=c4qmG0emrHUWLBXv+i/RWoawcKEM67H57KbjAFlMBhX7MMuxPRbaS/636p9/jk65eO
 XaMj5ErfhrxdD8UMQLsN6w1u5edLVeQ/DyDwiYuI/B4zP3896VjGo80XFkJOeeGTnWLH
 HxLwpyT8/F/BkrJGxU15xmGBAD1ehzuikly0fiVwRhjEDrR9+OumhayGja0WUBW4iOtY
 3Nv5WVUTas1tAX0NDKLBvN8bMpGVqiFV1DXBB6qVSbxkNZfWEcnoEEUqQjz9ABdosw39
 us4INSNaKJYJ3rp7/vidFSas2zDeWZMf3MByD3SEPH0DDjXi+2yyy3+1l6cmKa+vz1qv
 3a4A==
X-Gm-Message-State: AOAM530fw1dZGjGZ3TYU1nbiPHeeJX/UqjifgRHgf9p8TtMtPxS/2VMe
 KlovzgAj/BEw7YNvhfoMEIGY5vVYtIm9LA==
X-Google-Smtp-Source: ABdhPJxANz6+AfdaaGDB9D2cL6KnatyksEz4/UvZdScaVK36TmlYsir7RbrQ+hcDBu0ZiFZngHSOBg==
X-Received: by 2002:a63:170f:: with SMTP id x15mr51795679pgl.157.1609327373303; 
 Wed, 30 Dec 2020 03:22:53 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id g7sm6786111pjm.46.2020.12.30.03.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Dec 2020 03:22:52 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme: unexport functions with no caller
Date: Wed, 30 Dec 2020 20:22:44 +0900
Message-Id: <20201230112244.10970-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_062255_624645_60E2668A 
X-CRM114-Status: GOOD (  13.56  )
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

There are no callers for nvme_reset_ctrl_sync() and
nvme_alloc_request_qid() so that we keep the symbols exported.

Unexport those functions, mark them static and update the header file
respectively.

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
