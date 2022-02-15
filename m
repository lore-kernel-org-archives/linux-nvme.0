Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B437CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GT1V/2VZT5XW4zUh73mTgeNxh5DHou50kRO384mlG+w=; b=eigv3rdb0zYPbxg6A+XR9pfO7Z
	4ceNy/Z1QoIhQnT48ihO0nobLqB3J7VoazWY9QEyZW6wju4JASRLk5fhS00y1mA1/+8x4xJXTqQve
	d3/3NwrmjVgB3yJdFRsXNPVXfpbD0iDTkz8K/q8QJ9fFVQqEVwMnzqNGBzj0XMkexjeEeCQbDRV3m
	XgKCIMeRJtdNmkfce+/TMrOn7s2D2bX8Pgv6ymoSa/PvcwcYPJHzRSv2OLieivGEdgCHiU2xv9nD2
	r4XZSq5uxaSkdEa1aqnEfJARRdwC/E6PCb14XbcfyPuTI1OpJmM82AeahYxxVcEJcPDK6yrcM0dFX
	2sVhNAOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJzMK-003AQP-OB; Tue, 15 Feb 2022 15:03:16 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJzMH-003APh-QA
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:03:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A88C5B81AB7;
 Tue, 15 Feb 2022 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146E1C340EB;
 Tue, 15 Feb 2022 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644937390;
 bh=rV4kdjuFhSgai4KiEZylzxw5chc4uQvBcG1HIpFLQvM=;
 h=From:To:Cc:Subject:Date:From;
 b=EB5mN44STNGwRwhjY6EMs8/j8AH4+FlFxw3URRwZEY6K1rmfv1msfSgx8sNFHSqou
 xmNZeLnWR2aOWd3leim/EQwOl8Tp4JD65Fs19urZlt2iKbQGktcNndiS9aXWXMjGBc
 JufU3wX4zIr6dhcpsdLBi/4L8mDR3ZmFrlrwH/VBZwmYsHCwP9KiZ3niceDeyEEdQ8
 QwkHPUOsRBdqVn6lT6v7SoHL6TDtiT5CvjP2oP5F77vHH4e3rvS2GwaO/rWVY9s8Iq
 8so+69b4EALrcNUEg6UUWX2bH9NAxP31UrQFc8mE/Ub01tdZSNQfHc47ilnCI3uL4+
 tLSHXgt10QNgw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] nvme: explicitly set non-error for directives
Date: Tue, 15 Feb 2022 07:03:08 -0800
Message-Id: <20220215150308.1902842-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_070314_049000_835507A4 
X-CRM114-Status: GOOD (  12.85  )
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

Stream directives is an optional feature. It is not an error if a
controller doesn't support as many as the kernel can optionally use.
Explicitly set the non-error return value on this condition with a
comment explaining why.

Note, the return value was already 0 in this condition, so the setting
is redundant. This patch should just silence bots that falsely believe
the condition contains an error omission.

Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79005ea1a33e..fda837ce67ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -777,6 +777,8 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
 		dev_info(ctrl->device, "too few streams (%u) available\n",
 					ctrl->nssa);
+		/* this condition is not an error: streams are optional */
+		ret = 0;
 		goto out_disable_stream;
 	}
 
-- 
2.25.4


