Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0B606D83D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wt+b+Zsr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=im6nR1IH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=yDA6l1mYLflGy0BGVuiZ1Kit3BaPSEgJ8GlY0lKqIiw=; b=wt+b+Zsr2h6Fg8aQpxy9VGyHOh
	FTctulvxpv04ei2G2YsNij5RW1cTFVTrb5NyRBOpcWOLR9OqtvPwLHopuPFtemT65TMQiPZuPGd0B
	c4ILk5QYGESNja5nq+F5eUhNSUiXhKscLSEEwHTMTkYZLoPuNteIZT2Xj+eYklsuXd/u0W+rbWnNI
	jz7SR9Lo/3WP8HjyYVeCLPuLwUecPB7lJ/Eq55bIITp/MVA2JeD0E0C8TvP2LIUo369bXDMZVgZYt
	DeoMfZeeaJusCutVQC8Js1EPKs7eXBARmkpAvFdpypjcSIyBJXVMi/wfckZZCBX1u57qycgTANLjc
	6gEpcwPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVE8-00000004UHd-3yNe;
	Wed, 04 Nov 2026 07:16:08 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVE6-00000004UGR-0Jz2
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:16:07 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so187579a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793776564; x=1794381364; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDA6l1mYLflGy0BGVuiZ1Kit3BaPSEgJ8GlY0lKqIiw=;
        b=im6nR1IH2neGqfGsfLm+ojvifndefdbMVPpmtyPlv+pjIKmWsRP1XVBwGGToLvFU07
         Zbj9CU+R+JSFW3h120QRuqpmllloSjNnGOBYCPKS1Qhc488jW6+vG3KGKKPJ1nzOoOhW
         rMw6FBmu1sQ3TEKuOAIbSNY8Suh83M76fSjrD8qP+w51/0WQ0mZlq9pZwq6VmOpPyrJr
         LbiD1IJV0anROhPa2JsObejf23Si4Z6uD/OQYweR48xhVG56WjUIDDJsos8pAD1gwH6G
         VqUAJ6hBAi/KFRIzYD8/KmxKPQ1ZcAqnvnMjDesdiBwAy6oV2WgSCS4LQUrkz+5dyONa
         li/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776564; x=1794381364;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDA6l1mYLflGy0BGVuiZ1Kit3BaPSEgJ8GlY0lKqIiw=;
        b=xstvM4BUMtbFlG+e2EUbyCmxIZVe63Pv4EwLu9KX357/Vulz0WoNyZo+0/SOqeif7y
         +f9fvRavZb15gXiXjvRXIusixSlIRilbgLKVwiXx7VRMaF6NMgPV8n/ra+GqtkDaowXT
         jWyrHjhZekiPI8VFUSXgrTsNRNcyrRIjDV2OB5KEMiRoXR/No43BL6v9GuPwz2CiJc1Y
         ip2enYiE3Yh0JHzXVPtPHbFE5agx91SgARY6l3R38HpOI+BO6uf44cJonq2kak9ixqg2
         RufGoR3DCmf4fh7WCirhvSfZTMtGCZ3luPiscISvJUMqqXGs2CcZOgK9DQ2YO7cvxasD
         kwrw==
X-Forwarded-Encrypted: i=1; AKwUvBwFYFJxZVWgDY0izNnqZTOuQWPAUbnk4YV9nixAhOIxXenuGPezWExx2zd2yUfANYzgF+5H/MGzAFgE@lists.infradead.org
X-Gm-Message-State: APuU4Z9xGvK7ZtUeUOVyw8ME7xk/cY/rp2bQpB9rHruJKLvpm6zh8bul
	daikxwSz8YMZ4fnbAKVSxI4w9Q1fm22QEV/cTCzy5Yjic6lYrdXwTdjSVKHamMi4
