Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E4AC5ACD7
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E997D20757
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WTDyuhBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E997D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9360zZi+zTru2REGwKbLtXKXD98zD6OGZpB6Ghi3ks=; b=WTDyuhBQXenDWs
	5zOE5NuaayoANXHmQ9+169eU+GwRnw9AF77LvYx4PN/gcLMnpZLoOysHs1VnTAQu19Uh6vTruRpx7
	W4H+LqABML9b1Wf/G4Ck9eKi43oxlOpQm98kl0+XSRWh/qOlwLfg/LWZlc2ZECmFBx3wWAHYdYucm
	/JYefpqDvMQ2f1i7jKtchfkO3oze/Zzl6g5/ReaiHiYRMryuIehqfNCIz2rkKfkfc9aqTrkHU9LaS
	9WuW0amDRa/+SsV+NAQB3Dl1xSn7mfBfOyt5+4vZuLQG3dZZqaqVtPfbkUnq9PpJRVjhA3J44xbwP
	dC94ys6ygHt3j8NaZPlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEaDx-00022m-OT; Wed, 18 Mar 2020 15:03:13 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEaDp-0001wI-P1
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 15:03:09 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEO008733;
 Wed, 18 Mar 2020 17:02:57 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH v2 4/5] RDMA/srpt: use ib_alloc_cq instead of ib_alloc_cq_any
Date: Wed, 18 Mar 2020 17:02:56 +0200
Message-Id: <20200318150257.198402-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_080306_239420_394F3DEE 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, shlomin@mellanox.com,
 leonro@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For spreading the completion vectors fairly, add global ida for RDMA
channeles and use ida_simple_{get,remove} API. This is a preparation
for the SRQ per core feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 21 +++++++++++++++++----
 drivers/infiniband/ulp/srpt/ib_srpt.h |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9855274..d0294d8 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -89,6 +89,8 @@ static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
 		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
 
 static struct ib_client srpt_client;
+/* Will be used to allocate an index for srpt_rdma_ch. */
+static DEFINE_IDA(srpt_channel_ida);
 /* Protects both rdma_cm_port and rdma_cm_id. */
 static DEFINE_MUTEX(rdma_cm_mutex);
 /* Port number RDMA/CM will bind to. */
@@ -1779,7 +1781,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	struct srpt_device *sdev = sport->sdev;
 	const struct ib_device_attr *attrs = &sdev->device->attrs;
 	int sq_size = sport->port_attrib.srp_sq_size;
-	int i, ret;
+	int i, ret, comp_vector;
 
 	WARN_ON(ch->rq_size < 1);
 
@@ -1788,9 +1790,11 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	if (!qp_init)
 		goto out;
 
+	 /* Spread the io channeles across completion vectors */
+	comp_vector = ch->idx % sdev->device->num_comp_vectors;
 retry:
-	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
-				 IB_POLL_WORKQUEUE);
+	ch->cq = ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
+			     comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(ch->cq)) {
 		ret = PTR_ERR(ch->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -2119,6 +2123,8 @@ static void srpt_release_channel_work(struct work_struct *w)
 
 	kmem_cache_destroy(ch->req_buf_cache);
 
+	ida_simple_remove(&srpt_channel_ida, ch->idx);
+
 	kref_put(&ch->kref, srpt_free_ch);
 }
 
@@ -2215,6 +2221,10 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		goto reject;
 	}
 
+	ch->idx = ida_simple_get(&srpt_channel_ida, 0, 0, GFP_KERNEL);
+	if (ch->idx < 0)
+		goto free_ch;
+
 	kref_init(&ch->kref);
 	ch->pkey = be16_to_cpu(pkey);
 	ch->nexus = nexus;
@@ -2243,7 +2253,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
 					      512, 0, NULL);
 	if (!ch->rsp_buf_cache)
-		goto free_ch;
+		goto free_idx;
 
 	ch->ioctx_ring = (struct srpt_send_ioctx **)
 		srpt_alloc_ioctx_ring(ch->sport->sdev, ch->rq_size,
@@ -2478,6 +2488,8 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 free_rsp_cache:
 	kmem_cache_destroy(ch->rsp_buf_cache);
 
+free_idx:
+	ida_simple_remove(&srpt_channel_ida, ch->idx);
 free_ch:
 	if (rdma_cm_id)
 		rdma_cm_id->context = NULL;
@@ -3916,6 +3928,7 @@ static void __exit srpt_cleanup_module(void)
 		rdma_destroy_id(rdma_cm_id);
 	ib_unregister_client(&srpt_client);
 	target_unregister_template(&srpt_template);
+	ida_destroy(&srpt_channel_ida);
 }
 
 module_init(srpt_init_module);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 2e1a698..5c40653 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -292,6 +292,7 @@ enum rdma_ch_state {
  * @sess:          Session information associated with this SRP channel.
  * @sess_name:     Session name.
  * @release_work:  Allows scheduling of srpt_release_channel().
+ * @idx:           channel index.
  */
 struct srpt_rdma_ch {
 	struct srpt_nexus	*nexus;
@@ -331,6 +332,7 @@ struct srpt_rdma_ch {
 	struct se_session	*sess;
 	u8			sess_name[40];
 	struct work_struct	release_work;
+	int			idx;
 };
 
 /**
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
