Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A457C38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 20:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EC220A8B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 20:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2UE/RbS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIWlJgI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EC220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Q6sQ8csO5kM0MEEnBVH3ne+P97GmzcuGnQPCoQrC8LI=; b=D2UE/RbSi8y+u9
	e0pj4SpIQf8RHFgxZQPwNuh4icAmPgBNFHEsJZD48m/72pkY2YghGmdqpl1DU61sz9wd62M32lX4K
	oNm3kHzjkiZYMHKO3KKqCli+zFtCJZVy8F1a7JzqgHFMXkHphIeMtBFiVxT8ydkK65VBjKypX1jrO
	zuN1LknA6iSx6QLaIONIF4YMRPsGD1qRT9AzxSyQG6wVLQidAfZUzvf37SyysFHu/25TPlWE/WDjM
	Fr1KgQ2EWJQNotEWA7da8KERRjDASGI0oj+kC6uk90y3vrWNIA1zbNwH6tisdVhOFGBT45zevzZL6
	UXq/8VlVn5YgjJIBFzFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX9ED-0007p9-RC; Fri, 08 May 2020 20:04:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX9EB-0007oa-BH
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 20:04:12 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2E8920A8B;
 Fri,  8 May 2020 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588968250;
 bh=/EHlRgMX3Yqz9EqlzWRzEhU+FK8zcTLH1KAjtEYrMjU=;
 h=From:To:Cc:Subject:Date:From;
 b=kIWlJgI/9iO+7wEkc19v9ZGS0zyoKo3wnSBv377KIU8SUkZI8ngJQgvLH0T8xr2vN
 g4GLUcsPhN83qYZiKHIIX935fqUAopXhkz3Go/QXJ2RsVgVzi3zqH5uVUISYrZ9WSl
 iY44tIQF8dQygDAFUjVJPItpzdidqcGtxtG4BbJo=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme-pci: dma read memory barrier for completions
Date: Fri,  8 May 2020 13:04:06 -0700
Message-Id: <20200508200406.2814437-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_130411_408140_46E39272 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, John Garry <john.garry@huawei.com>,
 Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Control dependencies do not guarantee load order across the condition,
allowing a CPU to predict and speculate memory reads.

Commit 324b494c2862 inlined verifying a new completion with its
handling. At least one architecture was observed to access the contents
out of order, resulting in the driver using stale data for the
completion.

Add a dma read barrier before reading the completion queue entry and
after the condition its contents depend on to ensure the read order is
determinsitic.

Reported-by: John Garry <john.garry@huawei.com>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e13c370de830..3726dc780d15 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,11 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 
 	while (nvme_cqe_pending(nvmeq)) {
 		found++;
+		/*
+		 * load-load control dependency between phase and the rest of
+		 * the cqe requires a full read memory barrier
+		 */
+		dma_rmb();
 		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
