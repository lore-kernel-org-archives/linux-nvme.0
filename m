Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B85CCCF9E9
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=; b=lSOZNxn8V2ErqX5/5uQApN3W4w
	Jwro6/xJYAs3oTYQ+GH+1gX/Om9FJuNx8iL+bBRNSiPV/F4qNVw1va31nzYyZI8ZbskwMidr4PbkE
	9EYVqI0FsMLLPMMllPTxGE/IO+TVr5h5RnmfFDQPlZVoMSmvK0Z7I5Sm97pcd0++BCqWtOwEPziXV
	o9iQAdup/JGWrvRoXQRSqdrGhOh3CLfe+CL23cpV9mh7+OJGMxkckuZt14goXWiYfR2eqPOi1gowr
	db2CeVu+MkMQ905WNZdZNSxFbVPsO6mGjRhu2OiJSHilknViSzWs2fXNPXYDkGLFv02gkWfAB80Pp
	IRxL5ECQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZn-0000000CzDI-2an1;
	Mon, 27 Oct 2025 02:03:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZm-0000000CzD1-1MEN
	for linux-nvme@bombadil.infradead.org;
	Mon, 27 Oct 2025 02:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=; b=A/34NrlOuxK1v+2yoz4atVYNEq
	2oT6yL9FMEm675MRCQ4JyJ8xmk1mR855hgsd21gti+rc/FdlPCKe9WERaz3JUNXl5VszZlSe9YQif
	+aTZPYQ8WKEGZ6Qgd1u4xkwUaKXqFkFFK27MpWm5lzxdrRzLq8+9toSAol5108c0gYNls3U2jUxHk
	nYg0C3jM7wmN9BBmjn/BLtWgZrlqUeNlIlN9ya9uVPByXposLsxAJxJ/9VIZEptfcLL+E0GtaBXqw
	SqxUz7g9ODvbG8dTgFRcer82kCp9EcXYaxexorji0BsuOygprF9makaoSM9aslck8+QX/jH2BPEig
	BNpVkgvg==;
Received: from mail-wm1-x364.google.com ([2a00:1450:4864:20::364])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDBhy-00000001E79-1uuj
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 01:07:40 +0000
Received: by mail-wm1-x364.google.com with SMTP id 5b1f17b1804b1-471810a77c1so4476305e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Oct 2025 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530589; x=1762135389; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=bkOvNc5/dmkIZuu8bExCcokz2xWcbXnqeqSFzscTpdM09iDE36vFanROXNn5y0ieOS
         sHuWuludNqgl9K5FdN3hcpgkin4vzXQ+tIJPs+Tt7gl6lzeveUixQx5pPeue0AK+V1/i
         a9ohMXXv3+oft/Q0RGv51rnR8eaX5IGEdh8n1rlDuKFJuJMtVbfV+z9PaYZIkTmj3wWT
         QmfouzUW1eLVq9Klmy095+kBt3rRjphiisJizC2xpnaGdhgQINZFsHFrxJ4R2b4OU8ov
         66lbDUcQVOfZqAbuRtHtz3cWnhO4RCRlXvhjs0g8AojzH0RXBvVb1B2BcVLT5A/pbRm4
         LvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530589; x=1762135389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=R9BKNo4hL6DZvbK4+zh5nKG5/W2Jcv3nTWuchZA8yjZJzS1A5NNVcQuBU0h2ebnYKF
         TcXFEBrxKlc+t2qugt8IOe558zHjqpusITTnem6dEfM/E4ToLS136pZ8lVChz6gmSp7X
         N/rKLDsxvnk7l5a8DJX6Aq7nM/NvSGe7x0fkij/dicfOJreuyya6inV9OFVsUsCQ5NE1
         WSXRZVvT8LVKgLFHl0j/t2FZL0IW48rl4wa9ri7okDzukFmaQJmGyFnVvWiRF5UxibOM
         dxW1UTmzssnxw8TYUJiV5BxzuB6biCkEcUhPKmH1Njw1kyw7cjrtlRh6HmhJQK7AFg8N
         KF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXODdAR5jkB3n8x//3J9FiqmJrs2EIn7PIiqd0lyzjau6wDEpP2dOh33LWqhiW/jcoYOyd+5Ub7/zfP@lists.infradead.org
