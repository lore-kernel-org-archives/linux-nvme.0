Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C710FC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GE6jvv4vo9hIrUO9e74EA6q1Hg+Ul76xQx71cYxbHA=; b=bnsAVSGumxluqHmW7N2bpVNrB/
	JFi0kMFQhuN1zcEfWO1KOAY2XMXWTam3B9OTkbRq/XDHscJamEpHZxfmllyhJPBBmqNkTIEXA4Atm
	53KkM5SB9YqFYYiWaygTfbz6l28sQqVG6io/KO3tkJntCqqHWVkthsCWZJ/YlsGS/z1/DwgUe/4Sz
	JXvVF447k1JrcUaJAIuWQLBhC4uXGmv1invvJd3FYFkP3iPVjxhQ7QYh8OCrLhS+y2xipErd3oD++
	ZkvUZflluZS+fnRt4GFSR2fDHiyGIFdPfMOmIamVW2uMfO2r7Bs5sBlGKmvbWHuuUnodk3Ntjxjy2
	NOvOXszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XE-00000004NZn-31rR;
	Tue, 26 Mar 2024 12:04:08 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X5-00000004NU3-2CYj
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:04:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D95CCCE20B6;
	Tue, 26 Mar 2024 12:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB699C43390;
	Tue, 26 Mar 2024 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454637;
	bh=DB/L80TX8vO63QVyCrVggMSPfMAJgoUsrWeJxPtMsyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eU63IIXVPs5Nh3kiwsbuDWRaBxmaa8SHYNeG9MRW/ZBm2KDX+MstpOXGO/N5RT55q
	 kEYwEOX47ewShom788T2xPyrr4UMT7cn5jcPkf8FpuBPqY5GLk6V/h3/S5wmvpe9Eo
	 SkSA38QgzXajAVaM0qmvtZ3kJDIb9y+vZRWo4yna5PPewh71GGsqLklX3LYNhkVeg1
	 A8KVzdhMMo8GVpa2RdiPSo0hB8WOy5WsDIHy/siq+uVg1EZYwYytAEv+nb7MRr1rT0
	 JeR+5py1x3uK2gkeqWkUbL4qQ8sVy7jv4H95RhJIeDPY4VQPQ1Y/Seovzev1Qj7iTg
	 XO5RFZ//ae4Gg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/7] nvmet-tcp: implement host_traddr()
Date: Tue, 26 Mar 2024 13:03:38 +0100
Message-Id: <20240326120342.105740-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050400_167632_8984C4DB 
X-CRM114-Status: GOOD (  10.57  )
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

Implement callback to display the host transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..9c3c1456af52 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2170,6 +2170,19 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
+			char *traddr, size_t traddr_len)
+{
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	struct nvmet_tcp_queue *queue =
+		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
+
+	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
+		return -EINVAL;
+	return snprintf(traddr, traddr_len, "%pISc",
+			(struct sockaddr *)&queue->sockaddr_peer);
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -2180,6 +2193,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.35.3


