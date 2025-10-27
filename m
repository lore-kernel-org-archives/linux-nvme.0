Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BFCCF9E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 02:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=; b=c7GXYG7MxqDpgEDvLYudFmRZ9O
	wx5aTt1m1zWuqZIclGqPd7DJBbHOpsGVfznRhve92Mh3UGBDecvmm0DTViX/aAYwFvcTP/WFevruO
	uQF3IX/wKT/3PdRpjX/1Biej2kXfLwnBJdeMix0iKfLgXJYnrNVr8ixTllvsepj0raHrXae285sML
	rjUWlVOEAZF2vggm6ZjsT8iLNXNe8SaYSIItKDg6e5an60D7srhrCd4UlL16ciTevPU5DSQbIL0bm
	yfB6DNmo/lOSXsOcJrJuuSGraPL5OIYNKANgI1wzvWKio58tC2Kfgb7ssuL86H9/3HEHOgS1sB9yV
	02cpKaNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZu-0000000CzFS-39qo;
	Mon, 27 Oct 2025 02:03:22 +0000
Received: from mail-ej1-x663.google.com ([2a00:1450:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZh-0000000CzC0-0mfb
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 02:03:21 +0000
Received: by mail-ej1-x663.google.com with SMTP id a640c23a62f3a-b6d5f323fbcso71897366b.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=F0dmwgbAvRrPyOsPPGyk94sBgKDtvmDFk8f++QNLrvbjbiibf9aVBkrRu6fsa2PMtc
         APCq72BW6PbKAOqCquhoxUzwlr1u89Z58J1Tnb+vDh0SQGs5dxSTcg/DdrEbkVsJ8jIS
         h7gEcmDtr+NOpsK/qXPFABKK6BKyq6Iw8HAgzg5oKAOigFdzlJb/y3poYjSOBfZjYAwe
         3ChHRNadbc7ry+dPqantizBJBYb5wvkc04dMwhqCE++hM8rdNr5CafOb4RL9gJXcEFiS
         VzrtpxHJFs6FeMaYuGVcSqBxEdROmmlbGRngum/ohtWA3LGjiO3ALgsQnM2++KICd1Pg
         QyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=hhGMqgZyFpfEsw1B1//FfKyuSvIFU2FCC3zpnsXZNedmnpOhJa5dSUOehIpww4/M8x
         dX3JNnmLDsrEipc24AaTbCINkWZQrxf1GEUB7VZ1mxkiKCx98i8JQUKmaP/WK7wmWyiw
         l4/LNrBUleByRiTvNdFMMO+6HW0Wpzp9QMKzzCUUZGrZDO5sZ4uONrxzU49Bh7ouKIN2
         LgU+u798DKLCbX/f3fhXsWWtgjAdPVb9dzRJSzay3DbX1dSZ92rvyCAfUGCfxdL4GNB6
         ROf+i0LZl+MsA6q8xs/VljStzMzgorArn4KJcUo8tmq8+/7Pl7epf/2z57ZnHQiSgM2I
         95YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGpRme7ex7nzF/CPDJRGq2XZxKi3M3HsMmI3KBXY/L1MlCzfxmIWTifGqWTnOgTUMz6EmsUcz0VNvq@lists.infradead.org
X-Gm-Message-State: AOJu0YyjYzY6DAz0R4qbn+Dd6o3xsiG1zxXZ9n1E23lWCro6MXlIjt7J
	0mFot2ArsAlV5NvcFcwXYl5FWnY2fZGMNfflMBjJPl2BIh+fYf7Hqrhwc73F+Cdg1+u3fLnk4kP
	MXoXytFdE7h90ABl06MMYtqpHSUOsy8XJ/V9r
X-Gm-Gg: ASbGncu4BImNsQNCcU1ZGIuTaDt23oMCg769WlxV5VGTSGvJ9YrFeKxI9JFlxAQ5Xez
	E9VGHINZJvMJSIlKOVI3qLna+7c6u+vyT1ZQ3MTnR72qCDhnFmo4NciOVGC5X3+IAm0NZy1+5Lq
	UumtA+lDl6Q/dadXkTZXYvZmE3l99zJTSheVqV6JMQHWUApo5GCyUPEw0Or6jd3YxOZmXPXRH3/
	cZZc106rwcH/4FjTv4lcA0XsD+Z4zQ0x7u2kstz7ogxdVxbr3ub3EqpFbYGePIaloFHAfLvClxL
	J0j3ejcalEuKtywMHMeWj1pdPfzbM9FLN5tuEX2O8SgidYQKjKJUvOaLHfumvz2cuCeWk5wA6Pw
	OVGAL1qIfWq4p2j7MYe2/TEb6DpK3FcI=
X-Google-Smtp-Source: AGHT+IGMoMb/41FNBYew5aW4eybeQmJ4NZaYT3SIiYCnt1CmEPvxyf464JNfGnI+afMOqCffpcuFgIb+lJb3
X-Received: by 2002:a17:906:fd84:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b6c75d2bbb1mr1544924966b.3.1761530587070;
        Sun, 26 Oct 2025 19:03:07 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85462057sm55892766b.72.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B192C340670;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AEC5DE46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
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
Subject: [PATCH v3 1/4] io_uring: expose io_should_terminate_tw()
Date: Sun, 26 Oct 2025 20:02:59 -0600
Message-ID: <20251027020302.822544-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251027020302.822544-1-csander@purestorage.com>
References: <20251027020302.822544-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_190309_234752_29DFD1F6 
X-CRM114-Status: GOOD (  12.50  )
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


