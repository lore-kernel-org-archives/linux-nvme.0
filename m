Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC50C5320E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AivzPH5sQi90+3DuL4FSWJ8WPwkMMxPl1Cydu+qDryA=; b=qouWnG47Fi5MMDvPkYL9RCyHdP
	x369wXQHdTlQYSlVggZEhgmdFMGoxj46wBJZOC9MeMl/hwLSBbbvCJLQjEGjLjbT1UMI9IUBoWj+7
	eIxoQihzx76pONjMCL3DQmGuhbWtltrwz7dCrDkJl5idMBgdVJCu1e+6NqwGqcR2K1G8s2zm0Lg6s
	9UZF1dZS7RZX9XtyzK8bvpTxvNK9yWjNdObGmYcdH/sEo5KE3rHtjiOQ+fXY87BhNr/YzyCKDl+sy
	6kHLgcchMM9Po1nOV0spWh9zuzjmNpEcphwBM9ochY/l0Pbs8D0DgjEhTT0ygF/s54TZk1xbDzL0Q
	tfW2N4+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg11C-00000001Jrf-2m1g;
	Mon, 19 Aug 2024 11:57:50 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg0we-00000001Iak-0IKY
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 11:53:10 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnWDR692JzyQ2M;
	Mon, 19 Aug 2024 19:52:23 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8294F180064;
	Mon, 19 Aug 2024 19:53:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/8] nvmet: Make nvmet_debugfs static
Date: Mon, 19 Aug 2024 20:00:20 +0800
Message-ID: <20240819120020.3884893-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_045308_448994_1AEFA620 
X-CRM114-Status: GOOD (  10.04  )
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

The sparse tool complains as follows:

drivers/nvme/target/debugfs.c:16:15: warning:
	symbol 'nvmet_debugfs' was not declared. Should it be static?

This symbol is not used outside debugfs.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/nvme/target/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index cb2befc8619e..220c7391fc19 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -13,7 +13,7 @@
 #include "nvmet.h"
 #include "debugfs.h"
 
-struct dentry *nvmet_debugfs;
+static struct dentry *nvmet_debugfs;
 
 #define NVMET_DEBUGFS_ATTR(field) \
 	static int field##_open(struct inode *inode, struct file *file) \
-- 
2.34.1


