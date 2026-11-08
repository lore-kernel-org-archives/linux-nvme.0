Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D57606D802
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mnRg+rCE;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Mnlefwgu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bMHACPgIcWPaET06xon/DoA1r+E9zH8ZH5JoC35wPb0=; b=mnRg+rCEctHCUi
	mts3Ap5uuLCxLbq3DQMm6gtdSQh5BWUu7Px74kRNv7WnAApz8OfSBa8JhmBvyS6K19uOSwe335WTJ
	auwQXg5wp3wh+a2V6cqR+oDx38p0Gyr9qrQJBFGwHcmpIYRiUxKdSTIr2ialsFWlFV4Rl836iU+qd
	WuVQ+e7BNk8YLKX/GulbZjxc+lfAl7pla3KnZ6hbSD8XizcMbF13GJsbUh/7qZlSlRcDGstA4bMuT
	LXgNFgK0DJNfrzFlzQiAxuknvKz3BN6tvLwWRjPl0LqIF4SyJ7rdR0P9WCB0+C3DbrMf98et2c0a8
	HvA3lDrtcOMVWfknAA0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o8-0000000GbsG-2kov;
	Sun, 08 Nov 2026 20:48:08 +0000
Received: from out-56.mta1.migadu.com ([95.215.58.56] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9o4-0000000GblM-3KyU
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:06 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=O/+RShHRlHw9LWvz4LZwZOeY2xmJPMvSVtw2UUCaH8c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170883; v=1; x=1794775683;
 b=Mnlefwgutgn3nBRGYNuhulDjLCLe5fgqnR+CqBTGxAXcwEYealkGZzb6mD9EvFHnF1L9nhBV
 AFs+TsbRbJI1f6eQ9QJupp/g7fVb5NM7m/DmDlmxu7XLvnfl1q+F/2XAB685caKlgxIXuNeKEOM
 wgQ2NLiLJge09vG7x1fh5wQk=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id d1882979d78c9bce;
	Sun, 08 Nov 2026 20:48:03 +0000
X-Mizu-Trace-ID: d1882979d78c9bce
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 08/29] libmultipath: Add sysfs helpers
Date: Sun,  8 Nov 2026 20:47:12 +0000
Message-ID: <20261108204733.557995-9-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124804_994160_374A4AA5 
X-CRM114-Status: GOOD (  14.22  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add helpers for driver sysfs code for the following functionality:
- get/set iopolicy with mpath_iopolicy_store() and mpath_iopolicy_show()
- show device path per NUMA node
- "multipath" attribute group, equivalent to nvme_ns_mpath_attr_group
- device groups attribute array, similar to nvme_ns_attr_groups but not
  containing NVMe members.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 include/linux/multipath.h |  5 +++
 lib/multipath.c           | 94 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/multipath.h b/include/linux/multipath.h
index 66b6ad9c2219..7a3708ff3725 100644
--- a/include/linux/multipath.h
+++ b/include/linux/multipath.h
@@ -7,6 +7,8 @@
 #include <linux/srcu.h>
 
 extern const struct block_device_operations mpath_ops;
+extern const struct attribute_group mpath_attr_group;
+extern const struct attribute_group *mpath_device_groups[];
 
 enum mpath_iopolicy_e {
 	MPATH_IOPOLICY_NUMA,
@@ -118,6 +120,9 @@ int mpath_alloc_head_disk(struct mpath_head *mpath_head,
 			struct queue_limits *lim, int numa_node);
 void mpath_device_set_live(struct mpath_device *mpath_device);
 bool mpath_can_remove_head(struct mpath_head *mpath_head);
+ssize_t mpath_numa_nodes_show(struct mpath_device *mpath_device, char *buf);
+ssize_t mpath_iopolicy_show(enum mpath_iopolicy_e *iopolicy, char *buf);
+bool mpath_iopolicy_store(enum mpath_iopolicy_e *iopolicy, const char *buf);
 ssize_t mpath_delayed_removal_secs_show(struct mpath_head *mpath_head,
 			char *buf);
 ssize_t mpath_delayed_removal_secs_store(struct mpath_head *mpath_head,
diff --git a/lib/multipath.c b/lib/multipath.c
index cdf8fbc5105b..ae5a73d570b3 100644
--- a/lib/multipath.c
+++ b/lib/multipath.c
@@ -620,6 +620,100 @@ void mpath_device_set_live(struct mpath_device *mpath_device)
 }
 EXPORT_SYMBOL_GPL(mpath_device_set_live);
 
+static struct attribute dummy_attr = {
+	.name = "dummy",
+};
+
+static struct attribute *mpath_attrs[] = {
+	&dummy_attr,
+	NULL
+};
+
+static bool multipath_sysfs_group_visible(struct kobject *kobj)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return is_mpath_disk(disk);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(multipath_sysfs)
+
+const struct attribute_group mpath_attr_group = {
+	.name           = "multipath",
+	.attrs		= mpath_attrs,
+	.is_visible     = SYSFS_GROUP_VISIBLE(multipath_sysfs),
+};
+EXPORT_SYMBOL_GPL(mpath_attr_group);
+
+const struct attribute_group *mpath_device_groups[] = {
+	&mpath_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(mpath_device_groups);
+
+ssize_t mpath_iopolicy_show(enum mpath_iopolicy_e *iopolicy, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+		mpath_iopolicy_names[READ_ONCE(*iopolicy)]);
+}
+EXPORT_SYMBOL_GPL(mpath_iopolicy_show);
+
+static void mpath_iopolicy_update(enum mpath_iopolicy_e *iopolicy,
+		int new)
+{
+	int old = READ_ONCE(*iopolicy);
+
+	if (old == new)
+		return;
+
+	WRITE_ONCE(*iopolicy, new);
+
+	pr_info("iopolicy changed from %s to %s\n",
+		mpath_iopolicy_names[old],
+		mpath_iopolicy_names[new]);
+}
+
+bool mpath_iopolicy_store(enum mpath_iopolicy_e *iopolicy, const char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mpath_iopolicy_names); i++) {
+		if (sysfs_streq(buf, mpath_iopolicy_names[i])) {
+			mpath_iopolicy_update(iopolicy, i);
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mpath_iopolicy_store);
+
+ssize_t mpath_numa_nodes_show(struct mpath_device *mpath_device, char *buf)
+{
+	struct mpath_head *mpath_head = mpath_device->mpath_head;
+	int node, srcu_idx;
+	nodemask_t numa_nodes;
+	struct mpath_device *current_mpath_dev;
+
+	if (mpath_read_iopolicy(mpath_head) != MPATH_IOPOLICY_NUMA)
+		return 0;
+
+	nodes_clear(numa_nodes);
+
+	srcu_idx = srcu_read_lock(&mpath_head->srcu);
+	for_each_node(node) {
+		current_mpath_dev =
+			srcu_dereference(mpath_head->current_path[node],
+				&mpath_head->srcu);
+		if (current_mpath_dev == mpath_device)
+			node_set(node, numa_nodes);
+	}
+	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
+}
+EXPORT_SYMBOL_GPL(mpath_numa_nodes_show);
+
 ssize_t mpath_delayed_removal_secs_show(struct mpath_head *mpath_head,
 					char *buf)
 {
-- 
2.43.0


