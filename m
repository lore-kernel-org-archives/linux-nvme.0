Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D8C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:49:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E01206CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oAq9FA+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E01206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5gvOdktLc/sJZ+TZUNB8gN+8YZ4VSyHgQV+YfmGIxJc=; b=oAq
	9FA+SSmhNDJIs8XUMij8yv6d1RwfN37ktflhLk6PPw8qvkROl/mbNAXoQ68c4u5MuYfB2UjMEe676
	F4FMBIGZk/BvAJsxSG5YZI5BPk8SSsKx6wWkI3PJE3VTYCwRq95aauoRNRcv5a5nIFDzb/xuQPm+q
	MSDhyT126KyMLq97XpEIkXcLQIygdZWwuhd5kWh/eK6DmwcRLVmwrfJffmw3BgJGQEx+m4pr0qvcM
	l2f/jaH3x0FxTy2J0b4g+5xeoA6yETDCeZEf4pGmXzT+I+VIl7WOcf4n2gRBmgc9RrxdXrufLd8EE
	RSi5SBi3basEV1rkkQPSEAmLTgOzhMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5t4K-0007Yq-Jx; Thu, 05 Sep 2019 14:49:04 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i5t4H-0007Y7-4V
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 14:49:02 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Sep 2019 17:48:52 +0300
Received: from rsws47.mtr.labs.mlnx (rsws47.mtr.labs.mlnx [10.209.40.47])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x85EmpKb025943;
 Thu, 5 Sep 2019 17:48:51 +0300
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: Remove double assignment of cq vector
Date: Thu,  5 Sep 2019 14:50:48 +0000
Message-Id: <1567695048-5234-1-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_074901_619889_08DDD458 
X-CRM114-Status: UNSURE (   5.69  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 Israel Rukshin <israelr@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Poll queues don't use it, so the assignment should be only when
using IRQs.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10d3071d6098..492074c95b9b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1560,7 +1560,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	else if (result)
 		goto release_cq;
 
-	nvmeq->cq_vector = vector;
 	nvme_init_queue(nvmeq, qid);
 
 	if (!polled) {
-- 
2.16.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
