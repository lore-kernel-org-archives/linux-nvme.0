Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B45EF48C4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 03:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrpUavd9Jn1m5PTul6V14FFmKgASSL32mDcwIWu9GWA=; b=GB7RhyOaorMwfsJyUYSW63quqK
	GrZvzlWBGPzPb9e6TgwCmvZ06YG2GwYxAVRr5rXkkmaPy3w40yKDU+NwnbZbkCNzGiar+48p/xyLa
	hFkQEGyWba+PFuHiA5NbIVyLpJKWpkPa92SQ+q1V+X8+zrZN6FNQyUJ1AaLIeRnlLTYpgoTlwUNOa
	IRvDI7tBpNjYaEAN8Q2lBqQobmTIFMW1STrKwjTRMpjGbs4lTZOeeynL0f6JXz3CpnswGXmaQ+LUy
	VXIrfAduEblpP5FU0K2YmVRlhrdAl0pH+PbvCxeNNDgHdmienmgl+kjYV1N0bOXmOz2pN4SJ7vWqY
	3OdWbRxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkP-00000002uG7-0a9n;
	Fri, 13 Feb 2026 03:21:37 +0000
Received: from mail-yx1-xb164.google.com ([2607:f8b0:4864:20::b164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkI-00000002uE3-03hn
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 03:21:32 +0000
Received: by mail-yx1-xb164.google.com with SMTP id 956f58d0204a3-64b3801600fso82644d50.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770952888; x=1771557688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrpUavd9Jn1m5PTul6V14FFmKgASSL32mDcwIWu9GWA=;
        b=cr/Py2DOPumrg2SFgTzLJ/D1MlJX2ppqd8l2+upR0PRbCLYeDFYSl2/SX8gLAfidD9
         N7kdi8eKK/kVqiZt2A8XIsoJ/v11USoBEK2uceaDJAE/c7crfJRfDRftG9XdbDIY5pC5
         e8LAuRRZJk9c/9K/Wq7tvKut+6+pAKdreX/+6KMLkb1m6QR6UqQNfOSVOZ/R3/iN6mYe
         5xvJVbWv4Tby0GY9a7DM03N/012+f5b0CXmBUnK9Drk1TeBij/Y20B8DuPAxgd6w3JmB
         pDd8VEP3BX+tNbE1pf8MDZhN8XeLmZyudQxuYiqAlEAUWez/u0Apo6rI5/4xd/3hb5qG
         hXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952888; x=1771557688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrpUavd9Jn1m5PTul6V14FFmKgASSL32mDcwIWu9GWA=;
        b=Li7cTvwge0vTZuQMYBmLqd4JYaiRKa2fidJ2lJ/9jh62N2zaWfNYvkMssxZnVE4MZX
         99BGVvApKUJylpywnbiOa9zY/w2Jc5p5xcOUrSsue3BS9Mf6mTdlYP25VgxkQFTBzTaJ
         ndC0atJVxZfk8reAzCnw6DQJ7FM6GPNOgYU5ir1TmYH4QTWkNUMIzQzx60TAoA5pQjhA
         +IY1Y+YBWhWAr8fdkQ6L0nGnVpD+6dQePs/LFEYE7q5HvOuXcS+wZCaC+ScBKWxLEc/P
         WNE4+670gshGa1wIkuZ3plZVbIeL8IfpmpLIMNL9Q/VKWuarmygdhVV61+0s1Ao/SHUm
         YT3A==
X-Forwarded-Encrypted: i=1; AJvYcCX9y0y+MaRcsLfrDooeRBZQer8p9J9pNTy8M6YN8sB/xKEMK4AVyxmN9rIx2Kehnj9rDHE8wT29TuP7@lists.infradead.org
X-Gm-Message-State: AOJu0Yz174AQYCGExcR5tjDuCbO2Lc9VbDBfUE2tZ81NWmNkikpA/NaU
	vB5k1GzUTb7lQ69WkFAuUvPCh6e6YxR8DP3iUQ+KgTodkemgoEIjq2WVGbz4nydpHUndd458oah
	h6xuT63Ke2rL89jUXMQfMSEprrFFNCaMLJAtR
X-Gm-Gg: AZuq6aK0Bdty1NXeV5FVIPJdMUDqUVdNZdublj4BCUI/5VKfcHROzGzeF0xTaSGxyaT
	ABRCn+hH9dE2/QbhE169XYVei3p+g0pDTf5KUOj4dY5mReUmISC35MoorYtEecjf7qloE2HlMGW
	INoy4XpFX8U0FaD3f3vP3uGZtnMw7jaAUIAdBHtWFpRWPaGT3hXz4q4tuuvAkVVkD36Zx8BR81l
	ZBfd4GbqEjAFXN78YIwjPysFImEkCBFTgzrLmbDbwTIWwDliKbgLK/sqK0zABIMKRwLQOyZGmu5
	wrrpEBqLrSPvftnhTnf95bx9KDELBzRMPHICfuWGRXqNUPq4bf7ID+0UVNb2yr6TpFiPsGM98HW
	MaZewn645DSVfXHdyUBuKmIspw3q1b7ODJRTlsLyrEneAjhSsRRk0YA==
X-Received: by 2002:a05:690c:c509:b0:796:228c:ed96 with SMTP id 00721157ae682-7979e6be482mr7685947b3.0.1770952888296;
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c2328fdsm6537797b3.14.2026.02.12.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AF4A7340705;
	Thu, 12 Feb 2026 20:21:27 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A9CBFE41DCC; Thu, 12 Feb 2026 20:21:27 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] io_uring: add IORING_OP_URING_CMD128 to opcode checks
Date: Thu, 12 Feb 2026 20:21:17 -0700
Message-ID: <20260213032119.1125331-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260213032119.1125331-1-csander@purestorage.com>
References: <20260213032119.1125331-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_192130_131839_437B2F0E 
X-CRM114-Status: GOOD (  17.98  )
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

io_should_commit(), io_uring_classic_poll(), and io_do_iopoll() compare
struct io_kiocb's opcode against IORING_OP_URING_CMD to implement
special treatment for uring_cmds. The recently added opcode
IORING_OP_URING_CMD128 is meant to be equivalent to IORING_OP_URING_CMD,
so treat it the same way in these functions.

Fixes: 1cba30bf9fdd ("io_uring: add support for IORING_SETUP_SQE_MIXED")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.h | 6 ++++++
 io_uring/kbuf.c     | 2 +-
 io_uring/rw.c       | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 503663d6fd6d..0fa844faf287 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -528,10 +528,16 @@ static inline bool io_file_can_poll(struct io_kiocb *req)
 		return true;
 	}
 	return false;
 }
 
