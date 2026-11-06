Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37775606A32C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GSdisCEn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQ0C6dtC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=M4t4nUaM77LTBLspJsJN1yKVVEF/qVttJpdsyY6jYSc=; b=GSdisCEn5Z+Qh4asfU1nWEr3pU
	ttxwbXW1lrcDZv8eIK+YquR+WnbDMp1h0v/WgkLoMjavIF7dg9Va/UQHckbojIiZncVNxf3a9UK1d
	mfdshU4uDrdnzCoKQx/WhCt1OXQ7bdNVHX0a/1ziTm6bjBvt7o/Qu0t+UWYCUoKG2SqXThVRReJxl
	CjGfrZaU1Cf6dnmA+4R6sOQ74gbvrIcw3bWok3/QdbFf/fXs+QBjP+FyuV2H+yW7JlL7026AqNlgG
	VV09l95E4Npk0ymftZmHt7FGiUhVq7GAXhN9q8smzXv3hBipELAKbPN3GFVu/nbchmiodTKPEEtuI
	5+avbiCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMqh-0000000D3nr-3ohJ;
	Fri, 06 Nov 2026 16:31:31 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMqe-0000000D3mo-2nyG
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:31:30 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so516399a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982687; x=1794587487; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4t4nUaM77LTBLspJsJN1yKVVEF/qVttJpdsyY6jYSc=;
        b=fQ0C6dtCgseirz17ai3gbpxl7oJk6ZamjU3HLSdvIf5JYUTot8ZUgAS+di3jldwIDR
         Y1sHSF9UATFvJ5db8tTphWgQ7J2jxNP9Z/obabkW4jX2Lvxcw/t4F5QObgPP2164Sspj
         U/TAWiv28NvMcYE7RGDFM6oBZTmIP9Nu9L46zRQczRpOn1T5HJcltZLuiUOI95bfXYAB
         tlmFYX4WZNpXCX/yp1pCbyvQsk+uStOJtTn/meFuGnUuTUwG0iRAqm53A6nucbeCOGP7
         Lj1Oyj8FKZ5rveYC6KdW+d1xrL+XkbySJtOnZpRMslBIHiGS46pu2fWaDHMuGxrGoCqX
         azxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982687; x=1794587487;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4t4nUaM77LTBLspJsJN1yKVVEF/qVttJpdsyY6jYSc=;
        b=D28vpBCWn4yBg2JTM662jBmHFrGt4yS1MhsQoE9dUa/gor0F9kiSX0ebS17OKwTVsF
         wA2D4J5NGhjvLaF81BpvJ6nk2YoT5uyS57y32VQhen+Yo2rnc6GElqzG98teJArlw1bT
         tM9+s4AaphOU0xiLpIDnUQQLXFJ6gcZ16UsrIwPBTwppcKJ0vswcb86rS/Pu5j4myTxX
         zuWPvsQCEdzs9u7U9CrwMNJMLAXpBSydDNo+7dOSulDg/PWj/zCmm2m8mzyqbU7P2vR6
         5o3FFVJ0P1GsqxpCvciJUzrn3sQexLmbS9ZswqLgeTlG7MQZq/iqO2m3/MOy0ZByV8fI
         w+CQ==
X-Forwarded-Encrypted: i=1; AL+hErG2Titju4OnmaVSdW56DgHYgSV78oO0/l+y670Dsxomb02oPQ4XslkMsR8kTzC+Q2AoL36mv00eKpRC@lists.infradead.org
X-Gm-Message-State: APuU4Z9shPcWEuUe8ekmjFtcH5pwo0pqsr+baR1X1CDJkzmIf7P3ZwEI
	TZWwkRHqVzH/GlZiIkHpGhe31fWCCdwQJeslMQg7G1MG3UTh7+h4snkO
X-Gm-Gg: AYBFou0kJ0hK/xmoCChyzG2WfWMGlqD3/I78stq1ZPy2W/zBIaFZI6y8Az2Aklthuci
	HnO3aPNVy++TMGLVh4OYwM5faS6NMjw0Y4SrQuFGZ9F9uCLFww0u+tb47voUz9c99pEdLkJoyIY
	Ni0uMkLSsX/4RNP7Gjg32t74S1wdpSVHKUxRrKCGCELzdSrXskjPSv+XJHTvebcUtZm00oeJmhX
	dXET8A2IoDbcarvwmaOb75HRan/KxCA8urCZOHms3SFUmr0xa0qGJ1FWWuoeA26fZKJJiLvHl1I
	WzsrA3O6XQRKJJ7EV96TIBfCsFiG26sPnO6pgV52HeY3/pH70X836DnKW8KtgkWRn2AeWIiT/4R
	geRdvM+rJphfio0fMFf3s0nLrk0pvN7pHzs4UERfxeWsdFSRClCpAQLfo/sOKyOjIkP72RC/vuK
	I3Q4dmVN4OgzA3pEhIcUC22kLC1o4AWsQll/fpAMa50Ng3om9YeI0C2QAjml7p0Xqpev2X+9924
	1EikgZERu4yY4CiJWzSWHPpZhH1kq8SD7Cht5I4pW3vvXOjmYHHHxv1T9eypAWO+X+MaGoUDVrn
	JlRQhpDKGJ+tNC5eO1lEv9QC2FlAhYY2BupWUsTDBQiCFv66ffMBYcDUyYxQsvCkQurG1+t8NUa
	G+37RQzssIJHtyPOm+GuqT3MTaqYMkUwaLrTy4WJxKfNXmkggXuPMoFCW0D3i0hPb8GJH8l4=
X-Received: by 2002:a17:90b:2792:b0:3ac:8897:7b92 with SMTP id 98e67ed59e1d1-3b0db70d34fmr2808658a91.57.1793982686876;
        Fri, 06 Nov 2026 08:31:26 -0800 (PST)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40d19sm6916345ad.32.2026.11.06.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:31:26 -0800 (PST)
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
Subject: [PATCH v13] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Fri,  6 Nov 2026 08:31:23 -0800
Message-ID: <20261106163123.208454-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_083128_743542_F2E4B15D 
X-CRM114-Status: GOOD (  30.58  )
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
Acked-by: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
Changes since v12 (Tejun's review of v12):
* Comment at nvmet_req_run_work() that the file backend's Flush, DSM and
  Write Zeroes and the zone management commands hold one of the
  namespace workqueue's max_active slots for their whole duration.
* Added Tejun's Acked-by from v12. The comment is the only other change.

Tejun's v12 review: https://lore.kernel.org/all/95403f5dce741c515718b2fc7f5dcc64@kernel.org/
v12: https://lore.kernel.org/all/20261104071600.470430-1-yupeng0921@gmail.com/
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
 drivers/nvme/target/nvmet.h             |  46 +++++++
 drivers/nvme/target/zns.c               |   8 +-
 6 files changed, 275 insertions(+), 10 deletions(-)

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
index 3cd58e813aa7..96306f5c09ae 100644
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
@@ -756,6 +777,31 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+/*
+ * A command of a namespace with a cgroup already runs from its own work
+ * item on the namespace's workqueue (see nvmet_blkcg_work()), so run the
+ * backend's work function right there; otherwise queue it on @wq.
+ *
+ * So with a cgroup, the file backend's Flush, DSM and Write Zeroes and
+ * the zone management commands hold one of blkcg_wq's max_active slots
+ * for the whole vfs_fsync(), vfs_fallocate() or zone operation. That can
+ * only delay other commands of the same namespace, which are charged to
+ * the same cgroup.
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


