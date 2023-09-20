Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761BECE79D2
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Qy//vSiARWr5YpiOR7R56AAl9vnNNN21SRLudPvkJ8=; b=rhwMTYUwk/klB4BeXckBduDFtv
	xpW9SXdvLH4fmZ0oGkBLAx2ns51258O8CVCwWpe3IMwIma4RUNUc/ashB0yLBx7YfNWpiuAIUNAHy
	2ubWd6vewaWlK74zl8oAHZ/FjDCeTEtOUpb81EAucPuM0FdDGJcnwU1zJuAIoXSw/CLVci22B+H+j
	sRDgg+w5H6ZNdEJa6608ymmDGPlwRUCKufG1isJWBCqGi/eL4GkFvZdwbYEfQU5CoNnRSUBygHimF
	2cQxYywD4PLBFfxts6TDXZP82k05Rb93ptZx5zY3heujva192kpVQSZ3OhLt9WLVOStczi2FsSY5P
	Wi8Ba8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qixwU-003I0L-1U;
	Wed, 20 Sep 2023 14:12:38 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qixwQ-003HzB-2a
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 14:12:36 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317c3ac7339so6296896f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Sep 2023 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1695219152; x=1695823952; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qy//vSiARWr5YpiOR7R56AAl9vnNNN21SRLudPvkJ8=;
        b=DpjlYbBRL8PssFZal1tgHMuRzgxsIsacUS2RFrWUcSaGvzUTScsog9pfy/n7CNhK+F
         h83txSWlSmufIr0G3yOz8MZZx1mencs8arcjzh5mx1txct4G73Pj5byMMSgXS1QRIKEb
         r4r8kbCF5HzM4VMLyevJa/aI0e7kv3IZFYdCX5ZE+5so6jl7Vg2Hc5Aewa/W70WaAzmR
         xouE3bxTOAVkhBNZu4kdkguYS3at7bzapRBdHxcpwHnnRFKiGq6cIM17I4WRD52THnqz
         /l11CA8uGqXdvb/2HQTbwOOa90h+kZ6zrzaV6ZArc5bNUNodta1nhBAv1xu7rgzadkRG
         xWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219152; x=1695823952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Qy//vSiARWr5YpiOR7R56AAl9vnNNN21SRLudPvkJ8=;
        b=Xgb19Fw9tE/k6UQC1NRlEtMWSsURSKpyd79cy/FvvRHWR6NiYAoXSwJLtV7D6j31/V
         W6VSkWCAguCplgqemKLD6mPJ5mIF5Oe6AM7rJhKsFFvpcc64f9qpkURCPQtTQJCkXG/b
         I9taUu5M1825QTdABBTb7Rvuy0p7lq5JxTMDSC99Fxpa1doWIA8zppkTxKnGeSBHkdIR
         bcVa83W9jkJmW9eeBFwm+BG9TSZzKhaw/BiKicXy253rwSeGM1XZ1cIu1XcSojhreoQ7
         YPJiwlw8xSjTBCzWhJZbHWLaOnN0nJQn78GHW8t3uVkAXg4sdOC/jAPe7jhUPiiY4Pr5
         OD+A==
X-Gm-Message-State: AOJu0YzKkRCXB/gYqoGRtlhu1IbDiy3aUuI6hW6aaWra7TvOVZC2vVAr
	wlQr/tqyO91XrkXkETcgx/RQ+fcnMM01Am/DEfFp5xz+
X-Google-Smtp-Source: AGHT+IGR5msYAN5T2XxSxXGvS1wOWp4DDktHSu8m4Tuz8FsDlWn0h7ArsGnf1XxaIjO62o8W8uVLvA==
X-Received: by 2002:a5d:5233:0:b0:31f:a62d:264 with SMTP id i19-20020a5d5233000000b0031fa62d0264mr2371272wra.37.1695219152114;
        Wed, 20 Sep 2023 07:12:32 -0700 (PDT)