X-Gm-Gg: AYBFou2fO6Es/E1mnxBGUkIE0rwWpo+q4/eJQxkjuccUyOfRqOC5whBG08RFoTL40jO
	6E5LsNQ4BUVP8lGV5UuNENERgKVEZ2ZrvCJ7nv3nJ76MOehOFQe+V+WepXTwAlmQ/6llZM2AD5D
	7wxmPtlMSbnrEyFzjtz22EP/dlTWMvb2wrFvbNIXWiyELwb6zhgt3pXpQApEpqN35WzxWoTb9Vo
	/d6Qyzwp1wADbbClgVS4aTsoDz8xqh/DtV2B36X5kMBN2DC2eNKnIWlgC2YaZqrJcoZYP5HB1XF
	6eLzNhCFCU34qYYvgur8BR787VX+NCOgA65gVRkD1W64/pZHKZqJBLa646TPIXiDAXeZFMbDsk0
	NIcbb3cPLLbAZ/h+Hn3SCoDxsF+H3sGp8q2BbfXSWJD0D93L7biJN+w1SWqXkyfHfUw1OFhBJPW
	fXhwU5zhhM0vlA9kBpwxkBGV6Ucys8R+UWLXCYtDKN186hnCRlLhDLtZsgCSwaWp1A4v1jEpA0E
	9aWEtO0f4NLR0/+BbSqdbPqYElnUCsCcfoYuAqsT5N0PNzWctafpHLiVvRqpK6BMFdVpbkPyvrs
	1WqvLTmNgn5FFe4r7VuRY+vmL9scppyoCE81mcNdAAQ7B4K4zawlgnGe8z1EWujGucEnskczlDa
	a3VF0FGHuqNVgM+2FV+IbTuHdoROyUpIwEg0Hr27q0uWbTP/iGxaPFJbdTX5NF4u0cswSuw==
X-Received: by 2002:a17:90b:1f8f:b0:3a4:ba6b:cc24 with SMTP id 98e67ed59e1d1-3ae89820cc1mr11401444a91.58.1793776563726;
        Tue, 03 Nov 2026 23:16:03 -0800 (PST)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093c499a5sm2947389a91.2.2026.11.03.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:16:03 -0800 (PST)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v12] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Tue,  3 Nov 2026 23:16:00 -0800
