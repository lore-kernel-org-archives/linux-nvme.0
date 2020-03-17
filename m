Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BDC18E5B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:42:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF4E20770
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mWf/swZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF4E20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8yJYnnGzHBEFrrQu68Xx+txjVjH5sX8cUX4n48wDQL8=; b=mWf/swZiIjZHl+
	Xj/BxBFgSCZiuDUdvhiXSFppNPWwYOaOygALOjc42sPB4atiao1Bb1jU1lDvktWxzK/YTLpFxwoKk
	42W9DziLNqs9sk1bk0ZSHqUUysqKPGHVYJRvIZyhHx6CryFb8laF7GzFEkXrcv8XqGerJZJHNNdwd
	B0rmPWXOS7WhYrb08EVuKDOyFE3Ur2+8Lt3Xbhbn4aPdAihT3tEkZP9/tveqVJ8jnUlIL/vXt+tuf
	Zy3HGpldhfJI+isZyh0Iuw9/o5fJBnq5hrmNexKHzeFrJ/TjeZzJBi8gLs5aqFNaGZLHxxMJx1dgx
	hfXPiTZc5gnATKv5IFJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jECTr-0002Jq-Mo; Tue, 17 Mar 2020 13:42:03 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jECSU-0000a6-0Q
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 13:41:01 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 17 Mar 2020 15:40:31 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02HDeUhf028750;
 Tue, 17 Mar 2020 15:40:30 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH 4/5] IB/core: cache the CQ completion vector
Date: Tue, 17 Mar 2020 15:40:29 +0200
Message-Id: <20200317134030.152833-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317134030.152833-1-maxg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_064047_318677_E875E048 
X-CRM114-Status: UNSURE (   7.18  )
X-CRM114-Notice: Please train this message.
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, leonro@mellanox.com,
 dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In some cases, e.g. when using ib_alloc_cq_any, one would like to know
the completion vector that eventually assigned to the CQ. Cache this
value during CQ creation.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/cq.c | 1 +
 include/rdma/ib_verbs.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 4f25b24..a7cbf52 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	cq->device = dev;
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
+	cq->comp_vector = comp_vector;
 	atomic_set(&cq->usecnt, 0);
 
 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fc8207d..0d61772 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1558,6 +1558,7 @@ struct ib_cq {
 	struct ib_device       *device;
 	struct ib_ucq_object   *uobject;
 	ib_comp_handler   	comp_handler;
+	u32			comp_vector;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void                   *cq_context;
 	int               	cqe;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
