Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7EC4338F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E210F60EFD
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E210F60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l0X3AwpqVhiGkmhEd5btaGlvCtadB+rLh+rbnY8PJCs=; b=CYoreLIG0mVZSv
	vrMXZ0bf9QvX6PODoAkc89c2UaQ0ibXPUZHbOBRAGixY1n6MEYwze9kWMx+x5H1O2nURKlewYo0ay
	8NyL7MgEgoTAkFmzqQVEiXeszfKskUEj2Xu5uuuYlbbbLkn0hM4FyrmN5kc+Nsz0ruVowk5ROxZWH
	C8EnqgB8LA58hyfuqCtfPtzlWJTjki/1ORmlgNboOKyi/1A6FXC+ZiVrRPrroPOl1CAVF7Hq3weYX
	iRNHGR6CLuRaFA4g7NRC8nCyDHThJLWO8eF4PSNPZ2b+NR408MlMTCVPJYxC2EFlYoYuSWIqm14HE
	Lnfo6T1YvoS9S4nvNr1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAqNx-001gm8-D6; Tue, 03 Aug 2021 09:06:53 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAqNj-001gk2-EH
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 09:06:41 +0000
Received: from dggeme720-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gf8BB38X9z1CRxV
 for <linux-nvme@lists.infradead.org>; Tue,  3 Aug 2021 17:06:26 +0800 (CST)
Received: from huawei.com (10.29.88.127) by dggeme720-chm.china.huawei.com
 (10.1.199.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 17:06:30 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/2] nvme-rdma: always try to configure io queue when user
 wants it
Date: Tue, 3 Aug 2021 17:06:29 +0800
Message-ID: <20210803090630.14425-2-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210803090630.14425-1-liruozhu@huawei.com>
References: <20210803090630.14425-1-liruozhu@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme720-chm.china.huawei.com (10.1.199.116)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_020639_694312_2323E380 
X-CRM114-Status: GOOD (  11.75  )
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

During reconnection, if set queue count feature failed, we will
set ctrl->queue_count to 1, and schedule another reconnection.But when
ctrl->queue_count is 1, we won't try to configure io queue again.

We should always try to configure io queues if user wants it.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
---
 drivers/nvme/host/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7f6b3a991501..df4f872c05f0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1089,6 +1089,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
 	bool changed;
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, new);
 	if (ret)
@@ -1121,7 +1122,8 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (ctrl->ctrl.sgls & (1 << 20))
 		ctrl->use_inline_data = true;
 
-	if (ctrl->ctrl.queue_count > 1) {
+	if (opts->nr_io_queues || opts->nr_write_queues ||
+	    opts->nr_poll_queues) {
 		ret = nvme_rdma_configure_io_queues(ctrl, new);
 		if (ret)
 			goto destroy_admin;
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
