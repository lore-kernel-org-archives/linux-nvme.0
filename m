Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAEDC4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 09:14:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D47220848
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPXQNl2H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD0XGSr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D47220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gDupuE+rfs9ZNdlsj67DWhVQP+Y7VSv2AIxCnCwFdKY=; b=MPXQNl2H+p/rpPmyG9dCw4RVH
	eRrjSMaRqET2ynZjwIyH2n9e0+tIVclIudWCMe/Bt1IZ+zN26xkIMxlezeN3Trw9+aDT3ev5BULUC
	LQ0e3ibsNxU0u5PhykZyrY0ZXosXQYzzON/mOyZFLqB4M8rTSCw3yCUPVNk0+xkYwg626doV7nK7x
	gBvBUs2bIp1DG9g5B8utUIVQQ9iqgWti0P5fdicJ2cwcDEAWNNbdHElCq1TaiuxbLU7BUnvBXyJCH
	4cCv5rW1ZoT1WWB8Ey5U1U/yqp3hINZWWcn5pEZy2kIFST7zqLINuwsyNCZvZr6CNfdfjuzOtt2Af
	qDLwswlpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBii-0001zq-8r; Tue, 29 Sep 2020 09:14:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBi7-0001fT-5I
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 09:14:13 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60F592076B;
 Tue, 29 Sep 2020 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601370849;
 bh=5E3slNjRuvNNMcxv/TURB1ODurtLk+FxpM6WF84I9eM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eD0XGSr3+0Agd6IUm1AK+1BjhSo7o0PQKkrFwt17Xi02vAO34ojq6cXvCocqySYjD
 583ZL3/PRW5KZMCJTXag9M6FFW0boQcOm0a9YzWq1j+KYkgvELur+nM9gCbkaoaO1F
 ibMAgZmc/jakTD35Jh/eDJht3SykRDQvYIpn7IeY=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH blk-next 2/2] RDMA/core: Delete not-implemented
 get_vector_affinity
Date: Tue, 29 Sep 2020 12:13:58 +0300
Message-Id: <20200929091358.421086-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929091358.421086-1-leon@kernel.org>
References: <20200929091358.421086-1-leon@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_051411_482264_11FCA8A1 
X-CRM114-Status: GOOD (  13.26  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Leon Romanovsky <leonro@nvidia.com>

There are no drivers that support .get_vector_affinity(), so delete it.

Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c |  1 -
 include/rdma/ib_verbs.h          | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 417d93bbdaca..e00ce044555d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2619,7 +2619,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_link_layer);
 	SET_DEVICE_OP(dev_ops, get_netdev);
 	SET_DEVICE_OP(dev_ops, get_port_immutable);
-	SET_DEVICE_OP(dev_ops, get_vector_affinity);
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_guid);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7fb09a36b654..b1b279d888f0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2319,8 +2319,6 @@ struct ib_device_ops {
 	int (*modify_device)(struct ib_device *device, int device_modify_mask,
 			     struct ib_device_modify *device_modify);
 	void (*get_dev_fw_str)(struct ib_device *device, char *str);
-	const struct cpumask *(*get_vector_affinity)(struct ib_device *ibdev,
-						     int comp_vector);
 	int (*query_port)(struct ib_device *device, u8 port_num,
 			  struct ib_port_attr *port_attr);
 	int (*modify_port)(struct ib_device *device, u8 port_num,
@@ -4545,27 +4543,6 @@ static inline __be16 ib_lid_be16(u32 lid)
 	return cpu_to_be16((u16)lid);
 }

-/**
- * ib_get_vector_affinity - Get the affinity mappings of a given completion
- *   vector
- * @device:         the rdma device
- * @comp_vector:    index of completion vector
- *
- * Returns NULL on failure, otherwise a corresponding cpu map of the
- * completion vector (returns all-cpus map if the device driver doesn't
- * implement get_vector_affinity).
- */
-static inline const struct cpumask *
-ib_get_vector_affinity(struct ib_device *device, int comp_vector)
-{
-	if (comp_vector < 0 || comp_vector >= device->num_comp_vectors ||
-	    !device->ops.get_vector_affinity)
-		return NULL;
-
-	return device->ops.get_vector_affinity(device, comp_vector);
-
-}
-
 /**
  * rdma_roce_rescan_device - Rescan all of the network devices in the system
  * and add their gids, as needed, to the relevant RoCE devices.
--
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
