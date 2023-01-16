Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C3DC54EBE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu/nkh3n6CUef7i0kK+BljjRoWaSv8wuL6xCYGRdJMc=; b=ErS02bK1xbdeR8fQIPAxIWzT+3
	HXcD6RSILkUUeyzN+qyPdMGMpRxbpOghX0KvqPVRDnzkM/J+AIkLEmBV90KxqKhMDIKD5tBa8FSHr
	JrQJ3H870N86sM8vD+oh9laCY9+xotKjMDRaNlD32YpVSrkwLMUiVIqr9rSR0RbswffKs41xLTtSG
	KhYYk73x5cus+xuBe0y/2b+BHS2D0NGASvynNlGPEEqyolEIC97//RGBvWLLNr774UARD0M6kIUFH
	sQfWT7VaGFy5xM1qVQBEY4cumVfildcv6rlpyCAawwN7uKdOfKAgN0gQi+kIJiaoDvG7mhgh5hIp1
	Qm+s2ZfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPFY-00AIty-OK; Mon, 16 Jan 2023 13:10:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPCL-00AHPW-V1
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 13:06:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AD88FB80E37;
	Mon, 16 Jan 2023 13:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A50C433EF;
	Mon, 16 Jan 2023 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673874407;
	bh=JlISh7ZpJM1JouHMtly+4IcB63O1MxsyN1Eywkp8Wsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEBoKJSxCjguG2DHqyA7O8qM4GE3x282g/b/CwTfZAS4zWD4B6wASQ+jEB5v/9zR/
	 ghrEPqNMvev2QZmBhfekV3oRIuWjuTMKqu+Tzfqn8kldJwTA8QYAxUbuyHvhGL80BM
	 QdA4d1/nx3Ly5CVTs3zgz2eyIgWBsTZ5eAcizz+q/laOZkFfW1DiI9wgCVeZrkKahJ
	 +g3SoDr4gJw/IVa0yBpVcsJEhstqA9mYnolCld9y2SO7DzLDOhhyLv3ueEl/plNU8I
	 RLCCMIed/IZ9bzeQdgF5gf/J2ek6Vtx4EP26J7GKfgPLdqlLQWH17T/t1+hT8LCDHf
	 vrmptUx/xttaw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 11/13] nvme: Introduce a local variable
Date: Mon, 16 Jan 2023 15:05:58 +0200
Message-Id: <cf5bc542e014f465f7ae443e52e70def2993aef1.1673873422.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_050650_171996_086C4804 
X-CRM114-Status: GOOD (  13.15  )
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

From: Israel Rukshin <israelr@nvidia.com>

The patch doesn't change any logic.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa..51a9880db6ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1870,6 +1870,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
@@ -1892,7 +1893,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
@@ -1922,7 +1923,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 		    (ns->features & NVME_NS_METADATA_SUPPORTED))
 			nvme_init_integrity(disk, ns,
-					    ns->ctrl->max_integrity_segments);
+					    ctrl->max_integrity_segments);
 		else if (!nvme_ns_has_pi(ns))
 			capacity = 0;
 	}
@@ -1931,7 +1932,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   ns->ctrl->max_zeroes_sectors);
+					   ctrl->max_zeroes_sectors);
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
-- 
2.39.0