+static inline bool io_is_uring_cmd(const struct io_kiocb *req)
+{
+	return req->opcode == IORING_OP_URING_CMD ||
+	       req->opcode == IORING_OP_URING_CMD128;
+}
+
 static inline ktime_t io_get_time(struct io_ring_ctx *ctx)
 {
 	if (ctx->clockid == CLOCK_MONOTONIC)
 		return ktime_get();
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 67d4fe576473..dae5b4ab3819 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -169,11 +169,11 @@ static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
 	*/
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return true;
 
 	/* uring_cmd commits kbuf upfront, no need to auto-commit */
-	if (!io_file_can_poll(req) && req->opcode != IORING_OP_URING_CMD)
+	if (!io_file_can_poll(req) && !io_is_uring_cmd(req))
 		return true;
 	return false;
 }
 
 static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index b3971171c342..1a5f262734e8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1252,11 +1252,11 @@ void io_rw_fail(struct io_kiocb *req)
 static int io_uring_classic_poll(struct io_kiocb *req, struct io_comp_batch *iob,
 				unsigned int poll_flags)
 {
 	struct file *file = req->file;
 
-	if (req->opcode == IORING_OP_URING_CMD) {
+	if (io_is_uring_cmd(req)) {
 		struct io_uring_cmd *ioucmd;
 
 		ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 		return file->f_op->uring_cmd_iopoll(ioucmd, iob, poll_flags);
 	} else {
@@ -1378,11 +1378,11 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 			continue;
 		list_del(&req->iopoll_node);
 		wq_list_add_tail(&req->comp_list, &ctx->submit_state.compl_reqs);
 		nr_events++;
 		req->cqe.flags = io_put_kbuf(req, req->cqe.res, NULL);
-		if (req->opcode != IORING_OP_URING_CMD)
+		if (!io_is_uring_cmd(req))
 			io_req_rw_cleanup(req, 0);
 	}
 	if (nr_events)
 		__io_submit_flush_completions(ctx);
 	return nr_events;
-- 
2.45.2


