Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CEFC25B79
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z5pvrhieUcOgLKqN/Xi4k0GTZFDDY3ypB0X+okUxApA=; b=nfKz2aCnMGZngyJnRFGIjjoHBu
	kX3fj9gKR5z9Fb3SWecFvh0koVFMXiokv8cLnFOP6y2cFGOkzGNbant7ft0NsOpFGCxA8fVcRunC9
	NY3Sz3WX5G1nBpYmP4+FSnn0Y6TuMUzekbOjyZtKJUJzzJo12vMDw+MQRGx/tbPll2wlEuNEc6Mgw
	sxnGgvpXe+BjuxVfKKLHwJVzFwiga65/0HxgG6LfP7x66qBV01qUAkF36yOM/tMIwjBqhcMITAAtL
	0LE161k/e16XDjJ9lpaNwbj+vWINLOpNq2SGhB8frWzgfosAGE0SL9Gli30WYqHNyTFSBoqRxRs4t
	/j/H9gPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiD-0000000DoXk-3H5b;
	Mon, 27 May 2024 05:15:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi8-0000000DoUw-2w4F
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:15:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D964821C48;
	Mon, 27 May 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C419F13A6B;
	Mon, 27 May 2024 05:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7KgtLv8WVGYVYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:43 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 4/7] nvmet-rdma: implement host_traddr()
Date: Mon, 27 May 2024 07:15:22 +0200
Message-ID: <20240527051525.762-5-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D964821C48
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221552_909968_9044E8F1 
X-CRM114-Status: GOOD (  11.24  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement callback to display the host transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/rdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 955296ac377f..3a2a1464dd01 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2008,6 +2008,17 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_rdma_host_port_addr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_len)
+{
+	struct nvmet_sq *nvme_sq = ctrl->sqs[0];
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
@@ -2032,6 +2043,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.host_traddr		= nvmet_rdma_host_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
 };
-- 
2.45.1


