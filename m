Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D2CCD1BF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=; b=RzQZpGyL/0HhzsZ8teVeLOO+Kx
	ktSFOkIIdmTIl+r4D9UKRGWYHrOdl0wcVdGFrxWXhwzmmHPSQ8XaNTPwBpNlTV1kz3riuzhJ/lgrG
	NgR1rQ1ss7tpHGFPLJndHjb3lGOlJvw1E9TFPI3QIlohnba8/7CU6EGAkyoeULzUnWOgo1p412RrB
	yRuXcE7/4snw8XU559r0qdp4/3AR52xsh85TnWNm/hBLDmq12J1mCUDU4ph6iO8mYMqVc2/lUxYxW
	A1Me+eMYwVhw/j364PK/YCeA5tymw1bEWVNs5lZPQ8a3qCnwlm5BeFzXKZP+Qz6fW/dgWu03w19ia
	ipRIpJew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1lg-00000007W3j-0AFt;
	Thu, 23 Oct 2025 20:18:40 +0000
Received: from mail-wr1-x463.google.com ([2a00:1450:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1ld-00000007W2m-2nIz
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 20:18:39 +0000
Received: by mail-wr1-x463.google.com with SMTP id ffacd0b85a97d-414507aa5e1so73685f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=Lszaev+pGUS1Hvn1BisYRlOqEO1IHz0U5+p5gi+1Cmzten6lhUclwMT6NHSGT0EXBf
         uyeRA5L4fty/+9FTtSPvPBQViQXhgl1BFWIJAJODBNAFu4pOPTqjSCGxUGftu4y7IhIl
         k7GiB1mv/yASK/cpVnlp5l1zCtf1f6znsNm5XaHrDGPhZaHdXNYXSaHbkKcG6874OMvK
         nytd89P9txLQMfywlgDRwJKl7HXvUdeeTBotLUqIxV2ESsDr6ABtSwaL/bA/HQzNX5Lp
         In+sgryf5WePV8QSMfm+2+QtpkV6oW1fhPmtc5UiNAFiHVv+7eLoY8PzHKDI36kpGbLI
         FZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=Mk+Eag8ub+xe5KY1/rIJgjLZ4BbrsJxnmM7jbWRSXOriedr5t1WKjeWOtZuwvCegTf
         H0wjHtnCAfrq8C3563X77ytO24O/i8xi24H3l6SzZLKUu0f59S+DasuEyJNy7BR+fqxp
         TfQT54Rgg2vxsGiJICNV40dSGJn+bRCk0fK4M17TjlrOFsj16aJ6RPU4i2ehDGdbYCka
         ivKbq9AZSDiIc3927lFGhi5ZPBB9+ED28UKcpf2Oaz8gon00gGr2MVM2j4Ue6u1D3Ul3
         cu/Jujub28b6jCHGQQkPo4ZV1QdFBz+kjPanyNmmwSijqXe4JzqMRh22rCQyCYG0iJQS
         VRCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdd4A+cA05y9BnVIKSTwtysR8580x5jCRcHUry47sh6eruqeDXrBG1Ih+EEB9965whnFEKq0KRS2g@lists.infradead.org
X-Gm-Message-State: AOJu0YxMvdcJTfNAQ6Ryg4rnGCexXv6h4K4BRo+DPi7+4+PIBaUkzm7y
	ZG3kimSzzC7zfkZ9DGm87/sWGGBHZjBGUKoVclnlIY3xLvAYV4oMqEyFu4RX6Axfs1dtmzIctkd
	18Cnbur6MRZ64KZIVK+A7ZFTyDBn9NnnBqhGXc+pGituDSUimxccE
X-Gm-Gg: ASbGncvpnOR0Un1z3iVPsuoQO7ypmCapni+EFH9zgTubR99pPY9uvvik3xCbUzXpiIn
	r9qwtEA2pfd2dyKbqbMVdZxNV5YxHfQ+3eoFX0Rkw1l+6CTcfAndz0zynwN8b6Sk1DTFc+KixVO
	9gIaB3zKyvrNOsqWcP3xaAbHIyowkgIdsn1Plb5CbXnz0mnDmMMoExBn1dm3nXIH+cR4guP89EB
	odnQnzL8OvmAACUfS3UPs2UV6rhDADWNdwIP4jTxhdXbYFy8oXFQSXpfndD//MUqt5mtAXZqnlk
	QOcy2NFLAG+h/Q7e/uqmAxHztjQtKQt2J1KYRVUg4wkIC5PYtBhTUuej9PP7z4ukVrI2YzHTDF1
	2CgE1gYlIfFwj2IqN
X-Google-Smtp-Source: AGHT+IFNnp/5OUSlZLEwl60VMSFyQi/nSnMaue4pn8b3+029XCgF8WPzS6GPvaglBgdRg0DxMPMd5qnGf6Bb
X-Received: by 2002:a5d:4e45:0:b0:427:529:5e48 with SMTP id ffacd0b85a97d-42705295e6dmr7178838f8f.5.1761250715805;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429898e96fasm244723f8f.35.2025.10.23.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5D2C8340875;
	Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 59FA6E41B1D; Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
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
Subject: [PATCH v2 2/3] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Thu, 23 Oct 2025 14:18:29 -0600
Message-ID: <20251023201830.3109805-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_131838_038092_F2404F23 
X-CRM114-Status: GOOD (  15.89  )
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


