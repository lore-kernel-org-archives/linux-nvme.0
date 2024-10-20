Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F064BD3C92A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uRn4Amd24EVDYVUH1i1mZ9/GKGJm5YlRavS+SEAAK/Y=; b=J9V1tGXtLY4CyRRWrC9qsE3Akb
	LsKV/5GR27qBelDkch0jXYJNZQ5JQe+gMsKO9/EflgJIMApLxgppn/Fr8tEJKBbvgIBMy0qtwal51
	mt+2rAzSX4ZvWqf3ZqCWSLRfEgp0GKLeco1wAns6wRPnK7L1P+vpEabUXeFfTRIar0+7lOJOhjapW
	+ysZTj207cwON0wZ2rUcfdQ6RtnB6ZMIHJ6IK+WLy4v130gp8wkaalfLOYeaEqGpWafjSk9aSfsCx
	D5igDFeQF0FvGWCvD32jJ+TwxHBVWnDwVpP0zztfT7j7NcHw1CFHb0TUjsotGB3/lp7Qlz2Cp1idE
	/oPcVA2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2X70-0000000509I-1Q7l;
	Sun, 20 Oct 2024 14:40:54 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2X6x-0000000508v-45F8
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 14:40:53 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-71e74f35acaso266472b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435250; x=1730040050; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRn4Amd24EVDYVUH1i1mZ9/GKGJm5YlRavS+SEAAK/Y=;
        b=R90koYcS9fNXYPlUnmx5ZfPYEsYJQlpCymZHZyKz7qk5OuPGC575oCurAWb2L+Psm7
         TLmfsdgRfD2u/IhS6QoWVA2zm/qO4n9Aj+ViuiUqJaocR0GbK7+/acJBLHDTIKig55ge
         g+PsoQH5+6NahwNJDwv9PVWP2SEr+eF+hpSMwSbHjzU6hHt4/rFNqAXX1mb23PMkvnXM
         4xwbPo3c09EWrWdqXaRxc+4aYMaiBKbAC2th21zIsN7nLm1ZvpJHD7QD2hJoRAbemOyM
         lCA5E8KWLm+LDb0f/ky4Komr/eY1PWMTWW2IYmpxZ70h8/C4Yoz/VrwAPMnHNQSrFHFC
         pOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435250; x=1730040050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRn4Amd24EVDYVUH1i1mZ9/GKGJm5YlRavS+SEAAK/Y=;
        b=p25wEaWN/yYJPYhbYXH4Vn+rD0YpPbmP6RVehcTTsPB2DHQy+sC9Hd4jGaytjkI5Lb
         I4qzXDRdJkutOfK0P/gnybh9QLS1XCKU7HE9aF7Cc1OUXXQ7RfUC9FUlYE7e85CIF6nh
         koVCWOG3n3kTd6Xp3eUifXZvz3fpq2d2Puqqd1VIka6y9V8K88HLgINdolcbJQ9qUb0J
         b7rVFf71NtwywHDWnmA8KbOwp7Hi9UiUjWNEDVCuJDSbPxlU86bdXm1FDJLU7VblpG6m
         mX1b4cAymuYR4coxiWa3h911N81PnhprXFKu1zN6ejI9hKbg1o0EgMfG3ddFNa2XFclJ
         /jzA==
X-Forwarded-Encrypted: i=1; AJvYcCUszN4WYKOdeC6PduMKOx6LkfrookiII7abk39/imCWoVBhIGtd+m0rCmniH1Fc0+WXacnt3dOrZD/f@lists.infradead.org
X-Gm-Message-State: AOJu0Ywblei9nX/oyNyYUo1p1TOroNoQ3S40qytnW0lmSsyQIixBRgRa
	QBsuKwnOHST1JQPyfoEIklbwpeNG+P8W882K+GChm4IuUH+mg94P
