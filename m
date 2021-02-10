Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:04:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06C964E08
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06C964E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nzV1m35Alw3B1ySRmBrWVkvvme+Gc17N1SlxQBcr6M0=; b=vRA9/oacvIfUiSssHCVOZR0TmD
	xrdOUnG+TmWNoyPHyn4SETfKk9a139kJSqccH4R/MOERQf5OkLqZ+I96iN/nbiyPHGwKv/xRL9JWj
	F+UTOJYv+xB5bjDXAAzVyl7Zy1gDXg4/R/msvyvIP+mJwyQWBBA4lWJuhScsOT0hUIa8IWHM6FIvj
	surt9olntn3PxxISQRVfx6QYT9AJ3hcvMV+8g8B9Av3RvSxOqa/Pi17wKEV0zb/LUTUrn/hPlHs9P
	489oujFCCCOVgGcAy9l3/6WLt3jTj72+pnwgloQQ4yIN0l/iqNCqOwr2JTvdPFkfP0Oqn0RFqSKIx
	O0mFe4vA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9xaj-0001vm-S0; Wed, 10 Feb 2021 22:04:09 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9xaf-0001uh-UT
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:04:07 +0000
Received: by mail-pj1-f47.google.com with SMTP id my11so3589619pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 14:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UQcs3fT817b0aL28c8ILem23vdhysrELWRM4DscWGNc=;
 b=JI0ecw9zb+/jyDZpuFUeZmBt+v0yYrhSRS6cIlb1KOc6XPbKWUr2hn33r6nUHJf9U7
 cVeST8JsYIGbIQD9x1TyMnJfJNo9aLJBjC28DiqaMAcZyTc0bDlg+lT8lq3O8HBW0j7C
 3ihlZxwgXClis6sNfyc7mVmjo2+J54uarjSvM+GNPCsVDiIvnWYnlp8s0wx6Uf7L9D3h
 Sf9KAcNnfd3+eZPw65znK73p3DM3fWfJC4Zb2d5Ub+mlKOOp4bxjISQW4rBCD+HsGfha
 Mkq5Ccrulg9BtE1K/eQcrXRdrrT3umAZiGFWQ6uPCG8SZPqve5HSWk/qCy413uXu3Bje
 fwvQ==
X-Gm-Message-State: AOAM530UmphUSbnrRhzEy7UcWn4q+uMKcyBA0FW8IK40LZkW9QOHwHQ5
 t2FQlIon0v9dZH/ZFD1jZP6l2XabR7M=
X-Google-Smtp-Source: ABdhPJztaUerzUAwryz0LRMBFtBL5VtJLpKrTsY9NA3iW+n3e0lAzjgDFrJwgycw0w8AJQcq52s9Ow==
X-Received: by 2002:a17:90a:1a0b:: with SMTP id 11mr982552pjk.58.1612994643060; 
 Wed, 10 Feb 2021 14:04:03 -0800 (PST)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
 by smtp.gmail.com with ESMTPSA id z10sm3469790pff.179.2021.02.10.14.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 14:04:02 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: fix crash triggered with a dataless request
 submission
Date: Wed, 10 Feb 2021 14:04:00 -0800
Message-Id: <20210210220400.1730263-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_170406_036199_5B921F24 
X-CRM114-Status: GOOD (  15.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

write-zeros has a bio, but does not have any data buffers associated
with it. Hence should not initialize the request iter for it (which
attempts to reference the bi_io_vec (and crash).
--
 run blktests nvme/012 at 2021-02-05 21:53:34
 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S        I       5.11.0-rc6+ #1
 Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
 Workqueue: kblockd blk_mq_run_work_fn
 RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
 RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000002000000
 RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 0000000000000000
 R10: 0000000002800809 R11: 0000000000000000 R12: 0000000000000000
 R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp]
  blk_mq_dispatch_rq_list+0x11c/0x7c0
  ? blk_mq_flush_busy_ctxs+0xf6/0x110
  __blk_mq_sched_dispatch_requests+0x12b/0x170
  blk_mq_sched_dispatch_requests+0x30/0x60
  __blk_mq_run_hw_queue+0x2b/0x60
  process_one_work+0x1cb/0x360
  ? process_one_work+0x360/0x360
  worker_thread+0x30/0x370
  ? process_one_work+0x360/0x360
  kthread+0x116/0x130
  ? kthread_park+0x80/0x80
  ret_from_fork+0x1f/0x30
--

Fixes: cb9b870fba3e ("nvme-tcp: fix wrong setting of request iov_iter")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..69f59d2c5799 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,7 +2271,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-	if (req->curr_bio)
+	if (req->curr_bio && req->data_len)
 		nvme_tcp_init_iter(req, rq_data_dir(rq));
 
 	if (rq_data_dir(rq) == WRITE &&
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
