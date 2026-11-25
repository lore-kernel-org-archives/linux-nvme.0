Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9E606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tfzaseui;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x3RA1f54
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=; b=tfzaseui97A9eMLjfFFUtEKZbz
	iIX4u//NakUJiOA7LaoVxbeMXl7i9uo1MKydYEAPPhCjcCe2anrRog1279wENAPskXkHgADg1Ranm
	gCNVwC81N1qExLyjbLPI3WeAVHHIvSa0g/x1Y/s4BpbBcsp5fHfoQugXP95aXtA1DwIyWAY0Ax6un
	X73v5v9+zok12Y7KJKT3ZKo7Nn/AygMbrkLCsoqiOUYnZvFHQMxSApgNTyzlkBkOtafAf5NSjr5Ky
	Ha3A0lp58OO721jx+PteaxyqhX0x3PPKshg10WaWWgcpnkRO3p6tkfBi9uFehV6k00j5oviq2z77P
	Xv12N4IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFUW-0000000AUW0-375U;
	Wed, 25 Nov 2026 16:05:04 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFUT-0000000AUV5-08Mi
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 16:05:02 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso3563632a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795622699; x=1796227499; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=;
        b=x3RA1f54hIByYcRcyZaIxLU/FL3XiMQeTUt9bOmSHenD9gNMB+RkJ4ju3g07PxLMNc
         zz+mku0DY1DMicsknMmBn4jIlCyi5/5xx9Wizky2LTBkIFnd/N+XST5z5DnDnOfYl8kk
         ezvfTpCZIMwE/tzKXEK7bJkK2cMd9NbZYXNvuvdw00kTqgmcJTg/bpojdDxp2Ga8Y9oM
         Zyu83E+t7p2+LYuQi9So2duB2EA5gDjzeWnobwSIm2jBA4j6cT+qVatvqOfHdMzJd2o7
         CFBEXU51KInLuZW1G6SY4zFWQZDuSOk52NQKR5doLz7xc1EPEJ+ciavDqLKgGDWQHdY0
         3Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622699; x=1796227499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=;
        b=XQMcp9oMX8ug/SdVO/UAPq10TO6uiafpg1q2MVZBoXZfFTD7Jx6aGcrMbqB/ysHLm4
         Ob4Edfr4tqQlUeWe3M7T1QgFMwea1cjPk+vJVA9NlXmvqJHl44DEhnCBhJcxCs8QzghI
         s5jQDD76pdgqLXImqFWpGC1lMQ05romqBKcWzN6lxRDjSq77wSO7A9i286CQijH/W4a5
         0CCXjE8G+tni1PbAa96DG/b/zKyUhSOT63qW6C8ieIlW6mLXjpAnCHlb4kWFx87UPAII
         B3Q6VXOTsjgS0NvzU2xTeEa15fQCkx359btNRbvBQySgz4dD17uiDYl+9ECNajQeSMmG
         l9hg==
X-Gm-Message-State: APuU4Z9ZHpiRzMI6PyOUavjgzhN/Vl+lkLS3Ql1NmSFj7FkQ8fpO1OIA
	QfNhri9W14BjnDD1/wZ2m4dnOz+3FW02SfoctKb1R0bcjoXUy703SuEz
X-Gm-Gg: AZFdTZeBgzoMRsVNkReBMXlgR5rDXR3kWHl0DIYGCb7QzXezE8hgD45a7839s6msOLq
	LBe3AHxKli7bie0zRquLhSqyQvryKIW/sE3gpSV5Gg8eB7m+gxWud+81n5xml97buLGFK71TlvU
	sm0gHYYnepPlna6XFFPRiSJF6lqmE7+wjbRP5O3qgsfNNs4m+RxIuIXvFacGCK+smkpwox0tUpe
	lt/EcGRkEnLfA34GGlGfRs4ESvXxY9iomKsMaeESNLfe5IUtPJQAp9V17oZVC5wSwMMTVBycUEm
	xIpexBdSlIxkHa+60KzpP0iLIbfc06beCdK8IdzTpmqBgsARGvKw+akw0KIVhfTz6GRJm0BEzaA
	iMp0fnSuxvTU8bJTKn//otDcxaowczlShZJ0ZxvpCTq3+oP2N4Fak5yVDlZwwmYEKz1/LIgv0T+
	Enpfpy6L+XtJhoM5qjL0LBwd4WNZDAfPISxnFJP3VvyimBed0EJ5A3//Gzm/dnVFfvi2jzrmCeh
	t6URl1DUAz6Yn4rXI3AR9YeCpUTazQRVkOp7FCuB/PZVHUattMB20COH9A0gnnEmPktcp67K+jZ
	iA+23lF3AqmUCtyRsMExVQgBng/6v/PX3uP5AtLojegdII07x76a/OIArpxO+gsNzEmtRmAq0j+
	IjX9ulH4EWG1QACIHG9/ZNp4=
