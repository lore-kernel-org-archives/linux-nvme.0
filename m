Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE4DC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1ncdfDQWE4P6NcsA18IrDBPpPhaFipRonet0wR5l3U=; b=3JKGXYbqxl8wDUt7GaSEcpLdk6
	xcjmKcIwN5AjtrbvhXeVm2tJIKmsMmA+8SwsQ232mjZLNp+P+u/45ztu1ErE2RxDHpTwIB60xsB1M
	zdVYYnKgkHCRd/Ty+DVAO6zVB8SHNPt05/h/JZoiwpKVaDJW3gWMGQjuoM62hhlFD6ASH5MdcahaK
	kzyUhZe784nSZT10+sepjJacYgdFK4EgOAfw3PFsumaVPQ7j+whhvg7kfX9mDDiixu6cMBt0bWokV
	xWramROnORywx9CoEU/g7jn0Rnq7zJ9HdaPMLM0N3i/qCewtxdoOXr0huudArZMOwgTkeiupgrPjB
	ORoYpziw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Nc-0000000AM6x-47aF;
	Wed, 03 Jul 2024 13:50:40 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NY-0000000AM4o-3zVy
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 13:50:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5D303CE2AFB;
	Wed,  3 Jul 2024 13:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8FEC2BD10;
	Wed,  3 Jul 2024 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014634;
	bh=w64diJWH7OBQnWXzlQGsr0dej1DX2vbCILOwOi8Wi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IM+rPpKqeRp4I6lA/KWMMy8gKrtlCPjUHRavt/MBMg28XRSfCtKEaupDMjozENall
	 kn8QAx67uPn2dMewVPlivttyu1GRJJr0XOprw5K15JYSh+xocZ0grlX7q7K1BGfC3q
	 ISyrGZXWXxJGNYVHZfStQaAq64MJSEje6khKXVOv8qYbN9Y1JVOjhJ4HVXgyglblP5
	 p7SuAYB+mjn4EMDgvY+lZxVgLKnZPVdF5j3oJuLQoL8Uh0GO5IpdFja4AfPySQDpGt
	 R42szRxsrUV6tc92VebhxFqMOoEK9PqCmBGY9Mo6t+0s20jW1PfxUnUFJH8oDqJn1a
	 +MYox5K+kSgCw==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] workqueue: introduce helper workqueue_unbound_affinity_scope()
Date: Wed,  3 Jul 2024 15:50:20 +0200
Message-Id: <20240703135021.34143-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240703135021.34143-1-hare@kernel.org>
References: <20240703135021.34143-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_065037_432027_FF335098 
X-CRM114-Status: GOOD (  17.36  )
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

For drivers creating their own workqueue it might be useful to
switch to the 'cpu' unbound affinity scope to keep the locality
and reduce contention. As it's cumbersome to instruct the user
how to switch to affinity scope from userland introduce a helper
workqueue_unbound_affinity_scope() to let the driver set the
affinity scope directly.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 47 +++++++++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb3993894536..6c5f3dc614d9 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -541,6 +541,7 @@ void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
 extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
+extern int workqueue_unbound_affinity_scope(struct workqueue_struct *wq, int scope);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d..53b1ca11fc86 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7143,26 +7143,55 @@ static ssize_t wq_affn_scope_show(struct device *dev,
 	return written;
 }
 
-static ssize_t wq_affn_scope_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+int workqueue_unbound_affinity_scope(struct workqueue_struct *wq, int scope)
 {
-	struct workqueue_struct *wq = dev_to_wq(dev);
 	struct workqueue_attrs *attrs;
-	int affn, ret = -ENOMEM;
+	int ret = -ENOMEM;;
 
-	affn = parse_affn_scope(buf);
-	if (affn < 0)
-		return affn;
+	if (!(wq->flags & WQ_UNBOUND))
+		return -EINVAL;
+
+	switch(scope) {
+	case WQ_AFFN_DFL:
+		/* fallthrough */
+	case WQ_AFFN_CPU:
+		/* fallthrough */
+	case WQ_AFFN_SMT:
+		/* fallthrough */
+	case WQ_AFFN_CACHE:
+		/* fallthrough */
+	case WQ_AFFN_NUMA:
+		/* fallthrough */
+	case WQ_AFFN_SYSTEM:
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	apply_wqattrs_lock();
 	attrs = wq_sysfs_prep_attrs(wq);
 	if (attrs) {
-		attrs->affn_scope = affn;
+		attrs->affn_scope = scope;
 		ret = apply_workqueue_attrs_locked(wq, attrs);
 	}
 	apply_wqattrs_unlock();
 	free_workqueue_attrs(attrs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(workqueue_unbound_affinity_scope);
+
+static ssize_t wq_affn_scope_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+	int affn, ret = -ENOMEM;
+
+	affn = parse_affn_scope(buf);
+	if (affn < 0)
+		return affn;
+
+	ret = workqueue_unbound_affinity_scope(wq, affn);
 	return ret ?: count;
 }
 
-- 
2.35.3


