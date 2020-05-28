Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E53C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 15:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C652075F
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V7Vn2qjf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0WxIIJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C652075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fgYgF/QtVKWD1hU0FQRH8sCjj3CK1YqF+u1A0Mud4j8=; b=V7Vn2qjfGQLXq9
	FRg/axiupUanDqh5WQH4eqP8myy/RKxT2aEI474Tyo5trv/yc8PZGABOkydt6t4BVrUcp/TTp5Mo7
	zOW/88VVLxjyoArHKzvU1XHaXGvfxy5+QE9TYPwdt2qgfWWurXnrrQnx5aP5/or3qaAFMyqVRCdEF
	unosAo+h5bHveiaxHqs0+YPAiReO/KqpvqBSGMiz2EqrEErxeIqPgxKKRe3w8tNi84Za+GQqe5Dvj
	2o6ej3PqHXJwF2D2kGHdl6w8fcAENZk7M0uQPqmRxaSgK8Tg7g1cgUC4E+h9BdtByiCvMa7AZkvgV
	VQHkqCZOcN7Q4EFatQDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeKK0-0004Jp-2w; Thu, 28 May 2020 15:19:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeKJi-00046G-V4
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 15:19:36 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F131A20814;
 Thu, 28 May 2020 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590679174;
 bh=jS4YEsYoWGt+s7wdwumSuGHqfyqftPJFoJ/s8TR4Y1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G0WxIIJy0bdQwXxS+gPprQygC2c1qL1BYsCFLa+e0rSnC9HM9bLzjAxx9IcrfnRmJ
 28Hwt3XeFrLVPyPs63HUxHfPPIOM5Cqy31lJyZwaX5KvVi8t6j5LzxZ6fq3eJQIMmx
 hvM3kfAAlo2DLWH13KhBqd6E1ePJZNqptobEdTAU=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCHv2 2/2] nvme: cancel requests for real
Date: Thu, 28 May 2020 08:19:31 -0700
Message-Id: <20200528151931.3501506-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
References: <20200528151931.3501506-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_081935_030034_5B423D4C 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Once the driver decides to cancel requests, the concept of those
requests timing out ceases to exist. Use __blk_mq_complete_request() to
bypass fake timeout error injection so that request reclaim may
proceed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: Use new export rather than loop for success

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba860efd250d..f65a0b6cd988 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_complete_request(req);
+	__blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
