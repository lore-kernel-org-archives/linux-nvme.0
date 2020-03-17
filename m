Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EFAC18E5B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583F520770
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4GvxqVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583F520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inxHJTc2UO2uf7xGBjXDNe7gmI3avK0TYx7rYkhtfzs=; b=m4GvxqVZFLhokB
	A4zQqf3wfI0Dwjjb96RY8wTuoCMNUGUrqbBVvOSVYviTNHu9tWciE79hh5ApdDeB3/tptVbWb76tJ
	jbR5mT+3TXtGlPC+5A+28iZXaYW4/idI7irx0df0d7H8iaVx7J7YxQpTv4myGWqOhyFCPKETin3Yh
	z0ySI2/BkV+cUAEqr+mJj2pPhiI52FT/LMIZj3npZ0kSJJcImFfA6d/9yRX1KQkaFoxwm3xE137ho
	ffjJouomAmXYwwPxbCkXN0Jm9JOEdSVOdJB8EMQ5GfcXahuqepfk/KFlwYcbuQIcCnNTjN9cMitwf
	OdP/xXHbIDZCPFQgB3HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jECTe-0001qF-DA; Tue, 17 Mar 2020 13:41:50 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jECSU-0000a9-0S
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 13:41:00 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 17 Mar 2020 15:40:30 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02HDeUhc028750;
 Tue, 17 Mar 2020 15:40:30 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Date: Tue, 17 Mar 2020 15:40:26 +0200
Message-Id: <20200317134030.152833-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317134030.152833-1-maxg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_064047_308483_F2C00052 
X-CRM114-Status: GOOD (  13.52  )
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

ULP's can use this API to create/destroy SRQ's with the same
characteristics for implementing a logic that aimed to save resources
without significant performance penalty (e.g. create SRQ per completion
vector and use shared receive buffers for multiple controllers of the
ULP).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/Makefile  |  2 +-
 drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/verbs.c   |  4 ++
 include/rdma/ib_verbs.h           |  5 +++
 include/rdma/srq_set.h            | 18 +++++++++
 5 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/core/srq_set.c
 create mode 100644 include/rdma/srq_set.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d1b14887..1d3eaec 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o
+				trace.o srq_set.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/srq_set.c b/drivers/infiniband/core/srq_set.c
new file mode 100644
index 0000000..d143561
--- /dev/null
+++ b/drivers/infiniband/core/srq_set.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#include <rdma/srq_set.h>
+
+struct ib_srq *rdma_srq_get(struct ib_pd *pd)
+{
+	struct ib_srq *srq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	srq = list_first_entry_or_null(&pd->srqs, struct ib_srq, pd_entry);
+	if (srq) {
+		list_del(&srq->pd_entry);
+		pd->srqs_used++;
+	}
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+
+	return srq;
+}
+EXPORT_SYMBOL(rdma_srq_get);
+
+void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd->srq_lock, flags);
+	list_add(&srq->pd_entry, &pd->srqs);
+	pd->srqs_used--;
+	spin_unlock_irqrestore(&pd->srq_lock, flags);
+}
+EXPORT_SYMBOL(rdma_srq_put);
+
+int rdma_srq_set_init(struct ib_pd *pd, int nr,
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
+	rdma_srq_set_destroy(pd);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_srq_set_init);
+
+void rdma_srq_set_destroy(struct ib_pd *pd)
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
+EXPORT_SYMBOL(rdma_srq_set_destroy);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e62c9df..6950abf 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -272,6 +272,9 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
+	pd->srqs_used = 0;
+	spin_lock_init(&pd->srq_lock);
+	INIT_LIST_HEAD(&pd->srqs);
 
 	pd->res.type = RDMA_RESTRACK_PD;
 	rdma_restrack_set_task(&pd->res, caller);
@@ -340,6 +343,7 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 		pd->__internal_mr = NULL;
 	}
 
+	WARN_ON_ONCE(pd->srqs_used > 0);
 	/* uverbs manipulates usecnt with proper locking, while the kabi
 	   requires the caller to guarantee we can't race here. */
 	WARN_ON(atomic_read(&pd->usecnt));
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1f779fa..fc8207d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1517,6 +1517,10 @@ struct ib_pd {
 
 	u32			unsafe_global_rkey;
 
+	spinlock_t		srq_lock;
+	int			srqs_used;
+	struct list_head	srqs;
+
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -1585,6 +1589,7 @@ struct ib_srq {
 	void		       *srq_context;
 	enum ib_srq_type	srq_type;
 	atomic_t		usecnt;
+	struct list_head	pd_entry; /* srq set entry */
 
 	struct {
 		struct ib_cq   *cq;
diff --git a/include/rdma/srq_set.h b/include/rdma/srq_set.h
new file mode 100644
index 0000000..834c4c6
--- /dev/null
+++ b/include/rdma/srq_set.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef _RDMA_SRQ_SET_H
+#define _RDMA_SRQ_SET_H 1
+
+#include <rdma/ib_verbs.h>
+
+struct ib_srq *rdma_srq_get(struct ib_pd *pd);
+void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);
+
+int rdma_srq_set_init(struct ib_pd *pd, int nr,
+		struct ib_srq_init_attr *srq_attr);
+void rdma_srq_set_destroy(struct ib_pd *pd);
+
+#endif /* _RDMA_SRQ_SET_H */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
