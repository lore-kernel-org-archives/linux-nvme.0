Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9C1CD11BF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQtWlFAWewATLDbmG2X7Ek4YsPrbIB8vhnZb9HMPQfI=; b=UP8xE3A09Rj5emazG1kTGEjylt
	LGARKnPzvxwTYOJm0r8VoRHQ/ztdzRr3Jn/nl8S3PgROpTwB9ZlAIb1lI03FLDTKYTsHId74z0EDJ
	84Hxdiy/ETTO58jwe7OzxgGkk48Hm1mT9W2K/ohRZ4LXtixEI0lJgcr6ANpuavf+pBV3KzOqbPJEe
	Nc8vuRkFaQSf2/yqzY0jBQNLa8rqRBxE2zk24C2OcAZNGetS+EI4vmIeEkjRuIIpt1zwQ6+NwdNnU
	BdNgTkntv8MJ19LD3ciPPSGXfPtKrXQ9385dzv+HK/sobjuVHMFAkJngFrMHMYDTXC3+vuHsYCIQ7
	YRf725UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7N-0000000HTq8-0TEA;
	Wed, 20 Mar 2024 14:40:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7I-0000000HTmO-0bMH
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F8686100E;
	Wed, 20 Mar 2024 14:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAF6C433C7;
	Wed, 20 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945631;
	bh=0JP6jsk4Va93drBckNWwUz8GcjccEhqnztC1cu1nnB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKfvWvuMcuEIdRz+m+/0864g5Uti+QlYV6JCFJWibrFuJBZJSl2rYL7uSGizlXrP+
	 lWu8/LwB9wMtASVkKTDitmlA3ylY2lS09o3+CzLKwsA37FQOHoCuTn8dLVuZpxZBAK
	 E3PdUwi9V13+pARYieUG3tC1Op10SwGJjqkgG5WQjOyAtje8fCTw/+4sONWpF3CYc1
	 CMKnc/R86tXVV02pzEZAahI0xCrnhfb1onL2fHPthiq8yXY+lNGtV9RfFCMt3/YtVj
	 1bwv6fPBIij1yfOnt8LJyAh9e9zvpa9n3uFohnVkLN3gXhHqEsQW1RJcUBkfgwo6Fz
	 zfqWy0WTee51A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/7] nvmet-tcp: implement queue_peer_traddr()
Date: Wed, 20 Mar 2024 15:40:13 +0100
Message-Id: <20240320144017.106283-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074032_248933_29CA66F7 
X-CRM114-Status: GOOD (  11.35  )
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
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4718d4d87a85..4b2cef897a66 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2201,6 +2201,18 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_tcp_disc_peer_addr(struct nvmet_ctrl *ctrl,
+			struct nvmet_sq *sq, char *traddr, size_t traddr_len)
+{
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
@@ -2211,6 +2223,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.queue_peertraddr	= nvmet_tcp_disc_peer_addr,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.35.3


