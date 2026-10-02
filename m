Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71498CA5FDD
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xEXQq4H1e+S1FyS8d0fL7o60+B7DNsEj0LYRUI5ESlw=; b=tggsu7f66FZByp0g6j5ujK42D7
	90Im1CHOhoZ9wYFP3LL/JV8Vpu9SyX3lBhobwWTiLB4+mchMqNwUxzKj0uyn++m3o60Ik9kUx4bj3
	IXZuwRQMJs1NxUneQsl+Rn7HCyHLo7MhzajgYiy4uSsN/muyQ9BCNHIwMNr2x17DqO/fRsY+BcKQj
	QuW2cyXxJfwUsj8iNPXtEI0BIHEF0GFbrsNJw4oVNJ153CfSxWl5N815DzVru/knpYBX7+CCC2IGr
	K6jdP85cdZt3ukzJdSyEn+9CCC9hxyqJ9UfWFUHNjVMBIqX7Z6Lfo13jfQIEIDxnOVfAlCewvW98F
	hZ1XF3jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCfBV-0000000Bv1T-3jvm;
	Fri, 02 Oct 2026 15:28:29 +0000
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCfBT-0000000Bv0P-25BZ
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 15:28:28 +0000
Received: by mail-pj2-x2a.google.com with SMTP id d9443c01a7336-2e2d9fdf798so17121125ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954905; x=1791559705; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEXQq4H1e+S1FyS8d0fL7o60+B7DNsEj0LYRUI5ESlw=;
        b=B47zkukozruPkVYjbB5X2zlUaXsQIEnGTLlROqPP1wMXErdZhulcNpieoTgGTb3bSo
         enHHaNA7M70oQipENgwWwFjlD/Q7eJZazoUFMy+NK6VmWPOe+KMfWJ7iZ+tLO8lRI7O+
         ogdkQwVNjWigVuBLS2EBCDZfZE5i9xWuqceJ0qPbJ/OOdCNruqknZ9EXebnZB4SL+qTc
         G8nFYGyT35ckKxfSOpoN/BTCyUgnLgKMqnAshCzHsP5x9IV6WDvPTWUS2GPQfjP23oQL
         QFMviAmel9hjj6vsEO5fkkEEDNEulHIUYe2sTDgAb6/DqyzBvotRuXlNuSSNTB3FvVOh
         qKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954905; x=1791559705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEXQq4H1e+S1FyS8d0fL7o60+B7DNsEj0LYRUI5ESlw=;
        b=rzrrTBwtRXpCZIoAItBnH+lybz7Z5LpLQ9aqyuqWJ+G4OX2670YLLMuGjx1thBFTrc
         v8aFOwpZU9apPrRW0c1LUFmNvH7mvv4zKoRn5vHiNjtXu09yduLCWuxLUtYN5pDYW5Qz
         buLaPn6B7ndaDmB+3checZRu9auQ+L4871/Dz2m+S5RxwiCaxye7yom9T4sMp1D39fEu
         oNv+uAjUbwXeX8G+/8xUSUccNEkr8qdB/jimAn6EB2iVEc0SI6oBuzgvRjzFcv73me5T
         aPsl/EbinLcSVFFTSD6kDBSeNdrD9I8i0UBBmb0+SDOzjef9W2EeLNmi4dWoGBWUGAxH
         T1kQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoukNlCinfLj/PNxBlAgUU8G1Y7mCnXSKyH/7BCMzNzhu1joOhPQGxspHA9AGLNGfcNlRfheCFlPLm@lists.infradead.org
X-Gm-Message-State: AFq9FYK7w1qIPWVyJkOsOJGrcRyM/1EUy8D03cR51XXxOLURFDj9Xwn/
	yMJYOTJ9i/iKXFrC1NC5XU3QjKU8Tv5swoZw0w61puuwDJHTFbCL4FiY
X-Gm-Gg: AYBFou0mVwYTuh6IdbzM/YVYj2jyfsVAmEAsSrYVqcLR8ZsY17BUSOTXhlnLGIiqzYP
	nC5texshTvcoxcKLNXcKrotg/dn2ngVglAxVl9+Pywdqr0QA4VwmwNutXYqdNjbcYAXQIX/UUrf
	EWEZKHTM5Iquny3tHYExYw9F2XpEYlcVqi5WKbWizwSI0gu8qvdWOiriNP6j1uwWJMLDB3BjXjd
	TcYGsObGxLjeH1VJGYfgf03IJCcoPFLzpSnhebl6TViR2XdrdU8UMw0HHSwk4yAqLw6PQz0bt6r
	Hr35EKoH2/Kg/P2ace7vRuojkmDvR1xGv/9Ri527o/BMT7kL5t7G4JwzHb7CSlMHNplFi2EIUZ0
	xOAoF0wLhxDU4fTiFMuporf2exUrqEnFtQU8PYv2N83nTPeySp5h79m+2v5+umYfP3E57x3JHN0
	oTVS3HBolFxCnjvEc55MjEXL+jD7pEPqGpCrytTsO1lwL5JgD9qEDKa+PSMCNiQxm712kBnowke
	MbYKR3+z4qAFTFa4ux3NFmyhqVayizWX0JusXMb2PTSKe+Zl+SbagU84DzCtKIb0PlTYt63zk3A
	mQDR
