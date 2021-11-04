Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1510BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:15:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C864861056
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C864861056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fDW8ygxzn/vhdgj+GywNME9FIU3fI9mcUTc0XTzgCs=; b=Vke7ub5TDnvBdTaZJogVso4xBd
	8KBBM/VLDA3pKcvAOzncrYfpDP2Fyh7eVPtRgsoHy4FqwwsNqe6pMj5eZU7hJd0w0AfVjyCLMNn8z
	oiuBs4JC+B+M7zO16p/JAPOyt5iCDUuNaQJqrNwOJXpwEFyFvXtscV/QH7dKRkd9op7V9axkJ29Ga
	4D15aP6frJDxyGb64D5W+rqBhp6PjdYh1T9r2N1gkDtNKTBYD2GfYf/pU01bidBHosaY2T1HX3JrR
	xes0BUrB4vHLNaz3aBBzxlPJamRh/jdCdSNW31jxfOLZpKhVLRRPf9YRwIFKhRMQ2V8a1gU5tP8ny
	pohAALLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miWyO-0089Zj-Er; Thu, 04 Nov 2021 07:15:44 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miWwZ-0089B3-Nm
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 07:13:54 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlF9Y1kDszcb8l;
 Thu,  4 Nov 2021 15:08:49 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 15:13:33 +0800
Received: from huawei.com (10.29.88.127) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:13:33 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>
Subject: [PATCH 1/1] nvme: fix use after free when disconnect a reconnecting
 ctrl
Date: Thu, 4 Nov 2021 15:13:32 +0800
Message-ID: <20211104071332.28952-2-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20211104071332.28952-1-liruozhu@huawei.com>
References: <20211104071332.28952-1-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_001352_147805_54784617 
X-CRM114-Status: GOOD (  14.71  )
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

A crash happens when I try to disconnect a reconnecting ctrl:

1) The network was cut off when the connection was just established,
scan work hang there waiting for some IOs complete.Those IOs were
retrying because we return BLK_STS_RESOURCE to blk in reconnecting.

2) After a while, I tried to disconnect this connection.This procedure
also hung because it tried to obtain ctrl->scan_lock.It should be noted
that now we have switched the controller state to NVME_CTRL_DELETING.

3) In nvme_check_ready(), we always return true when ctrl->state is 
NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom 
device which was already freed.

To fix this, when ctrl->state is NVME_CTRL_DELETING, issue cmd to bottom
device only when queue state is live.If not, return host path error to blk.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 838b5e2058be..752203ad7639 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
 	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
+	    ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b334af8aa264..9b095ee01364 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -709,7 +709,7 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		return true;
 	if (ctrl->ops->flags & NVME_F_FABRICS &&
 	    ctrl->state == NVME_CTRL_DELETING)
-		return true;
+		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live);
 }
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-- 
2.16.4


