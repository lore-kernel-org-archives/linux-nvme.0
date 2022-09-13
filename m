Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD78ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Sep 2022 01:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1+rGJXezdjE5xTzHT7G7hG7lga2nwqlOvArvmEf7lk=; b=I9sWEk86uXc18Ier4ggsGmaOXr
	MRkYDHq7rP53DK+DnDjCMYMJ9ajMSkofXoLrjYA6bXfJqgHXM+PuPqqqbKLnAOCVfhyM/4y63ZBJF
	31iF7eidpamYtQsOYR6dabcUBNoFEj2wWVdGGdunwnWK/MFKOyTaoLGmHvz2o3p72FfxBjVSCBlfc
	pMvLfSQRhdQlkmPROg216eG5JxWfqt3+Hx1lKumj/Xpky0K2QQlW6EXoq7C/nQkrQc2hWXL138jLd
	bD3Kk4dGtCIPGuxbTHb2tqe5psoHt6i/5QFAUQ9wuv2Yx+eo/vLSfzle5k9vQn3fMQ1ihxorVj3No
	QvZH3jAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXuxn-00HOrK-VA; Tue, 13 Sep 2022 01:43:47 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXuxZ-00HOn4-H1
	for linux-nvme@lists.infradead.org; Tue, 13 Sep 2022 01:43:35 +0000
Received: by mail-pl1-x62c.google.com with SMTP id p18so10294484plr.8
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W1+rGJXezdjE5xTzHT7G7hG7lga2nwqlOvArvmEf7lk=;
        b=6/pUsOap8ZPq78Eo8xRWvuplUzvjy6qXfWyIu89tQSHmAtY7fNAgHDqZD3HlmL9TJo
         g5NQ3s4SIy68sPk6skfsXmFz3cOtg6A9yKEH8TIFgWiW185FzIReHW7JScrlhmKfmg94
         wK/M5kBdXX7GzPretMFho5Xiu8W42ZfEWaS/CYy9F9KzWlEmBx0QhdtHEp1tYdE+/Cpw
         OZI/VGSVzsBLhWv9KqrCbozIUSJp2POeZ3nwIfoRBJYCxC8i41fNyC1YYC35SPd/XGBo
         mr8ShCaMSzGnltrhvsIoWeHkdAY7tMS/eW1WkwnBY9w4n6mRb/zpQbvv3YGMA4t9BBsI
         aQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W1+rGJXezdjE5xTzHT7G7hG7lga2nwqlOvArvmEf7lk=;
        b=rapRw3OL7cY7rgiyPsQMRlLlMbMHE8Hz39cVxXcqt5q9uoWZ4IPeB2bIvq5s8s+vr3
         c5zG630LbAYeMpioh7E6s0RdEP/LtlVHBvI3Q7MizaYszw8j7ty9D0lbOZFps09XQUKA
         UG2FAfGmgeVEJq/qtxSMCX53KK5/vELskWlzTG+RGwpGxdL21vRsRDdVMKnEf9u68AaB
         Y5aU9YYcfxgHSSvAKKzeGg42G45AZsRVcv3GXbaEIYOAiIPHmXbh+aLTBSqgKvSQ+dQw
         gB9AlzfybxvheTAB9OEmwD7vNEJScC2P//WkPapkDxHep9LcJFc2LJ16mGK1lsz1m4CG
         zsCA==
X-Gm-Message-State: ACgBeo20CWmhRUrasQEvd5rVbCXTebRkQfsdIModbfMY0xLdOG5KZ4dZ
	kXyg82U3Peijt8+o/imtQY7Ilg==
X-Google-Smtp-Source: AA6agR7TEC/mgifrrq284fugvdRmBPx1x6zEoh6osBQXFhERHBT1x8trlGZ3S762x15jAPIut9n0cA==
X-Received: by 2002:a17:90b:4c0a:b0:202:54cc:6d5 with SMTP id na10-20020a17090b4c0a00b0020254cc06d5mr1326909pjb.121.1663033412201;
        Mon, 12 Sep 2022 18:43:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id pg2-20020a17090b1e0200b001fd7fe7d369sm5885452pjb.54.2022.09.12.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 18:43:31 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fmdefrancesco@gmail.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Tue, 13 Sep 2022 09:42:53 +0800
Message-Id: <20220913014253.931724-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913014253.931724-1-pizhenwei@bytedance.com>
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_184333_697898_ED7E9C65 
X-CRM114-Status: GOOD (  15.16  )
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
 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a3694a32f6d5..3ac9750b41ad 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1423,14 +1423,29 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
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
+		if (!nvmet_tcp_need_data_in(cmd))
+			continue;
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
 
@@ -1452,6 +1467,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
+	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.20.1


