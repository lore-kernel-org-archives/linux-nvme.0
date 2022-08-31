Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F393ECAAA1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 01:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knSzJ4dgeDj1o+u9CcFXOjTBfzT4aiSB8/Bqvma9o8g=; b=eEgV+262XZCMm6kAoEOs5MN+cL
	KmxuiVjtx8AAgf2qQORsRx8aXfJiFqKpCh+u0RRC90Y5WlLEbaw7KRR4+1d9DYTksjJF/KureniK9
	+4Hg3HPrk/nlJDi1dnyHR1rnhtv31xWUQnd3lbv1iV/bF4VphkN7yK1TgFbhgZnceOHXkKsr4Kxbs
	Ji1vlwcqhBVVCoxZp/797RKqaDuBmq3SUBuYmNeBt59skin9U0m4GCvr6LA7Y13WXxlxQqBCyVkMS
	GiJ0smvQ7cURUgyqLjfakQYsG6pZXhEd5WTr8VM8B84pE96bpabHSPeU/Rg3mSJ5iBiNfwo4grM0U
	dmGXe+fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCd2-0032BG-KC; Wed, 31 Aug 2022 01:34:52 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCcu-00328V-Qd
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 01:34:50 +0000
Received: by mail-pl1-x634.google.com with SMTP id x23so12789429pll.7
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 18:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=knSzJ4dgeDj1o+u9CcFXOjTBfzT4aiSB8/Bqvma9o8g=;
        b=GZm5pbpNoC3XLieL8BPHiDbQb9KAVxXNGYD2Y3++Amrr0/SkYVcVXNaYa2M5g7qsz3
         LMdoo1sCWsPox3Cxey4qa3k/0fWz3YSP7PR7ncmKjOgaSw/tIgef2BQ9KNg+O2z3+M0v
         YPqzZxUFbF9yJH8dMQNDr172j7xt8RnvTDt8RMhzXPaW3tu963DHfHDazRaIxUZmHXcw
         GRzsxiybW67sPCFQ9huiTdrmlB4IXQqp+0tX8siY8yS3v3rLOnUxFZ483nuYzUh9xQGd
         mPYrB5pf1BKFTWePvyd290e7LlhwESC7dp+FpMYTAzwhUmo7h0wKY2XPrZyXacdsaM0a
         svdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=knSzJ4dgeDj1o+u9CcFXOjTBfzT4aiSB8/Bqvma9o8g=;
        b=bsK5JlFTuU7EgfOVV+sBDdnHk8t+sYE5PsfOUb7Y5CU6kTiUpPRclnzSi5jJeimT7I
         /MI0NqGkPjnUsG/Hk8nTIPHuyCoEz7xPV+IIocIBB8AbS6Wp51E8fwqTJg/4YmdBHi+P
         Sw/pkd4rS8Bnnr2WUyxy0LK6sT7bWijOlHse84VggNQfNlDjm58uGSpVOmfkwib8WDBk
         TYtkDfOKnEkzgCqH35+0cOY6smDS1zL/ez+DUQsiTqSXNwHCvkUMQ96u81x3D5k3VbLQ
         P6u69dPNUAlkWO/ZPvHtTAFsQVqrEKb5LeQQ8OXf4LE72FqwL3jgesOxbjFK0NX2UGtd
         l8tw==
X-Gm-Message-State: ACgBeo1eK4T8nhM4jTPOYUMEFWI+KO+lqrZ8M+c+lXmdRQ57PtI0awW1
	/7dR8wI5ibFKEBQMufCCDT+Kkw==
X-Google-Smtp-Source: AA6agR43f6DFVqqsLW57CRQgWL4izuczvGKbiaYQNDUy2H5LH0LpYWtirupIcJoggPxCHQGv9D+yww==
X-Received: by 2002:a17:902:e5c3:b0:175:534:1735 with SMTP id u3-20020a170902e5c300b0017505341735mr7778141plf.87.1661909683391;
        Tue, 30 Aug 2022 18:34:43 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id r36-20020a17090a43a700b001f50e4c43c4sm202891pjg.22.2022.08.30.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:43 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Wed, 31 Aug 2022 09:34:02 +0800
Message-Id: <20220831013402.514055-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831013402.514055-1-pizhenwei@bytedance.com>
References: <20220831013402.514055-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_183444_879470_29990BD2 
X-CRM114-Status: GOOD (  14.97  )
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

nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
and waits the inflight IO requests in nvmet_sq_destroy(). During wait
the inflight IO requests, the callback nvmet_tcp_queue_response()
is called from backend after IO complete, this leads a typical
Use-After-Free issue like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
 RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
 FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
  ? __switch_to+0x106/0x420
  process_one_work+0x1ae/0x380
  ? process_one_work+0x380/0x380
  worker_thread+0x30/0x360
  ? process_one_work+0x380/0x380
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
steps:
  uninit req          <- new step 1
  nvmet_sq_destroy();
  free CMD buffers    <- new step 2

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..3bfd139b1434 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1415,7 +1415,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
-static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
+static void nvmet_tcp_uninit_req(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
@@ -1423,14 +1423,27 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
+	}
+
+	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
+		/* failed in connect */
+		nvmet_req_uninit(&queue->connect.req);
+	}
+}
+
+static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd = queue->cmds;
+	int i;
 
+	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-		/* failed in connect */
-		nvmet_tcp_finish_cmd(&queue->connect);
+		nvmet_tcp_unmap_pdu_iovec(&queue->connect);
+		nvmet_tcp_free_cmd_buffers(&queue->connect);
 	}
 }
 
@@ -1449,8 +1462,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-	nvmet_tcp_uninit_data_in_cmds(queue);
+	nvmet_tcp_uninit_req(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_tcp_uninit_data_in_cmds(queue);
 	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
-- 
2.20.1


