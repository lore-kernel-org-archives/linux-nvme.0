Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D2C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 02:38:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F7164EE4
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 02:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F7164EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v4EJDLTu8NxcuCtq8Cuam4lPDf9Y7lFAuoq2gH6I9cE=; b=X6Ska2uFAKXFjiNwhtbkT7yd/U
	WBzX9Qalz6aPiAO46zrZxRO8Phs1vXqSIphsNQCNfnttE9KHnR1sDlOPopsNdgFsZul/QtAqVArvB
	WBVnWy4EHG4Afop0QvuU1U0YTH/WNn7iOLVvzZv8Yz9RKx9M3OnVCVGy041+OHm1oWocqzLer5fNY
	WWC8EjTt70V96dQ0xOVP52hBontQcU9xwRV2fAtjt2ba7D5lJ/aK3rHh0W8k8DLqLXiL2kQJXzT6a
	R+Ty9b5jNSBuo2wmKjcb5zIsYoNlSNLx81d3yHHQvTfY+eMC7z9atiAn+6o8M5NsR+nJYRoVl1O/u
	t4aaDyOw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHdsJ-007VXk-Ox; Thu, 04 Mar 2021 02:38:04 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHcHl-007FfK-Bh
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 00:56:33 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DrXSL72GSzjVt8;
 Thu,  4 Mar 2021 08:54:10 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 08:55:42 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <lengchao@huawei.com>
Subject: [PATCH] nvme-fabrics: fix crash for no IO queues
Date: Thu, 4 Mar 2021 08:55:43 +0800
Message-ID: <20210304005543.8005-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
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

A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
over rdma(roce) reconnection, the reason is use the queue which is not
alloced.

If queue is not live, should not allow queue request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fabrics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 733010d2eafd..2479744fc349 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -189,7 +189,7 @@ static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 {
 	if (likely(ctrl->state == NVME_CTRL_LIVE ||
 		   ctrl->state == NVME_CTRL_DELETING))
-		return true;
+		return queue_live;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
