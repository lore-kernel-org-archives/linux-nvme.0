Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233D0CCD193
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=; b=sbdivIziam/Lr1Tuhcb0DO7I/Z
	a9s37R7uP5xvtbYT5E6XWp/xZ1LH21xkR/GQR3Tp4yTicyjEh9+/38Ze4v3QDUwZDuEWQ8hIVtXGp
	2B+udMoKNcrOcSR9Du90nv41iBGUHeJvrTNH1mkzhcb2dt31O9mwQFhynpSYyMpD8qsZjVlUDSvnG
	fbKBtB8wO8Un9jvoQfrVB0sJZR62dWCu73r19NZQT8hT4j6oJ3dd5zsXKyzx4wl8VbGE0i6x7IvzM
	IJ7ewLkwj7+ka2SBeA60IgptyaVKLMJ/Y8U1N5fLmQlokQpDufr0icqOxn0nLOk6oUwpDxa7VWESo
	cfFDtx/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1lh-00000007W4e-0onc;
	Thu, 23 Oct 2025 20:18:41 +0000
Received: from mail-wr1-x464.google.com ([2a00:1450:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1le-00000007W2p-0kjG
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 20:18:40 +0000
Received: by mail-wr1-x464.google.com with SMTP id ffacd0b85a97d-42702037a01so199958f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=WHd4bVCyJ2yeszUUx9jE3X6XDirkOgSNrEJMH7RxntwNztAZOoyshk+SFtp22RuFSb
         925vd7jeavXv4qxuPLvJA4otEoLccvVKve9B5j4yC8xgusxhBNIrmOpxphXapoAyfE/5
         5mjwvkKVelYlryRU6NIIf6lAom7+9gqgscmBpMRICShnwljHRTUb/nKOj3a72saWlWDi
         A5fa2ogn/ejpXearLI77lT6wV4HhXxpvC70Yi8pmal4s7Ti5CzliYLmAtLPwI6lZidlh
         M1mTietGqanMicvjtnLEpOtVZKMcJSWLG4/wB9s9h3omLwzD01cpA27oeeMpqW8zGnvO
         sLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=Wt0QIMKv9ZTYtPCJk87qkci249t3JOQabzUs9AmiZsborJLmhrL3YZc6Eoer6a+jbg
         dKhEERFlhG/lelhFnStcZ9/H32E7IoEtKb2Sc73zBTTuO7cH/5MEr/SDyc43Vtkz8KaU
         cPaeisFvYAjalDhGJYOfaZXHGh3WwXI1uZcpnfAX7UzvBrktCIES5xazfUnpwh6yJ/OP
         iC1cLjQX/TqRK9qGanQy6Zj/7CzRpU+sJlkjSPD3Rz5+6zjWCveriVAt6jMr+ezSzlmS
         GwYax8MubQBKQrUf8+9hIHwKpDY/rm109jK5i/qfN0uDgE9n1WqlmUmtjFJXkgvpG/19
         wPOw==
X-Forwarded-Encrypted: i=1; AJvYcCV9gV098oqY1UC21Y5hzFYRfm+SOL6DxQKqHHwpVXY9Zv4aHL0kJfeqp86uZ5WPfhra4zrjqSxeurlu@lists.infradead.org
X-Gm-Message-State: AOJu0YxXITPMAE/QbvDYv8DFTl1cfMcoMz8RZpduIe4ViWcXrapilVFz
	iRuFKpXvo3Or/VVuwOLWHb2OkvgabXzyNq3A0UmwUs+x2alfig7L1McSdBQ8oKc0MCzCDXD5vlK
	aEy9SPjR/DfnRBTvVzOgSsqq68LR+oMzcgLIlTMDAySOT6e6WCM/y
X-Gm-Gg: ASbGncustzoOSt2N9IgPcO8MPfw6BH/7xAMsmlfKz22/4yXlKyFDRCWTZyQyv1kT8SQ
	Z8NZfYXbe4MOwis6OrK5KwAfFT0EemlrzAD142g+vIlFDaoL5pDm5nMFQYjsi3SW9XGfB1I38Oh
	BppaYNYInPVloP8ue/ISgFSrv4uk0gcl1ujQpLjCPlnFhAg5WxH6w6BHPtg4NvLQfbMv1ZmZrIf
	4ZeebZ20+36G6ZoPBySEtz1BUw+f9wjcnqWsWjq1y7g7o8Gl3SoSAi/Hzf48X08JM1m8rdkdt/i
	aeai2ul1uwESx5SI94ysjMln19yvJLy7q0Wd+SmqmyMII51cjUyfYbRFdPjGyrXKa1KTl/11l0G
	yvE2OpZCdukMs+07o
X-Google-Smtp-Source: AGHT+IHWadkx9kp6MhgZHi2KvIKXfztJZsFFBsc7zE5C/VRcCJIv9FwFI0VQ0GJaihcf27tHQSLLkNs29ZhV
X-Received: by 2002:a05:6000:290e:b0:426:ff0e:b563 with SMTP id ffacd0b85a97d-4284e52d956mr4357297f8f.3.1761250716288;
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429898e70easm248962f8f.38.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EBE47340772;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E9B1BE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] io_uring: expose io_should_terminate_tw()
Date: Thu, 23 Oct 2025 14:18:28 -0600
Message-ID: <20251023201830.3109805-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_131838_225695_CE7204A9 
X-CRM114-Status: GOOD (  12.75  )
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

A subsequent commit will call io_should_terminate_tw() from an inline
function in include/linux/io_uring/cmd.h, so move it from an io_uring
internal header to include/linux/io_uring.h. Callers outside io_uring
should not call it directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring.h | 14 ++++++++++++++
 io_uring/io_uring.h      | 13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 85fe4e6b275c..c2a12287b821 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -1,13 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
+/*
+ * Terminate the request if either of these conditions are true:
+ *
+ * 1) It's being executed by the original task, but that task is marked
+ *    with PF_EXITING as it's exiting.
+ * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
+ *    our fallback task_work.
+ */
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
+{
+	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
+}
+
 #if defined(CONFIG_IO_URING)
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 46d9141d772a..78777bf1ea4b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -556,23 +556,10 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
 {
 	return likely(!(ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
 		      ctx->submitter_task == current);
 }
 
-/*
- * Terminate the request if either of these conditions are true:
- *
- * 1) It's being executed by the original task, but that task is marked
- *    with PF_EXITING as it's exiting.
- * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
- *    our fallback task_work.
- */
-static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
-{
-	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
-}
-
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 {
 	io_req_set_res(req, res, 0);
 	req->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(req);
-- 
2.45.2


