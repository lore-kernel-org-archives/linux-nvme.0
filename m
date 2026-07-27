Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D178FC53200
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 03:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GaI0hMElNzTM/lcdGt1H04ptI6J2l68RjYelI8R0ZKM=; b=ctNAVJrTjl+nKDfg69Hqe1L9xO
	r9Yjxd1HlHhqI+fEPhcUHve9siBArvWXhXk144F3+DPGQ9MiR2WfgwIIdeap7r/BJ5JOxzv729ba3
	sOEt6W7qbsCF+QAxZ3EVQCGsMy0fCvoLbabxwbQLbf9Ma31/LIbwD+2bGFnXl11g26l49eZAOs0x9
	fyFCzj32S+PpqKQYUpSEQ2uqHztHfgGxGpaNmcieZj5U0JPSDQfrSLcKtLw2ENe1EgW2PCxy0WBaQ
	2Axpa04WUenxRtNg8cqwHpyuKwFPj2zDRtIgcTNuc6n4WW7bv2b+NsUXaVaRyyTKD9y0aST4VcPXR
	SoL+3qyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsR-00000001rYs-2GWF;
	Mon, 27 Jul 2026 03:19:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsQ-00000001rYY-16SK
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 03:19:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2B0260A59;
	Mon, 27 Jul 2026 03:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2E11F000E9;
	Mon, 27 Jul 2026 03:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122377;
	bh=GaI0hMElNzTM/lcdGt1H04ptI6J2l68RjYelI8R0ZKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZdaEJtgk8ECr1bgw31AU26DSADACYCQhT1y8p7OtaAVomWP7ld4wxPH8wLDrQdvb
	 fdQl4uqfewR/y5RKzQjUc53DrjXx5FKvhS0LjBfaxo3Iy71oMhPdDfUrm3ymzfNvI8
	 toWQgOAoAhZnRSZ5hz9DmjiEk5itJ8T+EcOLY8Oomz1phszS70m2zK9+ypGtGc9t94
	 BLVY9JmE7d67B+7pwGxL8kxRA19IaM+/mDq6ESZybuXRig527RFJTz+sPj/bonN56Q
	 btVmfwzn/+qvjT+nAQOAo9kbHOQvZYgNiSO2glfC0/caJ5iE6/dEDO+3/ndKNzD9WF
	 nrOqaLcbFAaEg==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-tcp: support IPv6 traffic class
Date: Mon, 27 Jul 2026 11:19:02 +0800
Message-ID: <549f83b446749c1d40494db5b3df68f0e6a6ab61.1785122120.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785122120.git.tanggeliang@kylinos.cn>
References: <cover.1785122120.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The fabrics layer now supports parsing the tclass option, but the
NVMe/TCP transport does not currently advertise or apply it.

Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
socket when a traffic class is specified. Keep the existing IPv4 TOS
handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..f35c047ea02b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1779,6 +1779,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int tclass = nctrl->opts->tclass;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1837,6 +1838,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+	if (tclass >= 0)
+		sock_common_setsockopt(queue->sock->sk->sk_socket, SOL_IPV6,
+				       IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
+				       sizeof(tclass));
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -3041,7 +3046,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_TOS | NVMF_OPT_TCLASS |
+			  NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
 			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
-- 
2.53.0


