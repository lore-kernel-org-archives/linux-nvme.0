Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFCC25B0E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 07:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XB9pn4kwbplcA/heEuxVXtJ+EYgX8oQ7hFuMQGQcbJw=; b=Xcak/9beo+vRj3QDyF9/ElcDkm
	JKREn7Pm1UBacOd5SutAYiba/gOVkzTOLIrDk1JqQWJtY8l8G+zU7lG3qqJ5iLIVKdDvztt3Gvhw8
	QS7NvXHWGXMFhBeMyE4ICs6oc+b5QrMN18taEjaPfKaC0JaIi/K5pImV9tGLUhiqq3RMTr+2nOXYY
	SFhYUvSye8DQ6OaK/ijef56x+xe5IoHWPnDUxO9opTTrj0EKKsOkBZosBPLVBUCusFJtlsN6OnW+5
	Q560qTn/D2yDQdS7AXsS+XoSAp2Y/zFlZHNfg15lWqHV5SH1GHRQk9/F6yiMmY9XjXkI1ge1Z1DVN
	kOF003TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOwtu-003hrc-S6; Fri, 19 Aug 2022 07:58:42 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOwtr-003hn5-Rl
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 07:58:41 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8DZH56fkzlW7S;
	Fri, 19 Aug 2022 15:55:19 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 15:58:26 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<lengchao@huawei.com>
Subject: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Date: Fri, 19 Aug 2022 15:58:25 +0800
Message-ID: <20220819075825.21231-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_005840_129089_5E5DF135 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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

Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
case of low concurrency, if some packets lost due to network abnormal
such as network rerouting, Optical fiber signal interference, etc,
it will wait 2 second to try retransmitting the lost packets.
As a result, the I/O latency is greater than 2 seconds.
The I/O latency is so long for real-time transaction service. Indeed we
do not have to wait so long time to make sure that packets are lost.
Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7d01fb770284..2dbb1b21acc8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -602,6 +602,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		ret = PTR_ERR(queue->cm_id);
 		goto out_destroy_mutex;
 	}
+	/* set ack timeout to 262ms(2^(15+1)*4us=262ms) */
+	rdma_set_ack_timeout(queue->cm_id, 15);
 
 	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
 		src_addr = (struct sockaddr *)&ctrl->src_addr;
-- 
2.16.4


