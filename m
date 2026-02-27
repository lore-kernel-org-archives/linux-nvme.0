Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DDA104891D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doNIdz9wMn9gx8zF7Ky2pC6GD/iifRgNWdZEMqpkv1c=; b=aAv6nbUdj8Bvpb9GnH+FWapW76
	ZPXxp/CsVJuOXGusTaHGePkZLxxMgIR4KRvhWW9tCPDaWHlHevLvt+vsDiDRWwhTTqoX4LILcFjUF
	Lq96UUOSuKGsm0KNI1xb0+XrejSIvxqNNOM0HQbPL9AefMHjidZYJcxXmyPKmZY0gvdrzlHXFMDe8
	PoEUOsG1YWysjVTPopA5IO0ifdl6gfaAO1V2t+TcjAjz5ikgeBDTHlKzoV1NPxbfzQ6p1HL97aMN0
	Z86SksJqLlc1XvzTm1rIPpMMCE1pp6a5/OMNrfg2dSAxlr3YXW7JfIisPjV+L/XFWR/2Sxt/zrwSl
	C255B8Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QT-00000009Dlc-1SuA;
	Fri, 27 Feb 2026 22:35:13 +0000
Received: from mail-yx1-xb162.google.com ([2607:f8b0:4864:20::b162])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QP-00000009Dkj-1lYl
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:11 +0000
Received: by mail-yx1-xb162.google.com with SMTP id 956f58d0204a3-64caae0eb68so287825d50.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231708; x=1772836508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doNIdz9wMn9gx8zF7Ky2pC6GD/iifRgNWdZEMqpkv1c=;
        b=aTBiXE2Lyv4i4Gw5Mnmx5IoZkbuggYJZA8xtJYY8w781z7q7TqQ3lvZGYEcK/9Bc46
         HVRHcLkYxmP/dO2YkHJOfmv/zZP6CymfiRMSgIXISIWzzD+Wo5mTat2wfZO8/qI6k5+7
         OHaeCeKT6nvWqDOJz20rYY3+sY+3OpgcA24Vvsm7H2t44NfF/XTUdGv4oi6D93N/y75p
         8XXFzGEHsJ1tSgSG7109JovdPFXH3AgzLrN7s/A22FvbkDj4MGbl/3s4cRsyopGvnt/F
         EoEnrQr72SbPWvWr8bwWppzh/DodXfjzNsnzLlnIMgc0XGBA/8UXNjuOFymlukZ9ju7A
         HJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231708; x=1772836508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doNIdz9wMn9gx8zF7Ky2pC6GD/iifRgNWdZEMqpkv1c=;
        b=OXBwkoQjtr/0EsF2VA198qhNxbQFX+5pJt4wqRx4UR9XvA6zSUEw4JhnvoMmPvts1e
         WqHeKLTrnr4N/P9jh6wuK7XIjxNFVffHue4gMmWDBoGTRxrcfcxfd8MJAXnyhtQn7TRV
         WftvvNU2ZDjBF+JN/V9PurB/jxzqcNOPQ1UchxoKRmHFSKT3gb6g1WnL9RE7aCr5ilVc
         Gy0txoLO/HEuXZenP1Yp69W2MrL8GINWeuLnoJPnv3cVmtKAvMuLbc+yAH1gMvT/63ge
         wDVdtU8bNmp04sZ8cCAlzSIMqFlG0RTARZWoqafnNXaUYjkASANeOwMnW1+Hz4BGLRtW
         E2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX4rzEFZwdv2/XqrKPaHbOkFoiuebF3SfgLw35vAxEW3uHHwfK2geqQRHib3wnvVxjHltWSm210BOiC@lists.infradead.org
X-Gm-Message-State: AOJu0YyOgLPo5XgAwTKRPMyI4MBJFMAFNYVXZn1GcDp1GDnkg/iGzM/l
	3tjqF78fCMSKwFRAZIvMq51PdCjT8U4jP1kuOev0eJnXLU5tde2smvfzQ6TYz7/J0raQ/3Dqouj
	XEZjkzJ042rLQUWv3vXS5AdvpkiNsZTtPmJnl
