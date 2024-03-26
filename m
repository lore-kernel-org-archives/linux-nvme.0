Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377FFCD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiT+t1qG/VdSGW/5EQujDW8UKgIq9H0vwTRVSfAdPMo=; b=tUEYsouFsanVUGCsYwZjsYsrL1
	OOVBqbIKIGKzsiCGtwmkkU0B9cue68OLphnfBjHtVvuFMLhuoApqQkn1NYI1ptqOTtt8kCUDsgi+0
	ujsb1XHiZQLKdYSdsJMJ6w5CF5stQ7MAEVAa1JABDIYsMUjcm/hpr/sW6gHyc1fhkSBZqWNb88Np6
	pl/kLreZK/8Np+FxXWBN/o/K7W6pxGr6g6i37WhtVtJiSF5LG9BL89OFQU/t7bbnIUIhe6hwE9RO8
	/CShs1IR25ZHtOvmM2A0BzlHaZ1PSVtie9yo3CggiOjCGBqEyGo5mo7GnEFLdZWSuMcj9daErDzid
	cW2R/0/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XK-00000004Nel-1wFa;
	Tue, 26 Mar 2024 12:04:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X8-00000004NVL-2SNv
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:04:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E5CA5CE20BC;
	Tue, 26 Mar 2024 12:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC99C433C7;
	Tue, 26 Mar 2024 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454640;
	bh=vR8nQgYNjAD4yYmLmr5uHxpnivAB2NrzH9ZpAphVMbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntyOewsMYdSo27UAlEdeVkmYrH/CKiWlWPT0qTYPeh5HiFtvt356IvYj2tQpOjGKp
	 +h8vtV8ih1VTTb6Zujmn58FfAGh4yKA6UOKBt4AqfmkP7PQDeIhqd1hYG1jyjs0kk+
	 xhVSQfy73s6LFyNN4dBewnf7loj77vUqY7OphGk1s1x7uB2nHivKwDezqs6ZnEde6W
	 3u1T98TgKKA3BuaRLiuiMezzLRowSmsX53oPfFzr7BF4o3TeLzqNpJeQtWXC8ouEZS
	 Gz1mbd6+hHDUbO0y9Qk8tUWGwsUIMFPqwYygg4yokdBUTrRfcLLLs6JCkWKYG1rtS0
	 v09JRVGTrLNpA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/7] nvmet-fc: implement host_traddr()
Date: Tue, 26 Mar 2024 13:03:40 +0100
Message-Id: <20240326120342.105740-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050403_154888_5F739A89 
X-CRM114-Status: GOOD (  14.21  )
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

Implement callback to display the host transport address by
adding a callback 'host_traddr' for nvmet_fc_target_template.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/fc.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..b4706a8a9837 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2931,6 +2931,38 @@ nvmet_fc_discovery_chg(struct nvmet_port *port)
 		tgtport->ops->discovery_event(&tgtport->fc_target_port);
 }
 
+static ssize_t
+nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_size)
+{
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	struct nvmet_fc_tgt_queue *queue =
+		container_of(sq, struct nvmet_fc_tgt_queue, nvme_sq);
+	struct nvmet_fc_tgtport *tgtport = queue->assoc ? queue->assoc->tgtport : NULL;
+	struct nvmet_fc_hostport *hostport = queue->assoc ? queue->assoc->hostport : NULL;
+	u64 wwnn, wwpn;
+	ssize_t ret = 0;
+
+	if (!tgtport || !nvmet_fc_tgtport_get(tgtport))
+		return -ENODEV;
+	if (!hostport || !nvmet_fc_hostport_get(hostport)) {
+		ret = -ENODEV;
+		goto out_put;
+	}
+
+	if (tgtport->ops->host_traddr) {
+		ret = tgtport->ops->host_traddr(hostport->hosthandle, &wwnn, &wwpn);
+		if (ret)
+			goto out_put_host;
+		ret = snprintf(traddr, traddr_size, "nn-0x%llx:pn-0x%llx", wwnn, wwpn);
+	}
+out_put_host:
+	nvmet_fc_hostport_put(hostport);
+out_put:
+	nvmet_fc_tgtport_put(tgtport);
+	return ret;
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2940,6 +2972,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 	.discovery_chg		= nvmet_fc_discovery_chg,
+	.host_traddr		= nvmet_fc_host_traddr,
 };
 
 static int __init nvmet_fc_init_module(void)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 4109f1bd6128..89ea1ebd975a 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -920,6 +920,9 @@ struct nvmet_fc_target_port {
  *       further references to hosthandle.
  *       Entrypoint is Mandatory if the lldd calls nvmet_fc_invalidate_host().
  *
+ * @host_traddr: called by the transport to retrieve the node name and
+ *       port name of the host port address.
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -975,6 +978,7 @@ struct nvmet_fc_target_template {
 	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
 				void *hosthandle, struct nvmefc_ls_req *lsreq);
 	void (*host_release)(void *hosthandle);
+	int (*host_traddr)(void *hosthandle, u64 *wwnn, u64 *wwpn);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.35.3


