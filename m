Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103BCECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 06:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrNdDpEQfF4jSPo0G2PkuvQabeCwVNkjy7yowx1pOTw=; b=Z0ZAV0eZl3vXHnw/CUXvW7EYuz
	tPHNpTJFwcAEzuLF3ykNArlV1D4IRF5NIf41QHVEinXpKKYR2TmApOvVsN2a0XdTHwiDqvnNzi0rL
	75UWPhMof8oz5S9SKIF4HA2nmWhDhqXm36n0MdOgqyvp3aQYm1dHDPmn6LWg41Bh03COkPhYI2XvU
	N3/7mNgbzhQf5C1PrZWZltkbKB53/B2eUrX/vb3eRdnKelUJvlY5Eloy+hNsgZBzpS2xGxFWU5dSa
	K+Xxn3G1qKeQ6aWSpba602/G76Iheed0w2f6Qa2g5hfynTMxRVKF3FDkzVbhvLtKYgKG+SzK2s4Gw
	aDs3UqdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTdTY-00A0H6-R3; Thu, 01 Sep 2022 06:14:52 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTdTU-00A0EL-7V
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 06:14:49 +0000
Received: by mail-pg1-x52b.google.com with SMTP id b196so5766273pga.7
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hrNdDpEQfF4jSPo0G2PkuvQabeCwVNkjy7yowx1pOTw=;
        b=N7rUbBi3FR9gjMgqumx4Uh3SD5x4i13aEfVjHFz3QCd6aMsQrbKrQpnq9oideIUJLo
         LDzLtg1mwCNVp5vP6QskBxlCECbDbmaB/sj4p6nUE2hOgLEt5P+A+N0Sv1kWxCfPD3vY
         8aIDE7ehM0vaUzmfkFEdGusXEJgmgRdxIBmxtWNRYES8Brrgq14JmMpzwnreD8G+wRR/
         9EpWaiO4YG2lHPFrHdTAaZ+2LDAgg8UmWZzBDSJTByH3fUIFexQsnOeyvzqh8DED/FTb
         fMOA+Y/002ZBpEGz3rM+xbYOHUfRMkrOmw/Xa5izxrYTBwcWypms77K1K4dJx8DO8rSm
         vcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hrNdDpEQfF4jSPo0G2PkuvQabeCwVNkjy7yowx1pOTw=;
        b=1XlKUX8ZwWaqjUkTnvwp+jiIc3jrhte4IhuFsjeRdjjytZWaPktIqguIjwk+VnkXA/
         OhA42CrIQaQqh5+z3HIgwjvZwnRiCpzLppQ6pyLmdu59OU8U+OMh6SjizKnoCJMU08JB
         7S3FgHIIqR96XthD1SGQb6XCozxxh5vhAngOpn9ccTRI2MJ0jh5OAMmQ097JZe6rbcRE
         zcVgX/PB19W2usVSDNIzx6K9aS4OrU8fblkTz/qR3Dr1Dd6fwF+mzNBLmCpfYfozk1Hw
         ichjdXs66MzmwRgp9z1owsaxOff3AvJWGIKHKRGB/eXDlAaR2muaRadxhzhPvDhrHI/X
         KEeg==
X-Gm-Message-State: ACgBeo1OdjbUaHld8AoYR7jFdSaSZDGQSpn2iDvzpCWA/jTnMd4sikQS
	aBe7shXGbKVfEsfYZe0O4yABSQ==
X-Google-Smtp-Source: AA6agR6nEkxuSc8NJbnR1GL9O3NXanLk9qb0LkmBbmygDRy8WgZsjGJ14Y34pkBdHW6GyJjuFWcPkQ==
X-Received: by 2002:a05:6a00:1515:b0:536:c6ea:115f with SMTP id q21-20020a056a00151500b00536c6ea115fmr29488601pfu.37.1662012885397;
        Wed, 31 Aug 2022 23:14:45 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id k26-20020a63ff1a000000b004307ac80cacsm581497pgi.54.2022.08.31.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:14:45 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 1/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Thu,  1 Sep 2022 14:14:09 +0800
Message-Id: <20220901061409.545456-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901061409.545456-1-pizhenwei@bytedance.com>
References: <20220901061409.545456-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_231448_288333_996322F1 
X-CRM114-Status: GOOD (  15.02  )
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
  uninit data in cmds                  <- new step 1
  nvmet_sq_destroy();
  cancel_work_sync(&queue->io_work);
  free CMD buffers                     <- new step 2

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a3694a32f6d5..e18eae5ef90b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
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
 
+static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd = queue->cmds;
+	int i;
+
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
 
@@ -1452,6 +1465,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
+	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.20.1


