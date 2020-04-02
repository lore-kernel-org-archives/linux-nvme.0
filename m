Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E81C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D622063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edfFV2zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D622063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nTBiia0aF4N6RMKzQiXX4jij+ZKc4t19bncnP2ALOOw=; b=edfFV2zOTpBAqa
	xNF1tHb5L8+KIE6IFlgHy0ZwjMwxwoghRpnVn4/b4YE2hjK17ovcdJq69x1UI9UYF6CNHpNyMiDkp
	0LnyNXBwX9Skpr1nXpg0ajEwI0jgk4n7qKr52mrYjQ1xScRPcmO1FDGjQO7Q8b0frRFpbtF5DGbdb
	Zo9/LuKP1GycCQs4S3V/2dRejJjZuk4cdqFqrr3lVzl1v9FKh/EhQHzaEju6qnyPsT4DkD3b08m7Y
	Qt+b1J+xNhBxlZX0F+rvfsR5yXGhOA27843kwtQUrS6M+59dPxqVLLwsuFkumc5+t+NzHgYQMEraj
	Ncu4Si+u/VbDQEdTixrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK25P-0007KA-Fw; Thu, 02 Apr 2020 15:48:55 +0000
Received: from [2601:647:4802:9070:a836:db4c:a7ac:3d7c]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK25N-0007JY-VV; Thu, 02 Apr 2020 15:48:54 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvmet-rdma: fix bonding failover possible NULL deref
Date: Thu,  2 Apr 2020 08:48:53 -0700
Message-Id: <20200402154853.14108-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, Alex Lyakas <alex@zadara.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
on normal as well as on listening cm_ids. Hence this event will
immediately trigger a NULL dereference trying to disconnect a queue
for a cm_id that actually belongs to the port.

To fix this we provide a different handler for the listener cm_ids
that will defer a work to disable+(re)enable the port which essentially
destroys and setups another listener cm_id

Reported-by: Alex Lyakas <alex@zadara.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- Fix nvmet_rdma_find_get_device wrong cm_id->context dereference

 drivers/nvme/target/rdma.c | 175 +++++++++++++++++++++++++------------
 1 file changed, 119 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9e1b8c61f54e..fd71cfe5c5d6 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
 	struct list_head	queue_list;
 };
 
+struct nvmet_rdma_port {
+	struct nvmet_port	*nport;
+	struct sockaddr_storage addr;
+	struct rdma_cm_id	*cm_id;
+	struct delayed_work	repair_work;
+};
+
 struct nvmet_rdma_device {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
@@ -917,7 +924,8 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 static struct nvmet_rdma_device *
 nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
-	struct nvmet_port *port = cm_id->context;
+	struct nvmet_rdma_port *port = cm_id->context;
+	struct nvmet_port *nport = port->nport;
 	struct nvmet_rdma_device *ndev;
 	int inline_page_count;
 	int inline_sge_count;
@@ -934,17 +942,17 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	if (!ndev)
 		goto out_err;
 
-	inline_page_count = num_pages(port->inline_data_size);
+	inline_page_count = num_pages(nport->inline_data_size);
 	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
 				cm_id->device->attrs.max_recv_sge) - 1;
 	if (inline_page_count > inline_sge_count) {
 		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
-			port->inline_data_size, cm_id->device->name,
+			nport->inline_data_size, cm_id->device->name,
 			inline_sge_count * PAGE_SIZE);
-		port->inline_data_size = inline_sge_count * PAGE_SIZE;
+		nport->inline_data_size = inline_sge_count * PAGE_SIZE;
 		inline_page_count = inline_sge_count;
 	}
-	ndev->inline_data_size = port->inline_data_size;
+	ndev->inline_data_size = nport->inline_data_size;
 	ndev->inline_page_count = inline_page_count;
 	ndev->device = cm_id->device;
 	kref_init(&ndev->ref);
@@ -1272,6 +1280,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
+	struct nvmet_rdma_port *port = cm_id->context;
 	struct nvmet_rdma_device *ndev;
 	struct nvmet_rdma_queue *queue;
 	int ret = -EINVAL;
@@ -1287,7 +1296,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		ret = -ENOMEM;
 		goto put_device;
 	}
