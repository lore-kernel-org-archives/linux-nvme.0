Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BADC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fVulqpXd5PeEYKcJnCznT37zacenMzr4PC2sY5hUSXg=; b=d2Ms0qZ7Bt4sKz72TBNNyKdRtB
	4Jq23AO4XvANmNmp2r7zcu9AbrJDWw8rrGrUP5sl1FtGFdDXYBSBLJVKUnLlYWLlvjoc1X3T8DYh6
	BF1MUxwmi1X9hkOCcAydeZTbdpVPED6d/x4vsTWR+hPubN5fqcnYu3ib5s/rnVo+UQfbi0fnSTlr/
	SpKIUJMxheJQWuRSD+g0NY2IUGa7AtW7SRfpKe95QtkAdjlI0QHcvZNBB3TyT032eBJGeAIyh+taV
	D3O54/CB0wXrtV1Vkun3p6TNlreKLR6Bpq9qht++qv2XEx967Ga/JCsgMsJpU4tez9NNqZ9Fil7WB
	l2/sgIOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mt6nr-00FMbA-R8; Fri, 03 Dec 2021 11:32:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt6nS-00FMPy-Bd
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 11:32:12 +0000
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J59d81Thrz91Wj;
 Fri,  3 Dec 2021 19:31:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 3 Dec
 2021 19:31:58 +0800
From: Hou Tao <houtao1@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>, <houtao1@huawei.com>, 
 <jiangtao62@huawei.com>
Subject: [PATCH] nvme-multipath: zeroing ana_log_size as well after free
 ana_log_buf
Date: Fri, 3 Dec 2021 19:47:15 +0800
Message-ID: <20211203114715.1936811-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_033210_623041_634C55B5 
X-CRM114-Status: UNSURE (   8.81  )
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

Zeroing ana_log_size as well after free ana_log_buf, otherwise
when nvme_read_ana_log() or kmalloc() fails, ana_log_size
will be valid but ana_log_buf is NULL, and the next call of
nvme_mpath_init_identify() will fail definitely.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index afa33845420d..17e61a1baa69 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -869,7 +869,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 	if (ana_log_size > ctrl->ana_log_size) {
 		nvme_mpath_stop(ctrl);
-		kfree(ctrl->ana_log_buf);
+		nvme_mpath_uninit(ctrl);
 		ctrl->ana_log_buf = kmalloc(ana_log_size, GFP_KERNEL);
 		if (!ctrl->ana_log_buf)
 			return -ENOMEM;
@@ -895,4 +895,5 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
+	ctrl->ana_log_size = 0;
 }
-- 
2.29.2


