Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA09CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=; b=bdf8xMbc9z0zee1j4AHanyJ2cu
	Ju5n6dKmotKret2M/Wz0Dxj1KErL9oHWg/pJudm3+XrJAsrnKVWWt9sx1x6yfTBV2WQW9AmXmdy7G
	9v+DyP2TA8JrTStX4FrG5XV4x9JfYugqvqRnoGRN+iOlgDfGz1wnQFvTW5M9mZUnFUZBSBuwpNG2S
	NmxAVAZg0cFC31eqSbHaxqv2DiQ/kDEB/z+jp892xZB2ZMctWs8N+RRHGRRY0/A2D3Z0YXmTttY6E
	1Cf7ch1KWEofql+4oj4z0bDgnI+lwKNOeLIpIpDkM2RBQADK/E3sLLAhMh4QYlMS9JxEnztRS0pnG
	JZ4UJzTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1Z-00000004VvR-3gKR;
	Wed, 22 Oct 2025 23:13:45 +0000
Received: from mail-lf1-x161.google.com ([2a00:1450:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1W-00000004VtL-2A6a
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 23:13:43 +0000
Received: by mail-lf1-x161.google.com with SMTP id 2adb3069b0e04-592f07e03f8so21022e87.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Oct 2025 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174820; x=1761779620; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=UhSdZ4UJYJxhTz+/K++DhCRzaEQgOk5XOUfjhrmQcVY+ajk/35uOR/IcJFEhS66Akd
         mXDJflPcItJH7jkdtDIceG/knXDo92D9Qpg5IuXCxJAFIlDAaZgkhAZcP8hpTPCy5+u0
         ou+9/K7Lz2gLQXxH53bYur1RqUfMT2P0WNWgjj2UTEeUex1QTeD2V5FqfWNZS9/pHC++
         nCrj7CXrde2MTjSKpmhI9AymojZZQI/2K06k1nrfx+KyTYYX5Hk1xIvvbUKJDjJaVf8W
         eAm+AvwPRVsPthzZ+Ef7xZ0c2PrXzJiY+ITf2ejJRwS30Xzt7h+7NPKuLqeH/GISG/8F
         iSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174820; x=1761779620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=w46UjOOFmJsZRU/qIZW5GpLdM4EHNLnuuI0BuAb+HL9RqwFv4WS6YYZTD500FJx5AE
         sygbnP27nu7Tox2vqn9cflO8D1HiFTIj6fzIvuG/o42A/w2d7iblFVszvSrTamU2GOju
         ztGq9x67LwBOLVIPN6hd7GQ5pDPO7A6ERwdPs6l68s1TpjBSeL40Df3KSaz6Ru+RGFmW
         g3wSyEDvC1F36DY21QboiX4Pg9NxvzawqN1xLYYV6qBeBNSPgpicjhxlVL1biG0AOGKz
         KO6IFM1gdLtOFgJodlT7gj9L2P56vl1kxvfZiKOZuJqcI/GO4PPlfG9RZQStZ+zIY/Ks
         YAug==
X-Forwarded-Encrypted: i=1; AJvYcCU88uVUS3V61oll0UAuJWxlKBnlkHu6OcZFb+saqVpHMsnQvtPrUijg0GjqhW8HmlRi5fpR4fjjNNVn@lists.infradead.org
X-Gm-Message-State: AOJu0Yye65seMIRlgDz/I+W7PqREPPGeJhsQ/I33qGcuU51LarOnNC8T
	qfdw6pbsuQFk/lVVh5T51U44tbYevDZkUbmMw+FtbVZnbg/JR/QxPbzdjsm4OBP5HDsxoVJnBzm
	7DtWq/Fq9BbSKZ42YVQhQ4+z1mabkT5KJ3sJa
X-Gm-Gg: ASbGnctckr4Zg6Hm8RwOuSednPakTi+PCFl20GO3orAWkjpCh9K+WfikVRDbbGM2VQp
	BWGxd0E4u9lRn3xGP5vlrtAKBvHdwDvPwAfoovO8OXHmOrR/9mMB+V1T1MUUpxXd3GKeO0LXAGt
	UtA/ALyzC91dYJPL87xWbxV/MTf+DXbIL5c5XRPIBWMxSwZeBwccRidYeUVBFgiHvDJex6CVVhM
	UuC2ceX7VI0SjJAd6pldjYapCB856Kcrx8GXClQDBUp9fWVeDuDfTP9IAL+k2slnbocGqeN76ht
	YTs2P3YmxIyz6PCUL3dfhUrrDUTE8b0XPxcyRrdrqs6Jq0tc52de3VV5naGDAkySWnalSFeIUCe
	hnXuF30pTR75WdEkPyxLOxZR9g/9GsAc=
X-Google-Smtp-Source: AGHT+IFL+l6RiiF9NVqqr9YCIdVCyARHhrDoK0DxchCYTCey03a/1xzZtxLnzmVhVLR9bTz6N+i4aHRAWF2/
X-Received: by 2002:a05:6512:308d:b0:55f:6637:78f with SMTP id 2adb3069b0e04-591ea31cd1cmr1457181e87.9.1761174819856;
        Wed, 22 Oct 2025 16:13:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4e44e32sm33929e87.46.2025.10.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 372123404B4;
	Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 307C1E4181C; Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
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
Subject: [PATCH 1/3] io_uring: expose io_should_terminate_tw()
Date: Wed, 22 Oct 2025 17:13:24 -0600
Message-ID: <20251022231326.2527838-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022231326.2527838-1-csander@purestorage.com>
References: <20251022231326.2527838-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_161342_606921_DC35F329 
X-CRM114-Status: GOOD (  12.93  )
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


