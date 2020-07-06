Return-Path: <SRS0=qz9S=AR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C062C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 19:46:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D2820675
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zsd9kXvG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ASjIGw/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D2820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FMKBaKtkhop6bYOtSia57AEAv2JKSWYQzkB+wCqCinw=; b=Zsd9kXvGQF1ykebv1lO5H3B5xW
	p//gQfOncMgK06hOLOwZPXfnzhDjCPcnT3d6j4CYEIgK5YV+Z3hcWTCSslQWFlxydcW5Ms4JcY4ko
	mWSm6+fulZhFE2P2SPavWYrB/sTiZEKMOwY0GAkEpILjtw7fes21RRA+hdsoV1JUa0ab1hZAEJb4H
	Y4zoYwX9hKqKqqX+X82LNvPjxH8CEii9BuJ4YyYswGSm0RIBRvWl8L5pxzYofYuV9LXtalrJxP9aH
	34XYzf4Vx7DUs3NDcKRt9LqkyEMNa5Chq+EJ5CEEKqemaGfIEhQm21Szh8U9pHToXsPvmwj+uMiwp
	RjfaT9QA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsX43-0003Ey-IR; Mon, 06 Jul 2020 19:46:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsX41-0003EH-2y
 for linux-nvme@lists.infradead.org; Mon, 06 Jul 2020 19:46:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594064765; x=1625600765;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZEWUfupanu+KdQUX0auYHN21KAatHobTxZox7QwvJ0Y=;
 b=ASjIGw/dBowbkLvctzaTHFHqMzLi94ohTl8Z3tpuS0iQvWI6BiYICQKH
 aGs1EHmEWDOAL03DaspH5mfNb3f7ucayjNdr33aumba5H55FRgNTjmywh
 XWD8rrCd852ZF1vINyhYbiRnYntnvBFpqYGPBNK0ZKBo4PYGsaQhLK4dg
 7Z2JbFd9ERasxwwDvXi0ahgLLcYj1krKtF9ofts/jT8i9FO+3nkodfY4x
 3LXD2pIqce6U70AnGnWHne206ISn1QF0LlwibGLHMl9g3k7eYFExOQ7V/
 Pmrps6cJj6gLkyf8jEgmXXC41p7zWRIYen8WFRCdpcFErvPhI2g7ORklC A==;
IronPort-SDR: A+xhP/lJ7b7YJ+I59Ln1+CUgOQ6tSFG3pkqEbpgv5lYRNfQgzHeWfw5nbQKXwkTDcFUnXXmiwY
 KzgDgSkWFBgsiihrh85SopBrypGZQCJgoCBFsrgX+2yj0MR0W5RlVpZnqU0ETPvhcHpzbwHfGx
 D6+txQ0UctpuBkmM1fRurNhdX+IRPjvWwGvMlgDrnkIm38EFjP7uLW+TGpnszHgrWxo0mcY7EX
 NKZ72aRTGmw/6ZSabJ3Q0rjGqX4YSQYFHqQzMtIKtbWj2ZJ7rFJx9dm+r/cjy03qm9+haAmdvJ
 TU4=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; d="scan'208";a="141758353"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 03:46:02 +0800
IronPort-SDR: ERDcEY0m9e+U+4JM3wzz5RDapyKQPcfSXP0haxXTBV4ilxAb7637BinBLY8CLg0ic0oMxyZSc5
 RQvH2LWHrtV1nEw4wklVQhI+jVN1XZQ+U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 12:34:11 -0700
IronPort-SDR: J10XpwGof1Xhaa+7Wb2jR6pZK9V1YhfXyNi4an63iHOYc4eb2a5+Gk2bQeSdffI84rUD36E8rc
 VKdm4xyTdjsA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 12:46:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: sagi@grimberg.me
Subject: [PATCH] nvme-tcp: remove dead code in map data
Date: Mon,  6 Jul 2020 12:46:02 -0700
Message-Id: <20200706194602.51112-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_154605_332825_82F246F0 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_tcp_map_data() only returns value 0. The caller
nvme_tcp_setup_cmd_pdu() checks for the non-zero return value.
Get rid of the error checking done for non-zero return value
and adjust the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi Sagi,

I've not tested this patch, if you are okay I'll send a tested version.

Regards,
Chaitanya
---
 drivers/nvme/host/tcp.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 860d7ddc2eee..7d8385e10768 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2172,7 +2172,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
+static void nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 			struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
@@ -2188,8 +2188,6 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 		nvme_tcp_set_sg_inline(queue, c, req->data_len);
 	else
 		nvme_tcp_set_sg_host_data(c, req->data_len);
-
-	return 0;
 }
 
 static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
@@ -2233,15 +2231,8 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	pdu->hdr.plen =
 		cpu_to_le32(pdu->hdr.hlen + hdgst + req->pdu_len + ddgst);
 
-	ret = nvme_tcp_map_data(queue, rq);
-	if (unlikely(ret)) {
-		nvme_cleanup_cmd(rq);
-		dev_err(queue->ctrl->ctrl.device,
-			"Failed to map data (%d)\n", ret);
-		return ret;
-	}
-
-	return 0;
+	nvme_tcp_map_data(queue, rq);
+	return BLK_STS_OK;
 }
 
 static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
