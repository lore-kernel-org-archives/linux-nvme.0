Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A4ECE596
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7C8206BB
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ctdj1/MK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJbjEGac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7C8206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TlzZzoZ+hXFST9pHSvaFcr10creDlztf+M/VjxIqNzY=; b=ctdj1/MK2fDNTa
	j6SnVON0mI170TxQJel2wfDH06k8SKrHIqUWfOe+Z/xISbbEbZMTcwVWh61eJrTr4Xv64InftxvEE
	/r2lpr4JIliAwn7oXBvbgh4vGBc4Hg8aorEac4xJEu33LMutA3TxVM9B1ZCN40REtrWHwRwZBh2xY
	LimvliEvLBY45oZalcC4GzeboPdBwLX7hCmls2abPRuCqwwquamni86EJTpUwAwlAZYhCnCn3ALnh
	SH356hsOYLTfDAvDnEuMhuZ4oEiGS5NupSno9JFEnD2aZX8sEIPkgnotq4REyg/lmZEYWGNJgDvkh
	ZNWaAt/DHgpDPM2P+YdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIFgt-0003yf-Jy; Wed, 09 Oct 2019 17:23:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIFgp-0003wY-H3
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 17:23:57 +0000
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D76E2190F;
 Wed,  9 Oct 2019 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570641835;
 bh=u1QY37GQqiMRz3nMqJTL9xuwt1CVrLfwwm/6Qk4iZPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GJbjEGac3/M1WXVOHXDrlX/BsDB6t+4wt6/wJf+eDuaS+Gqtwj+YpZZDJOAt2+EM6
 1YGKCjYP+vQksjEGWb8XQjafxTenA26VCg1pSDyqhDLlYEITayxtFoJ4rF8Qe4Yoiq
 uqbXS4iZWJYDgY/J4bBMkQGCkZiDDZeCerntZbDU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 06/68] nvme-pci: Fix a race in controller removal
Date: Wed,  9 Oct 2019 13:04:45 -0400
Message-Id: <20191009170547.32204-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_102355_592909_DAFFF1DA 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Balbir Singh <sblbir@amzn.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Balbir Singh <sblbir@amzn.com>

[ Upstream commit b224726de5e496dbf78147a66755c3d81e28bdd2 ]

User space programs like udevd may try to read to partitions at the
same time the driver detects a namespace is unusable, and may deadlock
if revalidate_disk() is called while such a process is waiting to
enter the frozen queue. On detecting a dead namespace, move the disk
revalidate after unblocking dispatchers that may be holding bd_butex.

changelog Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd69033..28217cee5e762 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,10 +103,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	/*
+	 * Revalidate after unblocking dispatchers that may be holding bd_butex
+	 */
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
