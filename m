Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61337C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lLpcuuKgy1kkVlnQ+cR6HCOy4A9a3+p5XjMhLOHDNGM=; b=kJ/cRu1PEsIPe5SEL/j0qxP5hZ
	LAhm9ncqS+jtP2Uu3lkbS4NE7ekrQKcD14K4dmE8tIfk7JOw9oaDmKXlRlL5SNeU/gxBa/2qUtIck
	Np7sVEIv2E4PUn8UZskBKvu8gJhTOMmO2FAHE8AxIbqTPQ/zIrh2FT1trUEVpvvEYLgmjGJ/PN7qw
	cHRb4c3YB4mb+p5z2pltf3+5hERRt3Gs8tYFtJ/kDKnjF39xKrwj87KJ83OWDen+mZOB+pFcuMVL7
	md61rOsb5gw11/OPQ3Zj5R5I3MuTpzhharMcFzEuIoZagyhE0W3uteSvip50cLb+x/J7MxpGoqE3p
	/q2ibHiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU8Wd-009YaL-Hh; Tue, 15 Mar 2022 14:51:51 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU8WV-009YWB-PQ; Tue, 15 Mar 2022 14:51:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: warn about shared namespaces without
 CONFIG_NVME_MULTIPATH
Date: Tue, 15 Mar 2022 15:51:41 +0100
Message-Id: <20220315145141.2586124-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Start warning about exposing a namespace as multiple block devices,
and set a fixed deprecation release.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c     | 1 +
 drivers/nvme/host/core.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8fb89d0624fc5..e733c48de2e90 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2092,6 +2092,7 @@ static void loop_remove(struct loop_device *lo)
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
+
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	mutex_unlock(&loop_ctl_mutex);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd9878671d734..75f7c53a67811 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3879,6 +3879,14 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 					nsid);
 			goto out_put_ns_head;
 		}
+
+		if (!multipath && !list_empty(&head->list)) {
+			dev_warn(ctrl->device,
+				"Found shared namespace %d, but multipathing not supported.\n",
+				nsid);
+			dev_warn_once(ctrl->device,
+				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
+		}
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
-- 
2.30.2


