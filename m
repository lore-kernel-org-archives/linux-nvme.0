Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A3CC388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:20:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D55022202
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/R1LO8p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LY1yBbAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D55022202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D+nQoC1hsrjMu6e65FTxFhTK4SLuInmIZ7TAuE9kuPw=; b=H/R1LO8pHlzKZo0kMppMI6HBTY
	3I40EosTTTXYDgk9UQh51zVYxw9NqHas7IajGgJKtDjMEKpvRNH/kmzzY5DkXvoyNcsDQo74nHAR9
	zzN+mlzmCMcqG+4V7Pxcd5apK3aHuyqLguvFmWi7lIKSwit7eNkwRM7B7bTwaRm0qEv7e/A+riiD/
	myA7JZKO1AFypKTR+MT89+SGb5+uJJxGTUcqswgg6wMKpJv+tG6M7tj4/C809tGGqUyteSklf0DYX
	tB0X7sr8enNWAKKd5Xe1U32IZUnsLIe31upv2ldDFo24szPLudBYrsA+l69MFy6EOWjHOyQEcLbBh
	z00Z1Gpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXNy8-0006ka-Ff; Tue, 27 Oct 2020 12:20:52 +0000
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXNy5-0006jA-4G
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 12:20:50 +0000
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f98109b0001>; Tue, 27 Oct 2020 20:20:43 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 12:20:41 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 12:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzWHcIrG/V/m/j6OEyZJidtOfXLWXH+QG8YEJzBZaEo2PwImJlBwihS2gvjL15UXsyEHoS878JLOz0u8kTJG+Yqk1csYZ/2MMqeM7T58iyyQaZkpAq7e8gJSnlqeVeHOFXGZBlB45hSYaZE7U5X+NCLtLMGQYcbjLku0U64tUtc2sjbMurgBtAEz8IGjTC4KfEMEcN6vJ/1+oh8vcO/v6SLJgvrq2GM/N9RYsA+R21cD7W4Au4Xk54TncguyeUpTmHJ6Sz+I2bRxjjt8zfATFdIyOc49Uup+C0SoMSB3LUN/WdOqMfcmboXu5XTr/OxkXHXdEyzrqQv7WZ7ufngTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXU5dK+Hgyn9y1Tu32kYWiWho/xuv/h7+IEfaXK84qg=;
 b=XcO49eJfMnVZOyNVJCIZbDFfEDMJtYdqaZnMwINJOwWVZ5FNb2eDpVXVv6G5Jc0nB8SxzUTpCqIqVu/zIV6oggXywZYX9VJlji5WYJHx/jmQP0mDFheJTru6vOBawBb4f3mfBduDSnMOb9IoMKw/WJGl31Apej/bSz1NP7Yvz9V3kZLB1zl/eUvAzzumHGDxNto9zelREhVjY0huZpHV6kiDTpC6RT2xOI24zp990u4HzvqIlX7IcJydZjmv9qeAtqzE4glhh44a43A9uCNNql2xP9jqQllPAeQiyVnWhajoo6Qlu/WqsMndeTCc5deJc4Wwir7Klok8OilDnekcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 12:20:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:20:38 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
Date: Tue, 27 Oct 2020 09:20:36 -0300
Message-ID: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:256::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:256::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.11 via Frontend
 Transport; Tue, 27 Oct 2020 12:20:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kXNxs-009IL8-RG; Tue, 27 Oct 2020 09:20:36 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603801243; bh=X+1/YGB7J6D/kEBrmw3op9vkTO4OwW+pyHg15PTEfFQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=LY1yBbAZO3LVre4QuP1SCFITZp0C/zBG3FQcqRWD1cmq2LoaRcJu2DOHIBH+bnqFG
 N14VsjatbeCAScNgHCImhTfeJCcLRqlS61oPTWIc26UVTwz1Er98rhLfZ3Hvl4B4By
 ZdHphUyxbTgsBl4kSDcOlKT4zeT92prCt8LQvKwiY/sH2qSW4KjGP65C3uB7bhcjgK
 s+mErmc8J0OQGnzoXGYrdW3R7l8uMuFbSk5MTYgQJl6CGpCFRDTZQQvNTPnjiRNeBc
 ZcUGFIcuUHPqyjeIJjEli6w/Q0oLPWqcILKbtqhbRZ3opVOICAqQzfsOuJiTA7/6Iz
 1xURETmKlHBWA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_082049_452933_403924B6 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, rds-devel@oss.oracle.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are two flows for handling RDMA_CM_EVENT_ROUTE_RESOLVED, either the
handler triggers a completion and another thread does rdma_connect() or
the handler directly calls rdma_connect().

In all cases rdma_connect() needs to hold the handler_mutex, but when
handler's are invoked this is already held by the core code. This causes
ULPs using the 2nd method to deadlock.

Provide a rdma_connect_locked() and have all ULPs call it from their
handlers.

Link: https://lore.kernel.org/r/0-v1-75e124dbad74+b05-rdma_connect_locking_jgg@nvidia.com
Reported-and-tested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Fixes: 2a7cec538169 ("RDMA/cma: Fix locking for the RDMA_CM_CONNECT state")
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c            | 40 +++++++++++++++++++++---
 drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  4 +--
 drivers/nvme/host/rdma.c                 |  4 +--
 include/rdma/rdma_cm.h                   | 14 ++-------
 net/rds/ib_cm.c                          |  5 +--
 6 files changed, 46 insertions(+), 23 deletions(-)

v2:
 - Remove extra code from nvme (Chao)
 - Fix long lines (CH)