Received: from localhost.localdomain ([185.123.26.202])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm18297263wrt.40.2023.09.20.07.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 07:12:31 -0700 (PDT)
From: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
To: linux-nvme@lists.infradead.org
Cc: kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	antoine.damhet@shadow.tech,
	valentin.brice@shadow.tech,
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: [PATCH 1/1] nvmet: View subsystem connections on nvmeof target
Date: Wed, 20 Sep 2023 16:12:06 +0200
Message-Id: <20230920141205.26637-2-redouane.boufenghour@shadow.tech>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_071234_840000_20D2E32B 
X-CRM114-Status: GOOD (  18.23  )
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

We add a new entry in the tcp and rdma factories to retrieve the peer
address of a ctrl.

The functions nvmet_rdma_disc_peer_addr and nvmet_tcp_disc_peer_addr return
a snprintf of size NVMF_TRADDR_SIZE with the address connected to the ctlrs

which is then displayed in a subsys attribute attr_connected_ctrls on RO

Co-developed-by: Valentin BRICE <valentin.brice@shadow.tech>
Signed-off-by: Valentin BRICE <valentin.brice@shadow.tech>
Co-developed-by: Antoine DAMHET <antoine.damhet@shadow.tech>
Signed-off-by: Antoine DAMHET <antoine.damhet@shadow.tech>
Co-developed-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Signed-off-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
---
 drivers/nvme/target/configfs.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 +++++++
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/rdma.c     | 10 ++++++++++
 drivers/nvme/target/tcp.c      | 13 +++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..6cbbe71244dd 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1426,6 +1426,35 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
 
+static ssize_t nvmet_subsys_attr_connected_ctrls_show(
+	struct config_item *item, char *page)
+{
+	ssize_t len, ret;
+	int peer;
+	char dstaddr[NVMF_TRADDR_SIZE];
+	struct nvmet_subsys *subsys;
+	struct nvmet_ctrl *ctrl;
+
+	subsys = to_subsys(item);
+	len = 0;
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		peer = get_peer_traddr(ctrl, ctrl->sqs[0], dstaddr);
+		if (peer < 0)
+			snprintf(dstaddr, NVMF_TRADDR_SIZE, "unknown");
+		ret = snprintf(page + len, PAGE_SIZE - len,
+			       "hostnqn: %s; peer_addr: %s\n",
+			       ctrl->hostnqn, dstaddr);
+		if (ret >= PAGE_SIZE - len) {
+			sprintf(page + PAGE_SIZE - 14, "\n[truncated]");
+			return PAGE_SIZE;
+		}
+		len += ret;
+	}
+	return len;
+}
+CONFIGFS_ATTR_RO(nvmet_subsys_, attr_connected_ctrls);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
@@ -1436,6 +1465,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
+	&nvmet_subsys_attr_attr_connected_ctrls,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..ba5997a14675 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1629,6 +1629,13 @@ static void nvmet_subsys_free(struct kref *ref)
 	kfree(subsys);
 }
 
+int get_peer_traddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, char *dstaddr)
+{
+	if (ctrl->ops->disc_peertraddr == NULL)
+		return -EOPNOTSUPP;
+	return ctrl->ops->disc_peertraddr(sq, ctrl->port, dstaddr);
+}
+
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..60ea2391a957 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -341,6 +341,8 @@ struct nvmet_fabrics_ops {
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
 	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
+	int (*disc_peertraddr)(struct nvmet_sq *nvme_sq,
+			       struct nvmet_port *port, char *dstaddr);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..395554a77fc1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1992,6 +1992,15 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 		memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
 	}
 }
+int nvmet_rdma_disc_peer_addr(struct nvmet_sq *nvme_sq,
+			      struct nvmet_port *nport, char *dstaddr)
+{
+	struct nvmet_rdma_queue *queue =
+		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
+
+	snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
+		 (struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
+}
 
 static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 {
@@ -2015,6 +2024,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.disc_peertraddr        = nvmet_rdma_disc_peer_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
 };
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..ae454c176fac 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1871,6 +1871,18 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+int nvmet_tcp_disc_peer_addr(struct nvmet_sq *sq,
+			     struct nvmet_port *nport, char *dstaddr)
+{
+	struct nvmet_tcp_queue *queue =
+		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
+
+	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
+		return -EINVAL;
+	return snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
+			 (struct sockaddr *)&queue->sockaddr_peer);
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -1881,6 +1893,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.disc_peertraddr        = nvmet_tcp_disc_peer_addr,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.39.2 (Apple Git-143)


