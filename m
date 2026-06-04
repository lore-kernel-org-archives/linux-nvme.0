Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7CECD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 03:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkdtUlGp8rizuZEey4HEAM0V5ZzymmxIjXzGy2oOaqo=; b=lON5qeH52Q/l+9aMxDLqxta3Wq
	JLhxf70IVYoYcTmmRuigoGWK5I30360HbDwLIHf/vOjTmKqkV56KeMep6XunBnYKAwJt2jBmBBaZA
	4+UM0PSql8nCBOtZXucMZW1otZW0Px60rgbg0SYx5TUr/Fcv0Kykd1Qu1Sy8RHlKlWwYF5FXztyFh
	0kCVA5+XeQ3A1hQwQMRnuk9W52QTWfmjfs3026HvQRmM3sQPcBEfyxyNOAieM9LPM11iv7+uDWVI7
	/ywDMSzARz3cjHIv4+NB4hCT7FErlanyBjWpuGkgwzSwFdWqFJ9JMCT5+1u80apg3R0qGmnYDLlQv
	pIOn4a3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUykM-0000000G6B8-0481;
	Thu, 04 Jun 2026 03:27:54 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUykI-0000000G6AN-2cgU
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 03:27:51 +0000
X-UUID: 5a0dc9525fc511f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7a4977ae-ce99-4c60-a165-546e98a3dbf6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:1b73aa36fc5aeca7789a11a5958ddefe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a0dc9525fc511f1aa26b74ffac11d73-20260604
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 726451396; Thu, 04 Jun 2026 11:27:44 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvmet-tcp: fix typos in tcp.c
Date: Wed, 4 Jun 2026 18:00:00 +0800
Message-ID: <ca60ed7aea973ab800ffdab09fb4776fb40966da.typo-v1.1780449274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.typo-v1.1780449274.git.liuxixin@kylinos.cn>
References: <cover.typo-v1.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvmet-tcp/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_202751_000417_92067785 
X-CRM114-Status: GOOD (  11.69  )
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

Align nvmet-tcp comment and log wording with the initiator driver.
No functional change.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..92f206d72198 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -51,7 +51,8 @@ static const struct kernel_param_ops set_param_ops = {
 	.get	= param_get_int,
 };
 
-/* Define the socket priority to use for connections were it is desirable
+/*
+ * Define the socket priority to use for connections where it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
  * possible optimization.  Making it a module param allows for alternative
@@ -985,7 +986,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
-			pr_err("queue %d: received out of bound ttag %u, nr_cmds %u\n",
+			pr_err("queue %d: received out of bounds ttag %u, nr_cmds %u\n",
 				queue->idx, data->ttag, queue->nr_cmds);
 			goto err_proto;
 		}
 
-- 
2.43.0


