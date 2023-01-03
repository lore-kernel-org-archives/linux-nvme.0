Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C13C3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsUjI9LKViB2XEmVMadxGoC9k7Pp06d+C5eXbZ5cctU=; b=zPTgazpU2dA+OPpZGYUx5Ktg/M
	FfDU3/oreV6HFVgeu9X3RmggKwCeYEUUVgemAkOtnAFZYHSSIEIYArhtck0WKnMQb00RotA+0Aa4V
	vQ5KzEwJ+hBcQmIPQfhuZqih0S7/QZTrSRQ6MY2I07ZP64hZTR15xl8A78mv6NqurQEUbo/gILe3L
	rAe9Ez/yLGGjSvZ94Imve2RGYEmvEsfoLL46I9Vwk1zV8USz6EtJesKbBdUCygdKuu0WmCyQ57+3t
	y5WKHTANyiVCqBcgPb0bkKmLxvkcD4eCa7LCEHXJzx3Uip3A1TaZQjkmW6whZmDAGDsvhjEAMY5MG
	AVSvAMWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnQi-004cHb-T9; Tue, 03 Jan 2023 19:58:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCmCM-003xxJ-04
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 18:39:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE51614DF;
	Tue,  3 Jan 2023 18:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF743C433F1;
	Tue,  3 Jan 2023 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672771178;
	bh=y/icNDZXDdmsEy5bNNxCN/zwTDWzbAK30ql5luf2wVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3vGcAKiflArC04QiZnibUOcvcAeclNYV4ncLZIKhkqajqn7dJQuGhNU794Wcq16J
	 VZ1KNMMYPoJyKdufncg2vtkjfjaWmWIWPSIyWFDEZkqdwujLOseKTUue4o3oJD6XN8
	 eEmSbOEbHGOhcuKf/esrMIMbCnvzgwbPlr34oor4u1lYf9FmVsOddi0uwuLdQk7Ub3
	 YkgntE631xohF+YS3Sy+giv1DjOCW6h9f4nrXHIZ8/VPfWBhn9npPw9rEno5a1TM/o
	 floIBeq3mnxMTr6TFamX40rRMLsrnYU8fadvv5X9F3zMdL9Wstv/j5mQa4BaXzsAKp
	 IK/kHEyBsV47g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yanjun Zhang <zhangyanjun@cestc.cn>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 02/10] nvme: fix multipath crash caused by flush request when blktrace is enabled
Date: Tue,  3 Jan 2023 13:39:26 -0500
Message-Id: <20230103183934.2022663-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230103183934.2022663-1-sashal@kernel.org>
References: <20230103183934.2022663-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_103942_255609_D3DA1112 
X-CRM114-Status: GOOD (  17.77  )
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

From: Yanjun Zhang <zhangyanjun@cestc.cn>

[ Upstream commit 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 ]

The flush request initialized by blk_kick_flush has NULL bio,
and it may be dealt with nvme_end_req during io completion.
When blktrace is enabled, nvme_trace_bio_complete with multipath
activated trying to access NULL pointer bio from flush request
results in the following crash:

[ 2517.831677] BUG: kernel NULL pointer dereference, address: 000000000000001a
[ 2517.835213] #PF: supervisor read access in kernel mode
[ 2517.838724] #PF: error_code(0x0000) - not-present page
[ 2517.842222] PGD 7b2d51067 P4D 0
[ 2517.845684] Oops: 0000 [#1] SMP NOPTI
[ 2517.849125] CPU: 2 PID: 732 Comm: kworker/2:1H Kdump: loaded Tainted: G S                5.15.67-0.cl9.x86_64 #1
[ 2517.852723] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.13 07/27/2022
[ 2517.856358] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[ 2517.859993] RIP: 0010:blk_add_trace_bio_complete+0x6/0x30
[ 2517.863628] Code: 1f 44 00 00 48 8b 46 08 31 c9 ba 04 00 10 00 48 8b 80 50 03 00 00 48 8b 78 50 e9 e5 fe ff ff 0f 1f 44 00 00 41 54 49 89 f4 55 <0f> b6 7a 1a 48 89 d5 e8 3e 1c 2b 00 48 89 ee 4c 89 e7 5d 89 c1 ba
[ 2517.871269] RSP: 0018:ff7f6a008d9dbcd0 EFLAGS: 00010286
[ 2517.875081] RAX: ff3d5b4be00b1d50 RBX: 0000000002040002 RCX: ff3d5b0a270f2000
[ 2517.878966] RDX: 0000000000000000 RSI: ff3d5b0b021fb9f8 RDI: 0000000000000000
[ 2517.882849] RBP: ff3d5b0b96a6fa00 R08: 0000000000000001 R09: 0000000000000000
[ 2517.886718] R10: 000000000000000c R11: 000000000000000c R12: ff3d5b0b021fb9f8
[ 2517.890575] R13: 0000000002000000 R14: ff3d5b0b021fb1b0 R15: 0000000000000018
[ 2517.894434] FS:  0000000000000000(0000) GS:ff3d5b42bfc80000(0000) knlGS:0000000000000000
[ 2517.898299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2517.902157] CR2: 000000000000001a CR3: 00000004f023e005 CR4: 0000000000771ee0
[ 2517.906053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2517.909930] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2517.913761] PKRU: 55555554
[ 2517.917558] Call Trace:
[ 2517.921294]  <TASK>
[ 2517.924982]  nvme_complete_rq+0x1c3/0x1e0 [nvme_core]
[ 2517.928715]  nvme_tcp_recv_pdu+0x4d7/0x540 [nvme_tcp]
[ 2517.932442]  nvme_tcp_recv_skb+0x4f/0x240 [nvme_tcp]
[ 2517.936137]  ? nvme_tcp_recv_pdu+0x540/0x540 [nvme_tcp]
[ 2517.939830]  tcp_read_sock+0x9c/0x260
[ 2517.943486]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
[ 2517.947173]  nvme_tcp_io_work+0x64/0x90 [nvme_tcp]
[ 2517.950834]  process_one_work+0x1e8/0x390
[ 2517.954473]  worker_thread+0x53/0x3c0
[ 2517.958069]  ? process_one_work+0x390/0x390
[ 2517.961655]  kthread+0x10c/0x130
[ 2517.965211]  ? set_kthread_struct+0x40/0x40
[ 2517.968760]  ret_from_fork+0x1f/0x30
[ 2517.972285]  </TASK>

To avoid this situation, add a NULL check for req->bio before
calling trace_block_bio_complete.

Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8a0db9e06dc6..cbda8a19409b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -888,7 +888,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 
-	if (req->cmd_flags & REQ_NVME_MPATH)
+	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
-- 
2.35.1