X-Received: by 2002:a17:902:d2ce:b0:2dd:c100:7cc3 with SMTP id d9443c01a7336-2e49b6ec19dmr28454465ad.63.1790954905271;
        Fri, 02 Oct 2026 08:28:25 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e4b068a060sm5938495ad.56.2026.10.02.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:28:24 -0700 (PDT)
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
Subject: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Fri,  2 Oct 2026 08:28:21 -0700
Message-ID: <20261002152821.410591-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_082827_571689_8266306F 
X-CRM114-Status: GOOD (  27.52  )
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

nvmet issues namespace I/O from kernel threads, which are in the root
cgroup, so io.max and the other io controller settings can't be applied
per namespace. When namespaces on shared storage, e.g. LVM volumes on
the same physical volumes, are exported to different users, nothing
stops a noisy user from slowing down the others. Unlike loop, there is
no userspace process whose cgroup could be used instead.

Add a cgroup_id namespace attribute that takes a cgroup2 ID. While the
namespace is enabled, nvmet holds the cgroup and charges each command's
I/O to the cgroup's effective io css. Block device and file backed
namespaces are supported, but not buffered_io: buffered writes are
written back later by flusher threads that don't know the namespace's
cgroup.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
Change since v7:
* Write the commit message as prose (Tejun).
* Add a Documentation/ABI/stable/configfs-nvmet entry for cgroup_id
  (Tejun).
* Associate the read/write, flush and zone append bios through
  nvmet_blkcg_begin()/end() and drop nvmet_blkcg_set_bio(), so each
  bio is associated only once (Tejun).
* v7 1/2 was applied to cgroup/for-7.4 as d5632ae01502 ("cgroup: Track
  the effective css in each cgroup"). This patch doesn't depend on it.

v7 (with test steps): https://lore.kernel.org/all/20260929232411.101087-1-yupeng0921@gmail.com/

 Documentation/ABI/stable/configfs-nvmet | 15 +++++++
 drivers/nvme/target/configfs.c          | 47 +++++++++++++++++++++
 drivers/nvme/target/core.c              | 54 +++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c       | 22 +++++++++-
 drivers/nvme/target/io-cmd-file.c       | 21 +++++++++-
 drivers/nvme/target/nvmet.h             | 42 +++++++++++++++++++
 drivers/nvme/target/zns.c               |  7 ++++
 7 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/stable/configfs-nvmet
index 36b587404ee7..bdcb705aa8c9 100644
--- a/Documentation/ABI/stable/configfs-nvmet
+++ b/Documentation/ABI/stable/configfs-nvmet
@@ -314,6 +314,21 @@ Description:
 		attr_subsys_vendor_id: Shows or sets the PCI subsystem
 		vendor ID. Displayed in "0x%x" format.
 
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_id
+Date:		October 2026
+KernelVersion:	7.4
+Contact:	Peng Yu <yupeng0921@gmail.com>
+Description:
+		Shows or sets the cgroup2 ID of the cgroup to charge this
+		namespace's I/O to. Writing 0 clears it. The I/O is
+		charged to the cgroup's effective io css: the cgroup
+		itself or its nearest ancestor with the io controller
+		enabled. The namespace must be disabled before
+		modification. Enabling the namespace fails if the cgroup
+		can't be found or if buffered_io is set.
+
+		Only available when CONFIG_BLK_CGROUP is enabled.
+
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_key
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
 What:		/config/nvmet/hosts/HOSTNQN/dhchap_hash
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..cef832303d72 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -561,6 +561,50 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
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
@@ -833,6 +877,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
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
index 43871a8f56ca..6d9d55eb11eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/cgroup.h>
 #include <linux/hex.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -474,8 +475,57 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
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
+	 * Buffered writes will be handled by a separate thread,
+	 * these IOs have no namespace/cgroup information at that time,
+	 * so we don't support buffered io.
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
+	ns->cgrp = cgrp;
+	return 0;
+}
+
+static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->cgrp) {
+		cgroup_put(ns->cgrp);
+		ns->cgrp = NULL;
+	}
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
+#endif /* CONFIG_BLK_CGROUP */
+
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 {
+	nvmet_blkcg_ns_disable(ns);
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
 }
@@ -602,6 +652,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_unlock;
 
+	ret = nvmet_blkcg_ns_enable(ns);
+	if (ret)
+		goto out_dev_disable;
+
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
 		goto out_dev_disable;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..615a403d2e06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -262,6 +262,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
 	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
+	bool associated;
 
 	if (!nvmet_check_transfer_len(req, total_len))
 		return;