X-Google-Smtp-Source: AGHT+IH0hiFp3O8QAFN+JSAxhXXkRWwP1nxuqIDaTUk68eT9XVPNqtCv6Pt30CcdJFdko3SP8VS4Qw==
X-Received: by 2002:a05:6a00:2d0e:b0:71e:5b2b:9927 with SMTP id d2e1a72fcca58-71ea31d019dmr5108215b3a.1.1729435250347;
        Sun, 20 Oct 2024 07:40:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7668sm1223326b3a.129.2024.10.20.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:40:49 -0700 (PDT)
From: zhuxiaohui <zhuxiaohui400@gmail.com>
X-Google-Original-From: zhuxiaohui <zhuxiaohui.400@bytedance.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	ming.lei@redhat.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq ctx fallback
Date: Sun, 20 Oct 2024 22:40:41 +0800
Message-ID: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_074052_048684_81A58A77 
X-CRM114-Status: GOOD (  20.46  )
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

From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>

It is observed that nvme connect to a nvme over fabric target will
always fail when 'nohz_full' is set.

In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
and when nvme connect to a remote target, it may fails on this stack:

        blk_mq_alloc_request_hctx+1
        __nvme_submit_sync_cmd+106
        nvmf_connect_io_queue+181
        nvme_tcp_start_queue+293
        nvme_tcp_setup_ctrl+948
        nvme_tcp_create_ctrl+735
        nvmf_dev_write+532
        vfs_write+237
        ksys_write+107
        do_syscall_64+128
        entry_SYSCALL_64_after_hwframe+118

due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
blk_mq_ctx on the hw queue.

This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
indicate that block layer can fallback to a  blk_mq_ctx whose cpu
is not isolated.

Signed-off-by: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
---
 block/blk-mq.c              | 12 ++++++++++--
 drivers/nvme/host/core.c    |  5 ++++-
 drivers/nvme/host/fabrics.c |  3 ++-
 drivers/nvme/host/nvme.h    |  2 ++
 include/linux/blk-mq.h      |  4 +++-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf626e061dd7..e4e791fd6d80 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -654,8 +654,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		if (!(flags & BLK_MQ_REQ_ARB_MQ))
+			goto out_queue_exit;
+		/* fallback to the first cpu not isolated */
+		for_each_online_cpu(cpu) {
+			if (!cpu_is_isolated(cpu))
+				break;
+		}
+	}
+
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (q->elevator)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..dbb9cb59e54c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,9 +1130,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		blk_flags |= BLK_MQ_REQ_RESERVED;
 	if (qid == NVME_QID_ANY)
 		req = blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
-	else
+	else {
+		if (flags & NVME_SUBMIT_ARB_MQ)
+			blk_flags |= BLK_MQ_REQ_ARB_MQ;
 		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
 						qid - 1);
+	}
 
 	if (IS_ERR(req))
 		return PTR_ERR(req);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 432efcbf9e2f..ef34958e33c0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -539,7 +539,8 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 			data, sizeof(*data), qid,
 			NVME_SUBMIT_AT_HEAD |
 			NVME_SUBMIT_RESERVED |
-			NVME_SUBMIT_NOWAIT);
+			NVME_SUBMIT_NOWAIT |
+			NVME_SUBMIT_ARB_MQ);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..a61b35b1cd90 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -880,6 +880,8 @@ enum {
 	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
 	/* Retry command when NVME_STATUS_DNR is not set in the result */
 	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),
+	/* Submit command with arbitrary mq ctx */
+	NVME_SUBMIT_ARB_MQ = (__force nvme_submit_flags_t)(1 << 4),
 };
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..d14be341ea4b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -746,6 +746,8 @@ enum {
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
 	/* set RQF_PM */
 	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
+	/* use arbitrary mq ctx */
+	BLK_MQ_REQ_ARB_MQ	= (__force blk_mq_req_flags_t)(1 << 3),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
@@ -824,7 +826,7 @@ static inline int blk_mq_request_completed(struct request *rq)
 }
 
 /*
- * 
+ *
  * Set the state to complete when completing a request from inside ->queue_rq.
  * This is used by drivers that want to ensure special complete actions that
  * need access to the request are called on failure, e.g. by nvme for
-- 
2.39.5


