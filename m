Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D7C10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384BD2076D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dth2ADTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384BD2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1EebuLMMIjujMviREjJRAGZhhp8tlggkLQpdElrwzzw=; b=Dth2ADTFFhqQ8w
	yKHUr5G+EKKxFwu50k7mTYqGloTQ2SZz7nlKvRn38z3TQeyHqDZdM2A+rWt8p58p/UB+SefQxUJmm
	E5BHYy8yeH26xF7/PhebJHTuSBs9W+SXbM2ci/2RbdmlDOPy1s4Yum+12+Pzx1SAXQvzDg3b7ecZY
	wmb2e9oPoj5J+Rue+EpSXTPfCIOxmEaJntavY+ipTRG2FsXbAwM59kIx/yFJWWVHbOrH3PaYNw2iy
	Rc84DFvozr7A6Kpomv0we+1IYOKSMlDHQ95arRY7wFxPV2+EHJPJcn/wkzqFvX4o1+caJWwMV+v0V
	2G03aewACVrXEukx9wmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEabz-0004Ml-N0; Wed, 18 Mar 2020 15:28:03 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEabx-0004ML-5x
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 15:28:02 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:27:59 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IFRxfW030386;
 Wed, 18 Mar 2020 17:27:59 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org
Subject: [PATCH 1/1] nvme: release ida resources
Date: Wed, 18 Mar 2020 17:27:59 +0200
Message-Id: <20200318152759.199450-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_082801_620056_86AAA4BF 
X-CRM114-Status: UNSURE (   6.77  )
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
Cc: shlomin@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ida instances allocate some internal memory in addition to the base
'struct ida'. Use ida_destroy() to release that memory at module_exit().

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90..31bbf40 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4299,6 +4299,7 @@ static void __exit nvme_core_exit(void)
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
 	destroy_workqueue(nvme_wq);
+	ida_destroy(&nvme_instance_ida);
 }
 
 MODULE_LICENSE("GPL");
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
