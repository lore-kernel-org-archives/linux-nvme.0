Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5403BECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5fa+6VB7uN3dY9iE1jP8H/iyTkP2TWufgen/2BmG/3Q=; b=QfhJlG/xuOgZqu1pfQ4Cl1bO28
	W64+6oGG4P988sy3paiB5AtzU2byAuGBfTtnnzn4rkzQkV0J0lyq/U2+BLCANjvr66/iUx1rSvkZ+
	RdV1frwkRDQnYWrUFc5CR5YfqTiZ//fD9DOjuWez/YbhjP3DdR9Cdav55NpzuIA2Ow+2T3OGt0Oud
	eyObjD2eZ8cKWMH6hnUbmvdw2NxWoruzU7NS0zTRlwzJx18kVfYA5fzdEAObiGlHyKmEg4XTxg4lA
	rpHGqvz2giJABku066K5t4gHsiWTltk6rakS3OGqTu3INqqq4osjwdc3rd2mgm/QHo5hoILhPFVuL
	ecmqDbsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oad44-003zIG-Rz; Tue, 20 Sep 2022 13:13:28 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oad41-003zGO-DB
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 13:13:27 +0000
Received: by mail-pg1-x52c.google.com with SMTP id s206so2575637pgs.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5fa+6VB7uN3dY9iE1jP8H/iyTkP2TWufgen/2BmG/3Q=;
        b=IA2pXJ2nSjDlY3RSqfCcgNc7Os9rprk+c9WpIxWuZAIghYuB8rftLq4OL1hOOp+M9p
         fDpRCsemWDKsp2UR3NJYximbgQwmfLwE92rXXoPh9ojVMzoWnSCAwNV48AmOTxhsBLF8
         vutC2Rnl/2B7vCFGxMtskvo2lmwRDWstcFMPqY6oQHdcytpJ2KtX8xuB9dZp8o/5fmpg
         s+ZxUrTohsoJHnkajj+K13HcmPXNnfr+VzyOBkY9YqU1DctTGI/URm8LcszQQMV2Tx3u
         jkOfY8Xd5fkTHwiOPZ6HuB34TO65/7DZJeDsnsZ2P1al3oRFVc2v25PiepelxV26SUOZ
         cUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5fa+6VB7uN3dY9iE1jP8H/iyTkP2TWufgen/2BmG/3Q=;
        b=RFBDNEet2rIMPbRz4A+AVaOZv7t8wunueDe1qJUS9DJ05Vmlk/h0Fo0LrxtQ3sZUJU
         JuUZl4fHE8UPh3yx4M6HSi2sxPJ53a0F7E1/uH2blWqLERcavBBJRnvo+eEv1WoGbHFP
         lPsj4TKM7VJOrv88FzcPrEtfrnr+w8gh+RY7tc1AkF1sD6/prg0ShHw/WaKt4X59z+Vp
         /NVxS5dxIdClZ7o91U2mmS9Non8Y8Pgvggqpw040r9Uf7CrVnQOOoyKyBZXuoeM/8NAQ
         rTYZfiaKygreGyDS3gfsOl5/mNK4FPne+InzbgvhEKTPVc25U94rFDe4BLLGB3v77lG6
         b4ag==
X-Gm-Message-State: ACrzQf32h21cig/KOuykTFZMHNbLF41jJoEaNh+cfsYn5+UuiXsQPeet
	ZRroPEg2uc4+oVrYtehIpEQxlg==
X-Google-Smtp-Source: AMsMyM6VgIIU/UhY7bRxO30SQMkdEw/inYuzkaZsMe4rLitZ8FxPikxaXYqfPogZRvoHfwua7N00ZA==
X-Received: by 2002:a63:91c3:0:b0:439:c38a:1a95 with SMTP id l186-20020a6391c3000000b00439c38a1a95mr16563004pge.568.1663679598545;
        Tue, 20 Sep 2022 06:13:18 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id w16-20020a17090a529000b00203a4f70b90sm1379612pjh.45.2022.09.20.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:13:18 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [RESEND for nvme-6.1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Tue, 20 Sep 2022 21:16:17 +0800
Message-Id: <20220920131617.63540-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_061325_684036_B765D4C5 
X-CRM114-Status: GOOD (  13.90  )
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
 PGD 107f80067 P4D 107f80067 PUD 10789e067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 123 Comm: kworker/1:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #15
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc9000051bdd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888100ab5470 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888100ab5470 RDI: ffff888100ab5420
 RBP: ffff888100ab5420 R08: ffff8881024d08c8 R09: ffff888103e1b4b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88813412bd4c R15: ffff8881024d0800
 FS:  0000000000000000(0000) GS:ffff88883fa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000104b48000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa52/0xb52 [nvmet_tcp]
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
  uninit data in cmds                  <- new step 1
  nvmet_sq_destroy();
  cancel_work_sync(&queue->io_work);
  free CMD buffers                     <- new step 2

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c07de4f4f719..70baeab6af30 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1406,14 +1406,26 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
-
-		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
 		/* failed in connect */
-		nvmet_tcp_finish_cmd(&queue->connect);
+		nvmet_req_uninit(&queue->connect.req);
+	}
+}
+
+static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd = queue->cmds;
+	int i;
+
+	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
+		if (nvmet_tcp_need_data_in(cmd))
+			nvmet_tcp_free_cmd_buffers(cmd);
 	}
+
+	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
+		nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
@@ -1434,6 +1446,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
+	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.20.1