Message-ID: <20261104071600.470430-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_231606_164343_4FA3B9A9 
X-CRM114-Status: GOOD (  34.06  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,BITCOIN_OBFU_SUBJ,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet issues namespace IOs from kernel threads. So the io.max and
other cgroup controllers can't apply limits to the namespaces.
Consider this scenario: LVM creates multiple logical volumes on the
same physical disk, and the logical volumes are assigned to different
nvmet subsystems/namespaces. We want to stop a remote noisy user from
using all the disk iops via nvmet. So add a per namespace cgroup_id to
associate the namespace with a cgroup. Each namespace can then be
throttled separately.

The per namespace cgroup is good enough for the io.max, but is not good
enough for the io.cost and io.latency. The io.cost and io.latency may
put a thread to sleep. If the thread is shared by different namespaces,
all of them will be impacted together. Submit the IOs via a workqueue to
avoid this impact.

With cgroup_id set, every I/O command except Reservation commands runs
from its own work item on a per namespace WQ_HIGHPRI workqueue. Zone
management and the file backend's Flush, DSM and Write Zeroes run
directly in that work item. Each work item runs under memalloc_noio and
looks up the cgroup's effective io css. A command whose queue is being
deleted is aborted. buffered_io is not supported.

Performance test:
On a 4 core VM and 4G ramdisk, export tcp-nvmeof targets to 127.0.0.1,
run fio with below parameters:
fio --bs=4k --rw=randwrite --iodepth=32 --numjobs=4 --ioengine=libaio --direct=1

file backend result:
|                            | IOPS   | Mean Latency | p99 latency |
|without this patch          | 204.4k | 625.8 µs     | 668 µs      |
|this patch, cgroup_id unset | 204.4k | 625.7 µs     | 668 µs      |
|this patch, cgroup_id set   | 155.9k | 820.6 µs     | 1139 µs     |

block device backend result:
|                            | IOPS   | Mean Latency | p99 latency |
|without this patch          | 216.0k | 592.2 µs     | 627 µs      |
|this patch, cgroup_id unset | 216.0k | 592.1 µs     | 627 µs      |
|this patch, cgroup_id set   | 160.0k | 799.6 µs     | 1090 µs     |

With this patch and no cgroup_id set, the performance is almost the same.
When we set the cgroup_id, with no io controller limit, we can see a
performance decrease but it is still very fast.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
Changes since v11 (Tejun's review of v11):
* Applied most of the v11 feedback suggestions.
* Rebased on nvme-7.4 ca7e6a9a6932.

Tejun's v11 review points without a code change:

> The name uses only the nsid, which is unique only within a subsystem, so
> namespaces in different subsystems get identically named workqueues and
> rescuer threads.

No unique name is needed, because the workqueue is not in sysfs (no
WQ_SYSFS). A subsystem NQN is also too long for a workqueue name (32
bytes).

> The file backend's Flush, DSM and Write Zeroes and zone management now
> count against blkcg_wq's max_active for their whole duration
> (vfs_fsync(), vfs_fallocate(), submit_bio_wait() over the zones). With
> max_active at the number of CPUs, a few slow flushes can fill it and
> hold up the namespace's reads and writes. Without cgroup_id these ran on
> nvmet_wq and zbd_wq. Probably fine, but worth noting.

Yes. They can only hold up commands of the same namespace, which are
charged to the same cgroup. A command that io.cost puts to sleep holds
its slot the same way.

Tejun, if v12 looks fine from the cgroup side, could you add your
Acked-by?

Tejun's v11 review: https://lore.kernel.org/all/17d94c41da65e31e1579a7211ebb7aa1@kernel.org/
v11: https://lore.kernel.org/all/20261029153103.13689-1-yupeng0921@gmail.com/
Sashiko's v10 review: https://lore.kernel.org/all/sashiko-outbox-185466@kernel.org/
v10: https://lore.kernel.org/all/20261026153020.47791-1-yupeng0921@gmail.com/
Tejun's v9 comment: https://lore.kernel.org/all/aee729fd53ef9c7c084a443216cfeb39@kernel.org/
v9: https://lore.kernel.org/all/20261023043423.176002-1-yupeng0921@gmail.com/
v8: https://lore.kernel.org/all/20261002152821.410591-1-yupeng0921@gmail.com/
v7 (with test steps): https://lore.kernel.org/all/20260929232411.101087-1-yupeng0921@gmail.com/

 Documentation/ABI/stable/configfs-nvmet |  21 ++++
 drivers/nvme/target/configfs.c          |  47 ++++++++
 drivers/nvme/target/core.c              | 153 ++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c       |  10 +-
 drivers/nvme/target/nvmet.h             |  40 +++++++
 drivers/nvme/target/zns.c               |   8 +-
 6 files changed, 269 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/stable/configfs-nvmet
index 36b587404ee7..c0b0b7ff100e 100644
--- a/Documentation/ABI/stable/configfs-nvmet
+++ b/Documentation/ABI/stable/configfs-nvmet
@@ -314,6 +314,27 @@ Description:
 		attr_subsys_vendor_id: Shows or sets the PCI subsystem
 		vendor ID. Displayed in "0x%x" format.
 
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_id
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Peng Yu <yupeng0921@gmail.com>
+Description:
+		Shows or sets the cgroup2 ID of the cgroup to charge this
+		namespace's I/O to. Writing 0 clears it. The I/O is
+		charged to the cgroup's effective io css: the cgroup
+		itself or its nearest ancestor with the io controller
+		enabled. The namespace must be disabled before
+		modification. Enabling the namespace fails if the cgroup
+		can't be found in the cgroup namespace of the enabling
+		task, or if buffered_io is set. If the cgroup is removed
+		while the namespace is enabled, the I/O goes to the
+		effective io css of its nearest remaining ancestor; a
+		cgroup that is removed and created again gets a new ID.
+		Reservation commands and the flush of a Set Features
+		Write Protect are not charged.
+
+		Only available when CONFIG_BLK_CGROUP is enabled.
+
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_key
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_hash
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..622559022f07 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -572,6 +572,50 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+#ifdef CONFIG_BLK_CGROUP
+static ssize_t nvmet_ns_cgroup_id_show(struct config_item *item, char *page)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	ssize_t ret;
+
+	mutex_lock(&subsys->lock);
+	ret = snprintf(page, PAGE_SIZE, "%llu\n", ns->cgroup_id);
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+static ssize_t nvmet_ns_cgroup_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	u64 cgroup_id;
+	int ret;
+
+	ret = kstrtou64(page, 0, &cgroup_id);
+	if (ret)
+		return ret;
+
+	mutex_lock(&subsys->lock);
+
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Writing 0 clears the association. */
+	ns->cgroup_id = cgroup_id;
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, cgroup_id);
+#endif /* CONFIG_BLK_CGROUP */
+
 #ifdef CONFIG_PCI_P2PDMA
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
@@ -844,6 +888,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+#ifdef CONFIG_BLK_CGROUP
+	&nvmet_ns_attr_cgroup_id,
+#endif
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1dede04c204a..67aeb704b015 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -4,12 +4,15 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/cgroup.h>
 #include <linux/hex.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
+#include <linux/sched/mm.h>
 
 #include <generated/utsrelease.h>
 
@@ -483,8 +486,152 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+#ifdef CONFIG_BLK_CGROUP
+static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	struct cgroup *cgrp;
+
+	if (!ns->cgroup_id)
+		return 0;
+
+	/*
+	 * Writeback of buffered writes is charged through the page cache's
+	 * memcg, not to this cgroup, so we don't support buffered io.
+	 */
+	if (ns->buffered_io) {
+		pr_err("cgroup_id is not supported with buffered_io: %s\n",
+		       ns->device_path);
+		return -EINVAL;
+	}
+
+	cgrp = cgroup_get_from_id(ns->cgroup_id);
+	if (IS_ERR(cgrp)) {
+		pr_err("failed to resolve cgroup id %llu: %ld\n",
+		       ns->cgroup_id, PTR_ERR(cgrp));
+		return PTR_ERR(cgrp);
+	}
+
+	/*
+	 * WQ_HIGHPRI: the tcp and rdma transports execute the commands from
+	 * WQ_HIGHPRI workqueues; keep that priority on this one.
+	 */
+	ns->blkcg_wq = alloc_workqueue("nvmet-blkcg-%u",
+			WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_HIGHPRI,
+			min_t(int, num_online_cpus(), WQ_MAX_ACTIVE),
+			ns->nsid);
+	if (!ns->blkcg_wq) {
+		cgroup_put(cgrp);
+		return -ENOMEM;
+	}
+
+	ns->cgrp = cgrp;
+	return 0;
+}
+
+static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->cgrp) {
+		/*
+		 * No command is left, but the work item of a command that
+		 * completed from inside ->blkcg_execute() may still be
+		 * returning: destroy_workqueue() waits for it.
+		 */
+		destroy_workqueue(ns->blkcg_wq);
+		ns->blkcg_wq = NULL;
+		cgroup_put(ns->cgrp);
+		ns->cgrp = NULL;
+	}
+}
+
+/*
+ * Charge the I/O that the current work item submits for @req to the
+ * effective io css of the namespace's cgroup, looked up for each command.
+ */
+static bool nvmet_blkcg_begin(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns = req->ns;
+	struct cgroup_subsys_state *css;
+
+	/*
+	 * A disable waits for the command: don't throttle it any more. This
+	 * catches only commands that haven't started; io.max holds the bios
+	 * already submitted and releases them at its rate.
+	 */
+	if (!test_bit(NVMET_NS_IO_LIVE, &ns->flags))
+		return false;
+
+	css = cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
+	kthread_associate_blkcg(css);
+	css_put(css);
+	return true;
+}
+
+static void nvmet_blkcg_end(bool associated)
+{
+	if (associated)
+		kthread_associate_blkcg(NULL);
+}
+
+/*
+ * The io.cost and io.latency enforce their limits by putting the thread to
+ * sleep. A transport thread may be shared by multiple namespaces. In the
+ * tcp-nvmeof case, all namespaces in the same subsystem may share a
+ * thread. So we submit the IOs via the workqueue, thus the current thread
+ * won't be blocked.
+ */
+static void nvmet_blkcg_work(struct work_struct *work)
+{
+	struct nvmet_req *req =
+		container_of(work, struct nvmet_req, blkcg_work);
+	unsigned int noio_flag;
+	bool associated;
+
+	/* its queue is being deleted: abort it rather than throttle it */
+	if (unlikely(percpu_ref_is_dying(&req->sq->ref))) {
+		nvmet_req_complete(req, NVME_SC_ABORT_QUEUE);
+		return;
+	}
+
+	/* reclaim must not wait for I/O queued on this workqueue */
+	noio_flag = memalloc_noio_save();
+	associated = nvmet_blkcg_begin(req);
+	req->blkcg_execute(req);
+	nvmet_blkcg_end(associated);
+	memalloc_noio_restore(noio_flag);
+}
+
+static void nvmet_blkcg_queue_req(struct nvmet_req *req)
+{
+	INIT_WORK(&req->blkcg_work, nvmet_blkcg_work);
+	queue_work(req->ns->blkcg_wq, &req->blkcg_work);
+}
+
+static void nvmet_blkcg_init_req(struct nvmet_req *req)
+{
+	if (!req->ns->blkcg_wq)
+		return;
+
+	req->blkcg_execute = req->execute;
+	req->execute = nvmet_blkcg_queue_req;
+}
+#else
+static inline int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	return 0;
+}
+
+static inline void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+}
+
+static inline void nvmet_blkcg_init_req(struct nvmet_req *req)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 {
+	nvmet_blkcg_ns_disable(ns);
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
 }
