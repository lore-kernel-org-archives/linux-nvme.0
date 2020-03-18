Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF51C10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 16:15:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D255D20663
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/Eh7aqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D255D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fwQR3KjienyryecmzJ3mWfiyZbBa+diIUcdcX2rdToY=; b=P/Eh7aqgq9WZ1J
	W2JLSl0FlCvs8mk/Srf5hAXkPQBSgLkmCUWy3FN2y3t4QOALmuhBIXKDS+C6RWdb6LGtgEqWQObCv
	ZRDfrECsyq9/fhWpWvNBMTswO2K0zeKIPcjBwNOWcWcEecdpdyREz6xhM5apLWHIBuZla3JcOzTD2
	T25cOTiLZmviJH4nPyuk8eQvTcPOpV0ff1rjc7IdWqBpQTB7TYQir7HyUOXGrcKIsu31EG3zXNSov
	8OLrp9OT7+ktccBXnM58gzwMX4HxTkFSIUkiQy2hL/vZ9rF8CdKe6Pti7HcGELqc0OUgyIesLYdRy
	GBH0zI0GvYPWM0kFN4sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEbM3-0006PG-VS; Wed, 18 Mar 2020 16:15:39 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEaDp-0001wE-Oy
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 15:03:09 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEL008733;
 Wed, 18 Mar 2020 17:02:57 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
Date: Wed, 18 Mar 2020 17:02:53 +0200
Message-Id: <20200318150257.198402-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_080306_243510_96EA64CF 
X-CRM114-Status: GOOD (  13.48  )
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

ULP's can use this API to create/destroy SRQ's with the same
characteristics for implementing a logic that aimed to save resources
without significant performance penalty (e.g. create SRQ per completion
vector and use shared receive buffers for multiple controllers of the
ULP).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/Makefile   |  2 +-
 drivers/infiniband/core/srq_pool.c | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/verbs.c    |  3 ++
 include/rdma/ib_verbs.h            |  4 ++
 include/rdma/srq_pool.h            | 18 +++++++++
 5 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/core/srq_pool.c
 create mode 100644 include/rdma/srq_pool.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d1b14887..ca377b0 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o
+				trace.o srq_pool.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/srq_pool.c b/drivers/infiniband/core/srq_pool.c
new file mode 100644
index 0000000..68321f0
--- /dev/null
+++ b/drivers/infiniband/core/srq_pool.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#include <rdma/srq_pool.h>
+
+struct ib_srq *rdma_srq_pool_get(struct ib_pd *pd)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	srq = list_first_entry_or_null(&pd->srqs, struct ib_srq, pd_entry);
+	if (srq)
+		list_del(&srq->pd_entry);
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+
+	return srq;
+}
+EXPORT_SYMBOL(rdma_srq_pool_get);
+
+void rdma_srq_pool_put(struct ib_pd *pd, struct ib_srq *srq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	list_add(&srq->pd_entry, &pd->srqs);
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+}
+EXPORT_SYMBOL(rdma_srq_pool_put);
+
+int rdma_srq_pool_init(struct ib_pd *pd, int nr,
+		struct ib_srq_init_attr *srq_attr)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+	int ret, i;
+
+	for (i = 0; i < nr; i++) {
+		srq = ib_create_srq(pd, srq_attr);
+		if (IS_ERR(srq)) {
+			ret = PTR_ERR(srq);
+			goto out;
+		}
+
+		spin_lock_irqsave(&pd->srq_lock, flags);
+		list_add_tail(&srq->pd_entry, &pd->srqs);
+		spin_unlock_irqrestore(&pd->srq_lock, flags);
+	}
+
+	return 0;
+out:
+	rdma_srq_pool_destroy(pd);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_srq_pool_init);
+
+void rdma_srq_pool_destroy(struct ib_pd *pd)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	while (!list_empty(&pd->srqs)) {
+		srq = list_first_entry(&pd->srqs, struct ib_srq, pd_entry);
+		list_del(&srq->pd_entry);
+
+		spin_unlock_irqrestore(&pd->srq_lock, flags);
+		ib_destroy_srq(srq);
+		spin_lock_irqsave(&pd->srq_lock, flags);
+	}
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+}
+EXPORT_SYMBOL(rdma_srq_pool_destroy);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e62c9df..0bb69d2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -272,6 +272,8 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
+	spin_lock_init(&pd->srq_lock);
+	INIT_LIST_HEAD(&pd->srqs);
 
 	pd->res.type = RDMA_RESTRACK_PD;
 	rdma_restrack_set_task(&pd->res, caller);
@@ -340,6 +342,7 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 		pd->__internal_mr = NULL;
 	}
 
+	WARN_ON_ONCE(!list_empty(&pd->srqs));
 	/* uverbs manipulates usecnt with proper locking, while the kabi
 	   requires the caller to guarantee we can't race here. */
 	WARN_ON(atomic_read(&pd->usecnt));
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1f779fa..1dcfefb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1517,6 +1517,9 @@ struct ib_pd {
 
 	u32			unsafe_global_rkey;
 
+	spinlock_t		srq_lock;
+	struct list_head	srqs;
+
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -1585,6 +1588,7 @@ struct ib_srq {
 	void		       *srq_context;
 	enum ib_srq_type	srq_type;
 	atomic_t		usecnt;
+	struct list_head	pd_entry; /* srq pool entry */
 
 	struct {
 		struct ib_cq   *cq;
diff --git a/include/rdma/srq_pool.h b/include/rdma/srq_pool.h
new file mode 100644
index 0000000..ee83896
--- /dev/null
+++ b/include/rdma/srq_pool.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef _RDMA_SRQ_POOL_H
+#define _RDMA_SRQ_POOL_H
+
+#include <rdma/ib_verbs.h>
+
+struct ib_srq *rdma_srq_pool_get(struct ib_pd *pd);
+void rdma_srq_pool_put(struct ib_pd *pd, struct ib_srq *srq);
+
+int rdma_srq_pool_init(struct ib_pd *pd, int nr,
+		struct ib_srq_init_attr *srq_attr);
+void rdma_srq_pool_destroy(struct ib_pd *pd);
+
+#endif /* _RDMA_SRQ_POOL_H */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
