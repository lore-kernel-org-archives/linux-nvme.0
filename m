Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A38C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:11:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388BD64E25
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388BD64E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bcUaNMsauoF+rXd+UCvuoNjRJl7mgtt3Mc8FEJNcI3o=; b=eQVKVt5GmRfvZbhwTNtU+8pXzt
	m7HHs+EB5WWMtCDPxk7QereV83i7x1G5ISIn6WGvPdMYg+PJq3UrXTfyi5lPJNLQUALo6oNXmnAsR
	d7bAMzwhFUynHrh5A0sJlyNO5YSBVlzLWc6euZ9Nn8SOSV9xUGB4CQaMteQK8O8/sFe6Asr6s0pEc
	Nv0NR4ZO3wYsV2vbMIjtCJpt1NU0xruGN2t+bkOH8lCOIi7YULhxa48h1Ab44eonDJmZlOwGBpTUu
	h+V1YfQPqry/Saeaf6jo6r0egV5kqY7C4WLGMVTlAbROzqvA8P9t9JW+l6tz9Z25JQctJnzPhpq4j
	G+iLO/5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHV1g-005k6C-DS; Wed, 03 Mar 2021 17:11:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHStM-005EyZ-CD
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=9lgW1cQvKOm2q2BnANU5l2hExAwH9m0gL1PldmeDocw=; b=Sd1y5tb8L/1JhdG6PExTs49Qkv
 yio7xI6lsDiNPHfVslBMW4XwMMtkigB9hrUPsDIErcQec02Id9Ct2Kgo6LG1/kYqknJCQcuIcQKl5
 DfOivhRBHkvzI1wVLmmwo97JagyS5UtLIsYYP364llNV8TRe9r4BgYJih18QDvoYkQ6wVkOeZNbnA
 e0q+4XxfJsLcFB4mZI0fXzUSgAFwWCSB1CXGxhDPT7oyiYhuEM6XbGTJz7eUNnVP3MbNPUzRNZk2x
 W1Mi4Qp53vz1qqOEFoXEXcu9jdhnHZQmy6H+oudYXprMFkSyJ5L61HiH/K4Aj+8Mp0bjgyk5znXim
 fvnqUMMA==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHQMh-002UxB-SC
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 12:12:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C4766AFE2;
 Wed,  3 Mar 2021 12:12:28 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme: send uevent once a multipath namespace is operational
 again
Date: Wed,  3 Mar 2021 13:12:27 +0100
Message-Id: <20210303121227.65688-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_121235_047387_628A509D 
X-CRM114-Status: GOOD (  12.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In an all paths down scenario I/O will be requeued or aborted, and no
further I/O will be ongoing on this namespace.
This leaves the upper layers unable to determine if the namespace
becomes operational again eg. after a successful controller reset.
With this patch a 'change' uevent will be sent per multipathed namespace
once the underlying controller moved to LIVE and started I/O processing
by calling nvme_kick_requeue_lists().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0696319adaf6..1a9e14ebe11b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -97,8 +97,11 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->disk)
-			kblockd_schedule_work(&ns->head->requeue_work);
+		if (!ns->head->disk)
+			continue;
+		kblockd_schedule_work(&ns->head->requeue_work);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