@@ -611,6 +758,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_unlock;
 
+	ret = nvmet_blkcg_ns_enable(ns);
+	if (ret)
+		goto out_dev_disable;
+
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
 		goto out_dev_disable;
@@ -1170,6 +1321,8 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (ret)
 		return ret;
 
+	nvmet_blkcg_init_req(req);
+
 	if (req->ns->pr.enable) {
 		ret = nvmet_pr_check_cmd_access(req);
 		if (ret)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..b9d221eeef57 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -265,8 +265,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
-	INIT_WORK(&req->f.work, nvmet_file_flush_work);
-	queue_work(nvmet_wq, &req->f.work);
+	nvmet_req_run_work(req, nvmet_wq, &req->f.work, nvmet_file_flush_work);
 }
 
 static void nvmet_file_execute_discard(struct nvmet_req *req)
@@ -325,8 +324,7 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
 		return;
-	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
-	queue_work(nvmet_wq, &req->f.work);
+	nvmet_req_run_work(req, nvmet_wq, &req->f.work, nvmet_file_dsm_work);
 }
 
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
@@ -355,8 +353,8 @@ static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
-	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
-	queue_work(nvmet_wq, &req->f.work);
+	nvmet_req_run_work(req, nvmet_wq, &req->f.work,
+			nvmet_file_write_zeroes_work);
 }
 
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3cd58e813aa7..17694fc7d634 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -118,6 +118,22 @@ struct nvmet_ns {
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
+#ifdef CONFIG_BLK_CGROUP
+	u64			cgroup_id;
+	/*
+	 * Resolved from ->cgroup_id when the namespace is enabled and
+	 * released when it is disabled, so it has the same lifetime and
+	 * visibility rules as ->bdev and ->file.
+	 */
+	struct cgroup		*cgrp;
+	/*
+	 * The I/O commands of a namespace with a cgroup, except Reservation
+	 * commands, are executed from their own work items on ->blkcg_wq, so
+	 * the cgroup's throttling doesn't put a transport context to sleep.
+	 */
+	struct workqueue_struct	*blkcg_wq;
+#endif
+
 	struct config_group	device_group;
 	struct config_group	group;
 
@@ -510,6 +526,11 @@ struct nvmet_req {
 
 	void (*execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
+#ifdef CONFIG_BLK_CGROUP
+	/* the backend's ->execute, called from ->blkcg_work */
+	void (*blkcg_execute)(struct nvmet_req *req);
+	struct work_struct	blkcg_work;
+#endif
 
 	struct pci_dev		*p2p_dev;
 	struct device		*p2p_client;
@@ -756,6 +777,25 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+/*
+ * A command of a namespace with a cgroup already runs from its own work
+ * item on the namespace's workqueue (see nvmet_blkcg_work()), so run the
+ * backend's work function right there; otherwise queue it on @wq.
+ */
+static inline void nvmet_req_run_work(struct nvmet_req *req,
+		struct workqueue_struct *wq, struct work_struct *work,
+		work_func_t func)
+{
+#ifdef CONFIG_BLK_CGROUP
+	if (req->ns->blkcg_wq) {
+		func(work);
+		return;
+	}
+#endif
+	INIT_WORK(work, func);
+	queue_work(wq, work);
+}
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92f5c1435582..38455481da24 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -335,8 +335,8 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, (numd + 1) << 2))
 		return;
 
-	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
-	queue_work(zbd_wq, &req->z.zmgmt_work);
+	nvmet_req_run_work(req, zbd_wq, &req->z.zmgmt_work,
+			   nvmet_bdev_zone_zmgmt_recv_work);
 }
 
 static inline enum req_op zsa_req_op(u8 zsa)
@@ -534,8 +534,8 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
 {
-	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zmgmt_send_work);
-	queue_work(zbd_wq, &req->z.zmgmt_work);
+	nvmet_req_run_work(req, zbd_wq, &req->z.zmgmt_work,
+			   nvmet_bdev_zmgmt_send_work);
 }
 
 static void nvmet_bdev_zone_append_bio_done(struct bio *bio)

base-commit: ca7e6a9a693240f059a0b47726f64a3f0573011a
-- 
2.53.0