X-Gm-Gg: ATEYQzyL+N4NP/VptAOZo3JVSTSV4aRmIiu892d05BDn0rxYqlNgKh2oCr/qA+iQXw1
	qVhGiZmtlibqWkxYBV7ET4A82MjE71cDvoTdJC6mhM4QG2ei1yfH8cQV1+15MNRbkeftAG6jLzP
	X1rJWqYYPtL4QJVjsaxGNFskN6we8ObmPg3RNJPUeLaDdlkcRHT6U77N/SZpv2Zyoj8/TqZpWFb
	5ScYE2r4o3pDzuL0wGFpz/h54xFi6lkt+h1d7s31ajujzSWsZj2xoC8mks1qkYQFR+5gnxywijb
	NOX/fx19Ti20YQFbP6qxiMveU4M3edsp2LXiDti4xpNTEjUzFCqzCQOLXbTclme6PXOQox791Pm
	Xwb/wiycsCHidYbeXta5TssoCtsRkUl70zIWxP7I8yXfyBLpP3+23yA==
X-Received: by 2002:a05:690c:c4fa:b0:797:a57b:d200 with SMTP id 00721157ae682-798850f351bmr35803657b3.0.1772231707838;
        Fri, 27 Feb 2026 14:35:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876ab7b69sm6884587b3.1.2026.02.27.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 255C9341DB3;
	Fri, 27 Feb 2026 15:35:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 213C2E420D8; Fri, 27 Feb 2026 15:35:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 3/5] io_uring: count CQEs in io_iopoll_check()
Date: Fri, 27 Feb 2026 15:35:01 -0700
Message-ID: <20260227223504.1162421-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227223504.1162421-1-csander@purestorage.com>
References: <20260227223504.1162421-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_143509_470930_DA276885 
X-CRM114-Status: GOOD (  20.84  )
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

A subsequent commit will allow uring_cmds that don't use iopoll on
IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
setting the iopoll_completed flag for a request in iopoll_list or going
through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
io_iopoll_check() loop currently only counts completions posted in
io_do_iopoll() when determining whether the min_events threshold has
been met. It also exits early if there are any existing CQEs before
polling, or if any CQEs are posted while running task work. CQEs posted
via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
against min_events.

Explicitly check the available CQEs in each io_iopoll_check() loop
iteration to account for CQEs posted in any fashion.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 46f39831d27c..5f694052f501 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 		io_move_task_work_from_local(ctx);
 }
 
 static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
 {
-	unsigned int nr_events = 0;
 	unsigned long check_cq;
 
 	min_events = min(min_events, ctx->cq_entries);
 
 	lockdep_assert_held(&ctx->uring_lock);
@@ -1205,19 +1204,12 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
 		 * dropped CQE.
 		 */
 		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
 			return -EBADR;
 	}
-	/*
-	 * Don't enter poll loop if we already have events pending.
-	 * If we do, we can potentially be spinning for commands that
-	 * already triggered a CQE (eg in error).
-	 */
-	if (io_cqring_events(ctx))
-		return 0;
 
-	do {
+	while (io_cqring_events(ctx) < min_events) {
 		int ret = 0;
 
 		/*
 		 * If a submit got punted to a workqueue, we can have the
 		 * application entering polling for a command before it gets
@@ -1227,34 +1219,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
 		 * the poll to the issued list. Otherwise we can spin here
 		 * forever, while the workqueue is stuck trying to acquire the
 		 * very same mutex.
 		 */
 		if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
-			u32 tail = ctx->cached_cq_tail;
-
 			(void) io_run_local_work_locked(ctx, min_events);
 
 			if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
 				mutex_unlock(&ctx->uring_lock);
 				io_run_task_work();
 				mutex_lock(&ctx->uring_lock);
 			}
 			/* some requests don't go through iopoll_list */
-			if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
+			if (list_empty(&ctx->iopoll_list))
 				break;
 		}
 		ret = io_do_iopoll(ctx, !min_events);
 		if (unlikely(ret < 0))
 			return ret;
 
 		if (task_sigpending(current))
 			return -EINTR;
 		if (need_resched())
 			break;
-
-		nr_events += ret;
-	} while (nr_events < min_events);
+	}
 
 	return 0;
 }
 
 void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw)
-- 
2.45.2


