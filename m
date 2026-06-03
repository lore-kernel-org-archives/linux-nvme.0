Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DE2CD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 03:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjeeGyt217v6+VtvDZz8Lqb/Eq1+X/uCHifqST/hkbQ=; b=WsCqkQsvOCcTgJdyZ7t49w6q/L
	lRcGZHe20nM6sf90t6i5z+JjYnN7bgK/gVZIJnc/rN0BG8a1k7o0WY8m+BzjsAOplQzZHdW/GWvNG
	Aui69Lcx8Sf2FKkwSxMoBrJeOwgU9CVQL2zFaVj68+VbOCB+cZm9xJ8HTPAfkdUaNzCpkbG8aG378
	g9lWn/pMEIhj2hOx9iGq8n/0yHiA80tLNtdvhQlRehhKktp0B2d2IVy5Ch7nlfKwKl4K918gLMe12
	XmeIlXGIc+W4WUdJmaKjBicYgbW1ImojrXZT2Hl7GJo3AAIfwvh4jjCwyhjbaPCK5N9wWCr9XcE8X
	SQi0LSJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUyKU-0000000G4uc-3s1K;
	Thu, 04 Jun 2026 03:01:10 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUyKO-0000000G4t8-49CT
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 03:01:09 +0000
X-UUID: 995ea06c5fc111f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5aebdce3-2a87-4c67-ad38-a030552c01e2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:ab4197f33fc72985c139f7eaccd5a1de,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 995ea06c5fc111f1aa26b74ffac11d73-20260604
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 26184182; Thu, 04 Jun 2026 11:00:53 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvmet-tcp: complete command on H2C protocol errors
Date: Wed, 3 Jun 2026 09:14:17 +0800
Message-ID: <ca60ed7aea973ab800ffdab09fb4776fb40966da.1780449274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1780449274.git.liuxixin@kylinos.cn>
References: <cover.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvmet-tcp/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_200105_370332_ABF019D7 
X-CRM114-Status: GOOD (  13.50  )
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

When nvmet_tcp_handle_h2c_data_pdu() detects a malformed H2C PDU it
returned -EPROTO without completing the associated NVMe command.  The
host only saw a transport teardown.  Complete commands that are already
associated with a valid transfer tag before returning -EPROTO.

Use nvmet_req_complete() so the host receives a failed completion.

Pick status codes by failure class: CMD_SEQ_ERROR for offset/sequence
and command-state problems; DATA_XFER_ERROR for length/plen mismatch.
Both are fatal at the NVMe/TCP transport layer, but the command should
still be failed explicitly.  Use DNR because retrying the same malformed
PDU will not help.

Only call nvmet_req_complete() when req->sq is set (the command went
through nvmet_req_init()).  The pre-connect placeholder has no sq and
must not be completed.

When the transfer tag is out of range there is no command to complete;
only reset the receiver.  Initialize cmd to NULL so err_proto never
dereferences an uninitialized pointer.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..9a9d3a354566 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -977,10 +977,21 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
+static void nvmet_tcp_fail_h2c_cmd(struct nvmet_tcp_cmd *cmd, u16 status)
+{
+	if (!cmd->req.sq)
+		return;
+
+	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_req_complete(&cmd->req, status | NVME_STATUS_DNR);
+	nvmet_tcp_free_cmd_buffers(cmd);
+}
+
 static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
-	struct nvmet_tcp_cmd *cmd;
+	struct nvmet_tcp_cmd *cmd = NULL;
+	u16 err_status = NVME_SC_CMD_SEQ_ERROR;
 	unsigned int exp_data_len;
 
 	if (likely(queue->nr_cmds)) {
@@ -1011,6 +1022,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		err_status = NVME_SC_DATA_XFER_ERROR;
 		goto err_proto;
 	}
        /*
@@ -1036,7 +1048,9 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	return 0;
 
 err_proto:
-	/* FIXME: use proper transport errors */
+	if (cmd)
+		nvmet_tcp_fail_h2c_cmd(cmd, err_status);
+	nvmet_prepare_receive_pdu(queue);
 	return -EPROTO;
 }
 
-- 
2.43.0


