Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D3C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 06:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6pKyURb3OwbF0RIp4Q2luzgxcT9o4z0TzZByLx/W50=; b=G1/jiak+MEp/s63F0a3zcMz146
	Z+juRWFQssPiBkmvjbfW7/mIRNZqhSXfHIrjsMjfFU/ZL2co5rWTf0fZaj3pICt2Tzcg9GJVkemfC
	W8hQXqAFnHPpyEpQd3kSrrvLB8Qx6K0qwGwKw9VLdfd29RQXzlcRSjSGjKvMXOxsF3E+r1XRZrHH0
	VJn4ZDNpwiOWSjasMkwNk/Qm/C/yv4CeiARJMAwV2ZBWhX9wqbpdL/65mcMUJPP0mg3p8FujvWr43
	6WgofBHGYBJksUrpLiyoH8bz2QwrQId90+sWaFd9Sn1EY2DcE9cwyUkNoR9MlKrEU1bPyZ46tpgfr
	XCE9CP/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrZcH-005HCR-5P; Thu, 19 May 2022 06:26:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrZc9-005H8k-6Q
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 06:26:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5F0F71FA0A;
 Thu, 19 May 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652941581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6pKyURb3OwbF0RIp4Q2luzgxcT9o4z0TzZByLx/W50=;
 b=TGjVSMzNswy7JueQh7MMTt3yrf95+8ynhb32MkJbK4bT2hd8il6tLXG7rb3uPqhULuB5DM
 qnReO5FrNRina0ThkHyurtvplAVDATjp7p6QCea7k44oUTM/yd3HxvtITMeintAlAzVrSO
 Tw3jo0z1P7m41aCE9cywCpTi2B6AB60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652941581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6pKyURb3OwbF0RIp4Q2luzgxcT9o4z0TzZByLx/W50=;
 b=RijataRWjmsxLvPURpH3+9c8j6tDJuocyx/gUstRgOF+T5zjb4DTfVR7QZMRops69E6fiZ
 mXdC/d+HzGc2Y3Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 534142C142;
 Thu, 19 May 2022 06:26:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7DEE85194537; Thu, 19 May 2022 08:26:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Date: Thu, 19 May 2022 08:26:15 +0200
Message-Id: <20220519062617.39715-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220519062617.39715-1-hare@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_232625_512538_9A7249FC 
X-CRM114-Status: GOOD (  11.74  )
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

When running on slow links requests might take some time
for be processed, and as we always allow to queue requests
timeout may trigger when the requests are still queued.
Eg sending 128M requests over 30 queues over a 1GigE link
will inevitably timeout before the last request could be sent.
So reset the timeout if the request is still being queued
or if it's in the process of being sent.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d241b..ede76a0719a0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2332,6 +2332,13 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 		"queue %d: timeout request %#x type %d\n",
 		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
 
+	if (!list_empty(&req->entry) || req->queue->request == req) {
+		dev_warn(ctrl->device,
+			 "queue %d: queue stall, resetting timeout\n",
+			 nvme_tcp_queue_id(req->queue));
+		return BLK_EH_RESET_TIMER;
+	}
+
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
-- 
2.29.2