@@ -289,6 +290,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
+	associated = nvmet_blkcg_begin(req->ns);
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
@@ -315,6 +317,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 				rc = nvmet_bdev_alloc_bip(req, bio,
 							  &prot_miter);
 				if (unlikely(rc)) {
+					nvmet_blkcg_end(associated);
 					bio_io_error(bio);
 					return;
 				}
@@ -331,6 +334,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sector += sg->length >> 9;
 		sg_cnt--;
 	}
+	nvmet_blkcg_end(associated);
 
 	if (req->metadata_len) {
 		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
@@ -347,6 +351,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
+	bool associated;
 
 	if (!bdev_write_cache(req->ns->bdev)) {
 		nvmet_req_complete(req, NVME_SC_SUCCESS);
@@ -356,8 +361,10 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
+	associated = nvmet_blkcg_begin(req->ns);
 	bio_init(bio, req->ns->bdev, req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
+	nvmet_blkcg_end(associated);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
 
@@ -366,10 +373,16 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	bool associated;
+	int ret;
+
 	if (!bdev_write_cache(req->ns->bdev))
 		return 0;
 
-	if (blkdev_issue_flush(req->ns->bdev))
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = blkdev_issue_flush(req->ns->bdev);
+	nvmet_blkcg_end(associated);
+	if (ret)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	return 0;
 }
@@ -380,9 +393,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
 	sector_t nr_sects;
+	bool associated;
 	int i;
 	u16 status = NVME_SC_SUCCESS;
 
+	associated = nvmet_blkcg_begin(ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 				sizeof(range));
@@ -394,6 +409,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
 	}
+	nvmet_blkcg_end(associated);
 
 	if (bio) {
 		bio->bi_private = req;
@@ -431,6 +447,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	struct bio *bio = NULL;
 	sector_t sector;
 	sector_t nr_sector;
+	bool associated;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, 0))
@@ -440,8 +457,11 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
+	nvmet_blkcg_end(associated);
+
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f927..570e65259ad8 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -79,6 +79,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
 	struct iov_iter iter;
+	bool associated;
+	ssize_t ret;
 	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -97,7 +99,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
-	return call_iter(iocb, &iter);
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = call_iter(iocb, &iter);
+	nvmet_blkcg_end(associated);
+	return ret;
 }
 
 static void nvmet_file_io_done(struct kiocb *iocb, long ret)
@@ -251,7 +256,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	bool associated;
+	int ret;
+
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = vfs_fsync(req->ns->file, 1);
+	nvmet_blkcg_end(associated);
+	return errno_to_nvme_status(req, ret);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
@@ -274,10 +285,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
 	loff_t offset, len;
+	bool associated;
 	u16 status = 0;
 	int ret;
 	int i;
 
+	associated = nvmet_blkcg_begin(req->ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
@@ -300,6 +313,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		}
 	}
+	nvmet_blkcg_end(associated);
 
 	nvmet_req_complete(req, status);
 }
@@ -336,6 +350,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	bool associated;
 	int ret;
 
 	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
@@ -347,7 +362,9 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 		return;
 	}
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	nvmet_blkcg_end(associated);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..db46f8fd583d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -21,6 +21,8 @@
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
 #include <linux/kfifo.h>
+#include <linux/kthread.h>
+#include <linux/cgroup.h>
 
 #define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
 
@@ -115,6 +117,16 @@ struct nvmet_ns {
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
+#endif
+
 	struct config_group	device_group;
 	struct config_group	group;
 
@@ -732,6 +744,36 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+#ifdef CONFIG_BLK_CGROUP
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	struct cgroup_subsys_state *css;
+
+	if (!ns->cgrp || !in_task() || !(current->flags & PF_KTHREAD))
+		return false;
+
+	css = cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
+	kthread_associate_blkcg(css);
+	css_put(css);
+	return true;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+	if (associated)
+		kthread_associate_blkcg(NULL);
+}
+#else
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	return false;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 23a17c02abee..c6cc4730285b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -480,8 +480,11 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 	struct block_device *bdev = req->ns->bdev;
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	u16 status = NVME_SC_SUCCESS;
+	bool associated;
 	int ret;
 
+	associated = nvmet_blkcg_begin(req->ns);
+
 	if (op == REQ_OP_LAST) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
 		status = NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_DNR;
@@ -511,6 +514,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 		status = blkdev_zone_mgmt_errno_to_nvme_status(ret);
 
 out:
+	nvmet_blkcg_end(associated);
 	nvmet_req_complete(req, status);
 }
 
@@ -542,6 +546,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	struct scatterlist *sg;
 	u32 data_len = nvmet_rw_data_len(req);
 	struct bio *bio;
+	bool associated;
 	int sg_cnt;
 
 	/* Request is completed on len mismatch in nvmet_check_transfer_len() */
@@ -572,6 +577,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		goto out;
 	}
 
+	associated = nvmet_blkcg_begin(req->ns);
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->z.inline_bio;
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
@@ -579,6 +585,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	} else {
 		bio = bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
 	}
+	nvmet_blkcg_end(associated);
 
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
 	bio->bi_iter.bi_sector = sect;

base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
-- 
2.53.0


