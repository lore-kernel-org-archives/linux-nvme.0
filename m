Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C4C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 07:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOjwNMzQimvHBnjKEShpP0ueAK03r67ieyz3P5Y/XKQ=; b=cEv5ae6nJVXsNGe+wFHMv0SqFl
	CIZ1CcvkFqPmyU0fJ8cP9f9+vQ+tkJ2HgTyfQ671IX4fl4odnWpuD0JVygZYRyqELya6tbFXC9bYw
	UUN0G1UeBP0k6M54a08PnCXIM28s7+cAg81lFT+vBStRe4+5aix7PSeQcFumRvI1s2G+uZexhMGzi
	tUAO7fNx2eNiDfpoYzISZ30MLOz9bfjLCu/nyjc5Wu0n0KP0QZMsxvfZpqwCMKHevFZoGD91ZOYqE
	n5irQcvh04J+E4wS+Oe+FoNQDSsUGxo6/URxI2fOKguNVp1/yBLs0y1Selo0rjw13oUWxq76fc+Hn
	Tbz30rBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVio-00000004JS3-1j5H;
	Tue, 01 Jul 2025 07:48:06 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVM1-00000004GQx-0APD
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 07:24:34 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bWZKP10hdzYQvWY
	for <linux-nvme@lists.infradead.org>; Tue,  1 Jul 2025 15:24:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 065A61A0CD5
	for <linux-nvme@lists.infradead.org>; Tue,  1 Jul 2025 15:24:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAHaCUljWNoBbgrAQ--.17981S4;
	Tue, 01 Jul 2025 15:24:23 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH] nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()
Date: Tue,  1 Jul 2025 15:17:17 +0800
Message-Id: <20250701071717.2619384-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAHaCUljWNoBbgrAQ--.17981S4
X-Coremail-Antispam: 1UD129KBjvJXoW7GryDXr15Cry7Zr15tw15CFg_yoW8JrWUpF
	4fur9rCrsrCr4kG34UXr429343Cwn5XFyUAr93K3ZxZryFgFWjvrnxK3WavF15Jr18Zryr
	ZF40gr47Krs8ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_002433_244290_9BB57A5D 
X-CRM114-Status: GOOD (  11.68  )
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

From: Zheng Qixing <zhengqixing@huawei.com>

When inserting a namespace into the controller's namespace list,
the function uses list_add_rcu() when the namespace is inserted
in the middle of the list, but falls back to a regular list_add()
when adding at the head of the list.

This inconsistency could lead to race conditions during concurrent
access, as users might observe a partially updated list. Fix this
by consistently using list_add_rcu() in both code paths to ensure
proper RCU protection throughout the entire function.

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..475115edbbe9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4077,7 +4077,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 			return;
 		}
 	}
-	list_add(&ns->list, &ns->ctrl->namespaces);
+	list_add_rcu(&ns->list, &ns->ctrl->namespaces);
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
-- 
2.39.2