I've applied this version to rdma-rc - expecting to get these ULPs unbroken for rc2
release

Thanks,
Jason

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 7c2ab1f2fbea37..193c8902b9db26 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -405,10 +405,10 @@ static int cma_comp_exch(struct rdma_id_private *id_priv,
 	/*
 	 * The FSM uses a funny double locking where state is protected by both
 	 * the handler_mutex and the spinlock. State is not allowed to change
-	 * away from a handler_mutex protected value without also holding
+	 * to/from a handler_mutex protected value without also holding
 	 * handler_mutex.
 	 */
-	if (comp == RDMA_CM_CONNECT)
+	if (comp == RDMA_CM_CONNECT || exch == RDMA_CM_CONNECT)
 		lockdep_assert_held(&id_priv->handler_mutex);
 
 	spin_lock_irqsave(&id_priv->lock, flags);
@@ -4038,13 +4038,21 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
 	return ret;
 }
 
-int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
+/**
+ * rdma_connect_locked - Initiate an active connection request.
+ * @id: Connection identifier to connect.
+ * @conn_param: Connection information used for connected QPs.
+ *
+ * Same as rdma_connect() but can only be called from the
+ * RDMA_CM_EVENT_ROUTE_RESOLVED handler callback.
+ */
+int rdma_connect_locked(struct rdma_cm_id *id,
+			struct rdma_conn_param *conn_param)
 {
 	struct rdma_id_private *id_priv =
 		container_of(id, struct rdma_id_private, id);
 	int ret;
 
-	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
 		ret = -EINVAL;
 		goto err_unlock;
@@ -4071,6 +4079,30 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 err_state:
 	cma_comp_exch(id_priv, RDMA_CM_CONNECT, RDMA_CM_ROUTE_RESOLVED);
 err_unlock:
+	return ret;
+}
+EXPORT_SYMBOL(rdma_connect_locked);
+
+/**
+ * rdma_connect - Initiate an active connection request.
+ * @id: Connection identifier to connect.
+ * @conn_param: Connection information used for connected QPs.
+ *
+ * Users must have resolved a route for the rdma_cm_id to connect with by having
+ * called rdma_resolve_route before calling this routine.
+ *
+ * This call will either connect to a remote QP or obtain remote QP information
+ * for unconnected rdma_cm_id's.  The actual operation is based on the
+ * rdma_cm_id's port space.
+ */
+int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	int ret;
+
+	mutex_lock(&id_priv->handler_mutex);
+	ret = rdma_connect_locked(id, conn_param);
 	mutex_unlock(&id_priv->handler_mutex);
 	return ret;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 2f3ebc0a75d924..2bd18b00689341 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -620,7 +620,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 	conn_param.private_data	= (void *)&req_hdr;
 	conn_param.private_data_len = sizeof(struct iser_cm_hdr);
 
-	ret = rdma_connect(cma_id, &conn_param);
+	ret = rdma_connect_locked(cma_id, &conn_param);
 	if (ret) {
 		iser_err("failure connecting: %d\n", ret);
 		goto failure;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 776e89231c52f7..f298adc02acba2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1674,9 +1674,9 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
 	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
 
-	err = rdma_connect(con->c.cm_id, &param);
+	err = rdma_connect_locked(con->c.cm_id, &param);
 	if (err)
-		rtrs_err(clt, "rdma_connect(): %d\n", err);
+		rtrs_err(clt, "rdma_connect_locked(): %d\n", err);
 
 	return err;
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index aad829a2b50d0f..8bbc48cc45dc1d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1890,10 +1890,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
 
-	ret = rdma_connect(queue->cm_id, &param);
+	ret = rdma_connect_locked(queue->cm_id, &param);
 	if (ret) {
 		dev_err(ctrl->ctrl.device,
-			"rdma_connect failed (%d).\n", ret);
+			"rdma_connect_locked failed (%d).\n", ret);
 		goto out_destroy_queue_ib;
 	}
 
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index c672ae1da26bb5..32a67af18415d6 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -227,19 +227,9 @@ void rdma_destroy_qp(struct rdma_cm_id *id);
 int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 		       int *qp_attr_mask);
 
-/**
- * rdma_connect - Initiate an active connection request.
- * @id: Connection identifier to connect.
- * @conn_param: Connection information used for connected QPs.
- *
- * Users must have resolved a route for the rdma_cm_id to connect with
- * by having called rdma_resolve_route before calling this routine.
- *
- * This call will either connect to a remote QP or obtain remote QP
- * information for unconnected rdma_cm_id's.  The actual operation is
- * based on the rdma_cm_id's port space.
- */
 int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
+int rdma_connect_locked(struct rdma_cm_id *id,
+			struct rdma_conn_param *conn_param);
 
 int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 		     struct rdma_ucm_ece *ece);
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 06603dd1c8aa38..b36b60668b1da9 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -956,9 +956,10 @@ int rds_ib_cm_initiate_connect(struct rdma_cm_id *cm_id, bool isv6)
 	rds_ib_cm_fill_conn_param(conn, &conn_param, &dp,
 				  conn->c_proposed_version,
 				  UINT_MAX, UINT_MAX, isv6);
-	ret = rdma_connect(cm_id, &conn_param);
+	ret = rdma_connect_locked(cm_id, &conn_param);
 	if (ret)
-		rds_ib_conn_error(conn, "rdma_connect failed (%d)\n", ret);
+		rds_ib_conn_error(conn, "rdma_connect_locked failed (%d)\n",
+				  ret);
 
 out:
 	/* Beware - returning non-zero tells the rdma_cm to destroy
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