X-Received: by 2002:a17:90b:55c4:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b41c92ce42mr16574121a91.28.1795622699105;
        Wed, 25 Nov 2026 08:04:59 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm3913712a12.26.2026.11.25.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:04:58 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	co+018500376d4b835e@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: reserve connect header digest and align PDUs
Date: Wed, 25 Nov 2026 08:04:20 -0800
Message-ID: <20261125160418.1518007-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_080501_103653_DB976C45 
X-CRM114-Status: GOOD (  12.46  )
X-Spam-Score: -1.6 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_NVME_TARGET and CONFIG_NVME_TARGET_TCP enabled and a listening
TCP target port configured by an administrator via configfs,
nvmet_tcp_alloc_queue() calls nvmet_tcp_alloc_cmd(queue, &queue->connect)
on accept before any socket read. At that point queue->hdr_digest is
false and nvmet_tcp_hdgst_len() returns 0, so the response, data, and
R2T PDU buffers on queue->connect are allocated at 24 bytes each.

When a remote peer enables NVME_TCP_HDR_DIGEST_ENABLE in ICReq,
nvmet_tcp_handle_icreq() sets queue->hdr_digest to true without resizing
queue->connect. Subsequent commands handled on queue->connect, including
Connect itself, then write 4 digest bytes past the 24-byte allocation in
nvmet_setup_response_pdu() or nvmet_setup_r2t_pdu(), and
nvmet_try_send_response() or nvmet_try_send_r2t() sends 28 bytes.
Because nvmet_tcp_alloc_cmd() carves PDUs from queue->pf_cache using
page_frag_alloc(), those 4 bytes overwrite the next fragment without
triggering KASAN. Replacing those allocations with kmalloc() exposes the
overflow:

  BUG: KASAN: slab-out-of-bounds in nvmet_setup_response_pdu (./include/linux/unaligned.h:38 drivers/nvme/target/tcp.c:341 drivers/nvme/target/tcp.c:604)
  Write of size 4 at addr ffff8880230f2818 by task kworker/1:0H/26
  Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
  Call Trace:
   kasan_report (mm/kasan/report.c:595)
   nvmet_setup_response_pdu (./include/linux/unaligned.h:38 drivers/nvme/target/tcp.c:341 drivers/nvme/target/tcp.c:604)
   nvmet_tcp_io_work (drivers/nvme/target/tcp.c:641 drivers/nvme/target/tcp.c:866 drivers/nvme/target/tcp.c:914 drivers/nvme/target/tcp.c:1519)
   process_one_work (kernel/workqueue.c:3495)
   worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
  Allocated by task 51:
   __kmalloc_noprof (./include/linux/kasan.h:267 mm/slub.c:5531 mm/slub.c:5556)
   nvmet_tcp_alloc_cmd (./include/linux/slab.h:995 drivers/nvme/target/tcp.c:1549)
   nvmet_tcp_accept_work (drivers/nvme/target/tcp.c:2023 drivers/nvme/target/tcp.c:2105)
  The buggy address is located 0 bytes to the right of
   allocated 24-byte region [ffff8880230f2800, ffff8880230f2818)

Reserve NVME_TCP_DIGEST_LENGTH for queue->connect and keep using
nvmet_tcp_hdgst_len(queue) for queue->cmds, which are allocated after
ICReq. Drop the unused digest space from c->cmd_pdu, which only receives
copied commands via memcpy() and never holds a header digest. Round
every page_frag_alloc() size up with ALIGN(..., 8) so 28-byte PDUs do
not misalign following rsp_pdu->cqe or cmd_pdu->cmd allocations that
contain 64-bit fields. Using page_frag_alloc() with aligned sizes avoids
page_frag_alloc_align(), whose fourth argument changed from align_mask
to align in v6.9 and which did not exist before v5.12.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: <co+018500376d4b835e@bugs.sh>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/target/tcp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8a2e0e056131..cfc0e462d81f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1532,30 +1532,35 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *c)
 {
-	u8 hdgst = nvmet_tcp_hdgst_len(queue);
+	u8 hdgst = (c == &queue->connect) ?
+		NVME_TCP_DIGEST_LENGTH : nvmet_tcp_hdgst_len(queue);
 
 	c->queue = queue;
 	c->req.port = queue->nport;
 
 	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->cmd_pdu), 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->cmd_pdu)
 		return -ENOMEM;
 	c->req.cmd = &c->cmd_pdu->cmd;
 
 	c->rsp_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->rsp_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->rsp_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->rsp_pdu)
 		goto out_free_cmd;
 	c->req.cqe = &c->rsp_pdu->cqe;
 
 	c->data_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->data_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->data_pdu)
 		goto out_free_rsp;
 
 	c->r2t_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->r2t_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->r2t_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-- 
2.56.0