X-Gm-Message-State: AOJu0Yys1rP9ipwDdCo1t4HakIccNagKQW5yiYCCoQwPvch/2qDtvnZ5
	z/s4E5M57q3aEGDVxubW0D4A6T4oOISfIruyZOFROWkXZuAm8uM/FqWxcl7GKkdUcE/S3kbd+b9
	tDD4KJzcp2IVPJ3if6J5S7Q7BoIHOQfLCh6Ac
X-Gm-Gg: ASbGnctwRX8Yo7B42bOb/0bmJhivWQaSiUmGwINM1l3RKNQ4ydx3lIixf9WjnH8OCRC
	cFyxh989TekVCaut/MQk74dK1XYxVVOC7K9D4o/ad9yHvf80jFc3ZrAPS0N/Lz7CNzFG7V4mmmE
	T3Am/BeM+Gy2Ry6JOGKy9jbNgL1BMjSLm75/Y2jEXTV6mxSVyyBG2OcRrnfMqa05vaScrLzEMzm
	kK5jwpMWpY16xkm+H52mCOZVRS9LVSfSH060qi15LA63QvVLkys9TrF6WTmJO+9OtdYCqlberNe
	ZJWd/oQzNkoqXWPHGDiOsxV7c6sBsgPR35KqypIIn5caaeo7tY8Nx2ErZBgpAiF8J1e/rzWKPnC
	YWb5e3R0A/5imvwBMudhqL/Goe7xJMW4=
X-Google-Smtp-Source: AGHT+IENasqP0ZhtKF05fLncLOW0V3k4buf18cx1cMtCyilYnh1Ti+hR7o9I8wqQWZYLbNuPmDGjdwUp6Ttv
X-Received: by 2002:a05:600c:c4a7:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-475d7fe88b4mr40752065e9.6.1761530588575;
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-475dcbe5592sm5859395e9.0.2025.10.26.19.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F7A0341D24;
	Sun, 26 Oct 2025 20:03:06 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2CC8BE46586; Sun, 26 Oct 2025 20:03:06 -0600 (MDT)
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
Subject: [PATCH v3 2/4] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Sun, 26 Oct 2025 20:03:00 -0600
Message-ID: <20251027020302.822544-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251027020302.822544-1-csander@purestorage.com>
References: <20251027020302.822544-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_010738_782668_4CB0F749 
X-CRM114-Status: GOOD (  15.77  )
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

Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
it's computed unconditionally in io_uring_cmd_work(). Add a helper
io_uring_cmd_should_terminate_tw() and call it instead of checking
IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
Remove the now unused IO_URING_F_TASK_DEAD.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/fuse/dev_uring.c            | 2 +-
 include/linux/io_uring/cmd.h   | 7 ++++++-
 include/linux/io_uring_types.h | 1 -
 io_uring/uring_cmd.c           | 6 +-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..71b0c9662716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1214,11 +1214,11 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
-	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
+	if (!io_uring_cmd_should_terminate_tw(cmd)) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..b84b97c21b43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
-#include <linux/io_uring_types.h>
+#include <linux/io_uring.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
@@ -143,10 +143,15 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
+static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
+{
+	return io_should_terminate_tw(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901d..278c4a25c9e8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -37,11 +37,10 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 
 	/* set when uring wants to cancel a previously issued command */
 	IO_URING_F_CANCEL		= (1 << 11),
 	IO_URING_F_COMPAT		= (1 << 12),
-	IO_URING_F_TASK_DEAD		= (1 << 13),
 };
 
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..35bdac35cf4d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -114,17 +114,13 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
 static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
-
-	if (io_should_terminate_tw(req->ctx))
-		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, flags);
+	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
 }
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb,
 			unsigned flags)
-- 
2.45.2


