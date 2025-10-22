Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF4CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=; b=PtzOmZKKRuTN3wL0/cjYrYa8fm
	dn2lqGxMUKOBZrZwvwdYQSSevQBXY6fdBrkvQc8ZxqaPXmXKb67i2x0mu/7kZji2K2ryH2y5dozJX
	eV3qVnk6bmiifIHR/fZglcouNmtGrkQLJ3SGnz6rYc7EwA1iMfJiAPlun4Tv2NNvigGWcfhObahV0
	5WBuMRzLuiB5BB5T6S759g0dgkhycrJuJbt1SprL7PXoG/j9Dk3U6XyAYFTT9XRSws1YTBLRZhTCi
	uZLldKgzIlNo06ugA8LT1bn9zbZtbVDBJL6ngvafUEbstnN3XIZ3va1wNbJ+jwGJWCp7951pWdYr9
	/8Pr5zzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1a-00000004Vva-2OIC;
	Wed, 22 Oct 2025 23:13:46 +0000
Received: from mail-lf1-x164.google.com ([2a00:1450:4864:20::164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1W-00000004VtN-2KAW
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 23:13:44 +0000
Received: by mail-lf1-x164.google.com with SMTP id 2adb3069b0e04-592f2d0d3e6so19811e87.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174820; x=1761779620; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=MbsE8gHAFSCSBMToWpcqWWjU2qH2iafPwiEZGYcoWKl4f+b6WfRKrZsPmBZOyFzIB1
         YzroGs/LOeXP+2nSOgJ5tvG87U/iIdGaoCbveYQ7xlL45cOIDDteFyUgQui5LvK7f2C9
         9DNCJP4J+YMC57EvXfonNlobVDDYEs2AXW6HPEuW/qr2RRSaSHQPpqt+FzfcBMgzWibR
         qHxGLKftVwgZUzT16rjenrkc97XwZb2D25uzqCD72yTm7Lsi7/RwdviiKCX94GCVINP9
         g9sygJOvwMQG5uEENX4Yys7nNcL8UuJBBQGZuCmZMSxModwHEeEq0hPngOpoxW+PEHMW
         s+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174820; x=1761779620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=l2J0nSzGzV1idFjLeqIkMIsI+ltNMMh4j4GIjH/+94x8k+ALkOzzcXqVpqCbODoIGb
         vDeaf8RrqskPlIk6Qc25Ae7tm80h4y+3bcxCtXPDPVaUJDb9XgW9v30CLXd0GxvKehxi
         Llzd94UpeK8xTa3OLPzWpBF+9cHzcpOe3MGHoy0/KgkPybWBvEtXe8/mcSCWTSpzUS0B
         DGeHInC9VThRS97K7dd5uO/IT9YxzqylyzCJjJsAAXm+6BBS9NUsam8xrDsAcTEu3Sl0
         ghoWrxRVIY7p4LFLs8/u31CjAY/AxqxBklpkTzh1NIx/CDEIr0upzBuvRueokn8dXh4b
         wocA==
X-Forwarded-Encrypted: i=1; AJvYcCW1XE3JLe/JP4jTcMXUkQFJjBxjLqy+JKrx82B1Ohy1UsbSzkIZE0I7WzzFRQaeia3Bi+JU0U7Z5Yb0@lists.infradead.org
X-Gm-Message-State: AOJu0YxWN0OXT0R1HTU7UTN4ND4cR1RsSqnJJvM9gED3t6cKgnUW/37g
	BFYYEf/DccIvHrtQveXBKHVPgln4fUI9MkkpDQRV5lAKnQtNLeNZvQlq8LVMJULev9rwtjGLj23
	/aqYgoDstw78FmRfTnGjB6ggb8NNm0m4p6KBnoTx5Se6sOxdm6jrZ
X-Gm-Gg: ASbGncvnQaZgxY+Ompr3mqtQXa4i+F7OleqqMN9FJA1szwef5IgK95qgnKtp/cqmf3k
	AQNrndjp2RPP+lu8KXBzJyMnI5HgN5wwiuHv5shyreIEx0m0uIykZWCM1+SOlKsdqV1GZPhqo90
	wU3qMZ+GKTBd90+/oQFKybpj72Jymh074wugVlNLBQx9UTOTOy9A8VYNSHZXbRbnVW0XBVRa9lX
	/N7ICDzLUNg1eRv7Rv4Hhp4oxQp0Sd4p6ks28cAOwutlbwSZkfQNmI7sfJBRleoaDdl5L5gB2rU
	imVrgr5XAFTPaCtsvxm7t25rrHVxMKNR52ji23ZfbELjUlTLStrPCTWg5azDLPaLKdhRAuYDjIr
	T0o5aKvQDdRBZSMtO
X-Google-Smtp-Source: AGHT+IGpBSpTcUsGiFW1y6xN6RAigIl6sP5f7WQURKVhSLye12F+OPVHcs9jbRx67/PqsX7m7H0LAVn7y4om
X-Received: by 2002:a05:6512:2209:b0:57a:2be1:d766 with SMTP id 2adb3069b0e04-591d854a5a5mr3690398e87.4.1761174820364;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4ce7a08sm35160e87.29.2025.10.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B07D23406A7;
	Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AD471E4181C; Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
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
Subject: [PATCH 2/3] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Wed, 22 Oct 2025 17:13:25 -0600
Message-ID: <20251022231326.2527838-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022231326.2527838-1-csander@purestorage.com>
References: <20251022231326.2527838-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_161342_619007_4AD70A9C 
X-CRM114-Status: GOOD (  16.37  )
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