-	queue->port = cm_id->context;
+	queue->port = port->nport;
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
@@ -1412,7 +1421,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
 {
-	struct nvmet_port *port;
+	struct nvmet_rdma_port *port;
 
 	if (queue) {
 		/*
@@ -1431,7 +1440,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 	 * cm_id destroy. use atomic xchg to make sure
 	 * we don't compete with remove_port.
 	 */
-	if (xchg(&port->priv, NULL) != cm_id)
+	if (xchg(&port->cm_id, NULL) != cm_id)
 		return 0;
 
 	/*
@@ -1462,6 +1471,13 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		nvmet_rdma_queue_established(queue);
 		break;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
+		if (!queue) {
+			struct nvmet_rdma_port *port = cm_id->context;
+
+			schedule_delayed_work(&port->repair_work, 0);
+			break;
+		}
+		/* FALLTHROUGH */
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		nvmet_rdma_queue_disconnect(queue);
@@ -1504,42 +1520,19 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
 
-static int nvmet_rdma_add_port(struct nvmet_port *port)
+static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
 {
-	struct rdma_cm_id *cm_id;
-	struct sockaddr_storage addr = { };
-	__kernel_sa_family_t af;
-	int ret;
+	struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
 
-	switch (port->disc_addr.adrfam) {
-	case NVMF_ADDR_FAMILY_IP4:
-		af = AF_INET;
-		break;
-	case NVMF_ADDR_FAMILY_IP6:
-		af = AF_INET6;
-		break;
-	default:
-		pr_err("address family %d not supported\n",
-				port->disc_addr.adrfam);
-		return -EINVAL;
-	}
-
-	if (port->inline_data_size < 0) {
-		port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
-	} else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
-		pr_warn("inline_data_size %u is too large, reducing to %u\n",
-			port->inline_data_size,
-			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
-		port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
-	}
+	if (cm_id)
+		rdma_destroy_id(cm_id);
+}
 
-	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
-			port->disc_addr.trsvcid, &addr);
-	if (ret) {
-		pr_err("malformed ip/port passed: %s:%s\n",
-			port->disc_addr.traddr, port->disc_addr.trsvcid);
-		return ret;
-	}
+static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
+{
+	struct sockaddr *addr = (struct sockaddr *)&port->addr;
+	struct rdma_cm_id *cm_id;
+	int ret;
 
 	cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
 			RDMA_PS_TCP, IB_QPT_RC);
@@ -1558,23 +1551,19 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		goto out_destroy_id;
 	}
 
-	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
+	ret = rdma_bind_addr(cm_id, addr);
 	if (ret) {
-		pr_err("binding CM ID to %pISpcs failed (%d)\n",
-			(struct sockaddr *)&addr, ret);
+		pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
 		goto out_destroy_id;
 	}
 
 	ret = rdma_listen(cm_id, 128);
 	if (ret) {
-		pr_err("listening to %pISpcs failed (%d)\n",
-			(struct sockaddr *)&addr, ret);
+		pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
 		goto out_destroy_id;
 	}
 
-	pr_info("enabling port %d (%pISpcs)\n",
-		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
-	port->priv = cm_id;
+	port->cm_id = cm_id;
 	return 0;
 
 out_destroy_id:
@@ -1582,18 +1571,92 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	return ret;
 }
 
-static void nvmet_rdma_remove_port(struct nvmet_port *port)
+static void nvmet_rdma_repair_port_work(struct work_struct *w)
 {
-	struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
+	struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
+			struct nvmet_rdma_port, repair_work);
+	int ret;
 
-	if (cm_id)
-		rdma_destroy_id(cm_id);
+	nvmet_rdma_disable_port(port);
+	ret = nvmet_rdma_enable_port(port);
+	if (ret)
+		schedule_delayed_work(&port->repair_work, 5 * HZ);
+}
+
+static int nvmet_rdma_add_port(struct nvmet_port *nport)
+{
+	struct nvmet_rdma_port *port;
+	__kernel_sa_family_t af;
+	int ret;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	nport->priv = port;
+	port->nport = nport;
+	INIT_DELAYED_WORK(&port->repair_work, nvmet_rdma_repair_port_work);
+
+	switch (nport->disc_addr.adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		af = AF_INET;
+		break;
+	case NVMF_ADDR_FAMILY_IP6:
+		af = AF_INET6;
+		break;
+	default:
+		pr_err("address family %d not supported\n",
+				nport->disc_addr.adrfam);
+		ret = -EINVAL;
+		goto out_free_port;
+	}
+
+	if (nport->inline_data_size < 0) {
+		nport->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
+	} else if (nport->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
+		pr_warn("inline_data_size %u is too large, reducing to %u\n",
+			nport->inline_data_size,
+			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
+		nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
+	}
+
+	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+			nport->disc_addr.trsvcid, &port->addr);
+	if (ret) {
+		pr_err("malformed ip/port passed: %s:%s\n",
+			nport->disc_addr.traddr, nport->disc_addr.trsvcid);
+		goto out_free_port;
+	}
+
+	ret = nvmet_rdma_enable_port(port);
+	if(ret)
+		goto out_free_port;
+
+	pr_info("enabling port %d (%pISpcs)\n",
+		le16_to_cpu(nport->disc_addr.portid),
+		(struct sockaddr *)&port->addr);
+
+	return 0;
+
+out_free_port:
+	kfree(port);
+	return ret;
+}
+
+static void nvmet_rdma_remove_port(struct nvmet_port *nport)
+{
+	struct nvmet_rdma_port *port = nport->priv;
+
+	cancel_delayed_work_sync(&port->repair_work);
+	nvmet_rdma_disable_port(port);
+	kfree(port);
 }
 
 static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
-		struct nvmet_port *port, char *traddr)
+		struct nvmet_port *nport, char *traddr)
 {
-	struct rdma_cm_id *cm_id = port->priv;
+	struct nvmet_rdma_port *port = nport->priv;
+	struct rdma_cm_id *cm_id = port->cm_id;
 
 	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
 		struct nvmet_rdma_rsp *rsp =
@@ -1603,7 +1666,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 
 		sprintf(traddr, "%pISc", addr);
 	} else {
-		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
+		memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
 	}
 }
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
