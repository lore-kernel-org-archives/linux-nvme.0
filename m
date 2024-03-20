Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58548C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpTC0gCLa+ir9NvWlWNZmFJl/S9x81H/VRSN980hIno=; b=w7H0IFVobiKoKFeXO5s7VF/RwC
	cNmlnYIj+imCAy+AwhvhgXByMDPjeolMtGaLySuoT+I+M9xYqGQMV4ooa86BWdrrOckHKuAQc7TqW
	5CSNM/R3XhAoR7g0gNcZYW8GfEwFR9IDDihnUL92g6Ef4WkyM3XZHhThsRP9YS1L8Zg6mznViRhh+
	nlatz0FTHY6Qen0t1WXWab4MqMC9l6WMjkB5ERidZKQGPa5Z86DRcXkH+NztKM1YAES/EScqzRaPb
	SO0K1HRWwzDwwwBZPrUnwvreFUwos+M3ds2q+R0po4mKAcEwj54bB8yqoTfl6gPaLvb15ad44QVZI
	c8wx+Tow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7P-0000000HTra-396q;
	Wed, 20 Mar 2024 14:40:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7J-0000000HTnt-3gcK
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5149961022;
	Wed, 20 Mar 2024 14:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8386DC43390;
	Wed, 20 Mar 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945633;
	bh=XT/wqKCmxAvw4bDySi+X2lj0D1bexJiGl2tZ6dU77Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7p9+xXcoYpyuhIrExEdfVC58ylTfd6r3dOpO/pM3b7eH+s2QksTVtxZZAJDpdCf9
	 Vxjvop31lIJ++sF7l3me4UAA8Lq32X5n/zkTfLn7PkOO79AjKWouh/dVHdyQK+Up+q
	 PGXTbZk2QaYGs9/iwgn0KXH4zkCHNXmUHFRDGoInSpyVv2P0+FF3oNuvb58RRyYNYP
	 QqaBXDyEmktwEcvC+0ipqVROm7SNRfPbbhfGI8Pfp37URlI7I5l+fA7YtiWLGhJwxc
	 aSuFQepZ7t78E5ETYk7wI2l8C4dj1Ckuwjv7a2GAwuIktV6oqImHgVoO2Go9u3FvzO
	 2RxLvufnvKhdQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/7] nvmet-rdma: implement queue_peer_traddr()
Date: Wed, 20 Mar 2024 15:40:14 +0100
Message-Id: <20240320144017.106283-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074034_046349_67421826 
X-CRM114-Status: GOOD (  10.26  )
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

Implement callback to display the peer transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f2bb9d95ecf4..16183c554a3d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2014,6 +2014,16 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_rdma_disc_peer_addr(struct nvmet_ctrl *ctrl,
+		struct nvmet_sq *nvme_sq, char *traddr, size_t traddr_len)
+{
+	struct nvmet_rdma_queue *queue =
+		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
+
+	return snprintf(traddr, traddr_len, "%pISc",
+			(struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
+}
+
 static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 {
 	if (ctrl->pi_support)
@@ -2040,6 +2050,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
+	.queue_peertraddr	= nvmet_rdma_disc_peer_addr,
 };
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
2.35.3


