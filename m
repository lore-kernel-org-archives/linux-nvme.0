Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D604CD11BF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5cRiEk9qD3y1xXnrrt7sR0OydQhYdQWn4F3nD79lig=; b=iZmFdctWtUvGT8Wa/My8D4dwWR
	cIzySCFeMv1dAO2T48afVYdbd8XsXoRRQ3CQtkm2jXZhMuW1hT/Ak5gs68hdycpUfxdGnopNMTeC/
	J9SzUjFGgjrANPVOVKt7Hcy7jM9pAVdupqfAus6KnCGF8qws339xhByyw9YX3UmYpcUISI4Msba/H
	Q31mr6z5XR+bXgBO+YaC/DkX9UPGOI9NoK7JtqihCSsOjPwRDF4uf0chfEr/cmRoz07ZQgLanOkVt
	2g1CDpLyUmX6KcsgtuzoZCt3xQQxgqInetcnDNf/U0Nbv0RiAFmnvroCEFievDEouVPUFF7PiMqAV
	yxzi6n1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7S-0000000HTt5-1i4q;
	Wed, 20 Mar 2024 14:40:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7L-0000000HToz-33if
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4714461027;
	Wed, 20 Mar 2024 14:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C41C433F1;
	Wed, 20 Mar 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945635;
	bh=b6W9eyBtx4gUYE+Q64U9VZ5IIVKy5EDPgM4QB/y14TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trfiHHAX5Kf3h5X9rs/EGwGs0d9gRg/f39eM4GHLyNaaG7JFtLAuychkvrZRb/dxh
	 7shw69FXAJ1l1EXy86bzaRl+6qQyO0bBVXlJrRlMekaVcm0GkDowFnqovD1PlwCCdj
	 RUaML7tko8cZAA+Fli4FVjqkrtrVo1BaYwuOJuRJg0b+WW3K2B3uFjSCazADXgfwPW
	 jw/TSNPH5r85ckH6tVjSJtd+TQgdzzQawH5zxlgNSpgGVAH7mhFzpsGNRU4VRjXp6T
	 b4iF/uQpUf+UmRGHB1Qq33+qRTdxObmmfWdiaAqnS430Oc1vlzbyXtVtO/loiyQ9ER
	 5QEYWCGx0/iBA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/7] nvmet-fc: implement queue_peer_traddr()
Date: Wed, 20 Mar 2024 15:40:15 +0100
Message-Id: <20240320144017.106283-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074035_831084_F1D5B45C 
X-CRM114-Status: GOOD (  13.64  )
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

Implement callback to display the peer transport address by
adding a callback 'host_traddr' for nvmet_fc_target_template.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/fc.c       | 25 +++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..b0fedff44e51 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2931,6 +2931,30 @@ nvmet_fc_discovery_chg(struct nvmet_port *port)
 		tgtport->ops->discovery_event(&tgtport->fc_target_port);
 }
 
+static ssize_t
+nvmet_fc_peer_addr(struct nvmet_ctrl *ctrl,
+		   struct nvmet_sq *sq, char *traddr, size_t traddr_size)
+{
+	struct nvmet_fc_tgt_queue *queue =
+		container_of(sq, struct nvmet_fc_tgt_queue, nvme_sq);
+	struct nvmet_fc_tgtport *tgtport = queue->assoc ? queue->assoc->tgtport : NULL;
+	struct nvmet_fc_hostport *hostport = queue->assoc ? queue->assoc->hostport : NULL;
+	ssize_t ret = 0;
+
+	if (!tgtport || !nvmet_fc_tgtport_get(tgtport))
+		return -ENODEV;
+	if (!hostport) {
+		ret = -ENODEV;
+		goto out_put;
+	}
+
+	if (tgtport->ops->host_traddr)
+		ret = tgtport->ops->host_traddr(hostport->hosthandle, traddr, traddr_size);
+out_put:
+	nvmet_fc_tgtport_put(tgtport);
+	return ret;
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2940,6 +2964,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 	.discovery_chg		= nvmet_fc_discovery_chg,
+	.queue_peertraddr	= nvmet_fc_peer_addr,
 };
 
 static int __init nvmet_fc_init_module(void)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 4109f1bd6128..885f2951041b 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -975,6 +975,7 @@ struct nvmet_fc_target_template {
 	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
 				void *hosthandle, struct nvmefc_ls_req *lsreq);
 	void (*host_release)(void *hosthandle);
+	ssize_t (*host_traddr)(void *hosthandle, char *traddr, size_t traddr_size);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.35.3


