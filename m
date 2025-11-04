Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE64CCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yS7TnUNR3w7118SKLu70GjJRMFSscuzv04fX8UccROs=; b=VdVUKh3oM0d/L1Pfp9r039u/DU
	kS4SmJHqwma2LdLhq83gIw2ddHxZR1glmfaBY1LI+rwhGcCDxQbDJ+Fo+hz8uvBiD9stZPW4plnuN
	wpTSnN/jfoJ6WiW5WdDvkJmEFO3+dpYW9T94Z4LHXI0xI3EtV7eUth/YqtwXR7HDn7h2tZJjoxw5V
	EgCsYMr736CQcqafZDXl++9+kD3yb6S2WT0ITuijshepkprkcdzaHCMtcoNa1tTMLsxuCdA2ucQjm
	Pjk2nbIrl/3u3LFmZZBjabfk4SkKNoBJdF6v/flwyoYwVMwIThAm1dxCrWOtwqfek8k05iqa807ll
	x3y7FHGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGC3a-0000000BNab-2Bol;
	Tue, 04 Nov 2025 08:06:22 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGC3X-0000000BNa1-3rZQ
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:06:21 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7a9e8a15502so2088969b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762243579; x=1762848379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS7TnUNR3w7118SKLu70GjJRMFSscuzv04fX8UccROs=;
        b=AAfcjumg+oeTO74h3ROevqCsdTmdnpL14XcwzetUAajnmluXN4gIxtKdms2pPtOGQv
         sFmYyJhozAIxxnAGqfhFmbryii04WfCAXpVURXQt9rQ6vnZDc277tSPXyvF1/vkP/oyX
         Eh71SBIGmo1yA1AZSEIB/qHVm1d2XJdx1jYprjY5ncarlrx3PosNOuNN0WdSN6tgT0Eo
         bQmhiBG2OiPoXEiij8KyWTsK4Rs0mhGrv4zORPSViJh5yTltMRxo/gWKUts3/0wh2X6v
         WBYjn7IPdOqzeyB0X3244Am+BGgwC3yU6GkgBQ6p/Ke7fzOcF6LV3Y83vtate7nHKqxZ
         IImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243579; x=1762848379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS7TnUNR3w7118SKLu70GjJRMFSscuzv04fX8UccROs=;
        b=brXvAlyW1ipKmIpIhuVvf3W701tiQlS00E5tD8M6WCcO6kZlWvy+afcQi/71qRFT2C
         sw3rvXRaAIcfDJCeYbvmqvd2i+9lur2tMfHectNgQ4JL/6w+oIiQ++fh10aOMChhs/MU
         YAsxkHtKVvVkSvYMb9v42i4+MI0KAi/A09pDtaIQmhzXZ77xcyTT18ZSHEynalZBS7Vm
         fsIGuJZeCaIvXRZDXr+JqE9rODXUHyiVZulT9qM9k52migixOWy5ZXAPgMtAnIsuZJvC
         KNCFWHHBy399XTv9JqCDa5FsfPnc7ZJQ8O8jHZ88QwHs+LmqBj/K25Fp8xSHtO9QQ/MP
         0gTA==
X-Gm-Message-State: AOJu0YwvjPHXZ1Y6SOtFMgRZZjnpRjuPDFLCHnhXzBOPNqH1cFObhx1O
	pxytAV/PeQMzG1juMRRaL7PGfaZPI0r8mfANsr4DB5klsweyh9WA5v31p2+ptw==
X-Gm-Gg: ASbGncs7z8JWTaowDyVH7t9Wl4fXOgQXFuXqvAxdm6bMQXcO9PP7y/FQ1pEy37E8y2/
	I/p/ev11J2/IpszY/DTzZJTc5R8pid4uaZqSEY3TAzxFZk2Unw1sTGc228eQz1UO+4Ldndtuxga
	cFHaETQum64LWxvVlX6TRDwHk6nKR7wRdLdtX60FHUx9Lf75wITTCGrSN7mhNBT9O5i7Thz1sHk
	40MF4T+/2mcwJnV2ZTgGFCKWgmq+luz6B5RxeIysiIp0I8XXE92x0Yzeha8AiYsPM5ZJZMfBOZs
	IwNFD6RTIfJAL4liGJ4FD4AeN4glMl9fBZpnJrQnkZn9T6AXNuZocuZqcOAvp2PnKJwic2Fy/Rw
	ovj995p3uO5NUvNSTYjs9TymLUSNGp77ODdefFdbdaHUM6LoFWD+bt4LsoV+/OumCW4ORc75DaK
	3+ykjtZjLeroBorhmVGDEGn4GVbgm10o6jX3pr
X-Google-Smtp-Source: AGHT+IEW2dMpoqOvPzFMn7DiCNrGSANDFVzJDx5MnFU5zRHlgt6mIfcXkgTYOO0C+aqWLnzSYnq4Vw==
X-Received: by 2002:a05:6a21:6da9:b0:348:b7a1:431 with SMTP id adf61e73a8af0-348c9f660b9mr20719366637.10.1762243578592;
        Tue, 04 Nov 2025 00:06:18 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c4aa89asm3525713a91.11.2025.11.04.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:06:18 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 1/1] nvmet: add basic in-memory backend support
Date: Tue,  4 Nov 2025 00:06:10 -0800
Message-Id: <20251104080610.183707-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_000620_008181_FF1264EF 
X-CRM114-Status: GOOD (  32.70  )
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

Add a new memory backend (io-cmd-mem.c) that enables dynamic, on-demand
RAM-backed storage for NVMe target namespaces. This provides instant,
zero-configuration volatile storage without requiring physical block
devices, filesystem backing, or pre-provisioned storage infrastructure.

Modern cloud-native workloads increasingly require dynamic allocation
of high-performance temporary storage for intermediate data processing,
such as AI/ML training scratch space, data analytics shuffle storage,
and in-memory database overflow. The memory backend addresses this need
by providing instant namespace creation with sub-millisecond latency
via NVMe-oF, eliminating traditional storage provisioning workflows
entirely.

Dynamic Configuration:
The memory backend introduces dynamic namespace configuration via
configfs, enabling instant namespace creation without storage
provisioning. Create memory-backed namespaces on-demand by setting
'mem_size' instead of 'device_path':
  # Dynamic namespace creation - instant, no device setup required
  echo 1073741824 > /sys/kernel/config/nvmet/.../mem_size
  echo 1 > /sys/kernel/config/nvmet/.../enable

This eliminates the need for:
- Block device creation and management (no dd, losetup,
  device provisioning)
- Filesystem mounting and configuration
- Storage capacity pre-allocation
- Device cleanup workflows after namespace deletion

Implementation detail :-
- Dynamic page allocation using xarray for sparse storage
- Pages allocated lazily on first write, efficient for partially filled
  namespaces
- Full I/O command support: read, write, flush, discard, write-zeroes
- Mutually exclusive with device_path (memory XOR block/file backend)
- Size configurable per-namespace, limited to 80% of total system RAM
- Automatic memory reclamation on namespace deletion
- Page reference counting and cleanup

Backend selection logic:
- If mem_size is set (no device_path): Use memory backend
				      (dynamic allocation)
- If device_path points to block device: Use bdev backend
- If device_path points to regular file: Use file backend

The implementation follows the existing nvmet backend pattern with three
main entry points:
  nvmet_mem_ns_enable()    - Initialize namespace with xarray storage
  nvmet_mem_ns_disable()   - Release all pages and cleanup
  nvmet_mem_parse_io_cmd() - Dispatch I/O commands to handlers

Tested with blktests memory backend test suite covering basic I/O
operations, discard/write-zeroes, all transport types (loop/TCP/RDMA),
dynamic namespace creation/deletion cycles, and proper resource cleanup.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/nvme/target/Makefile     |   2 +-
 drivers/nvme/target/configfs.c   |  61 +++++
 drivers/nvme/target/core.c       |  20 +-
 drivers/nvme/target/io-cmd-mem.c | 426 +++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h      |   8 +
 5 files changed, 511 insertions(+), 6 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-mem.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ed8522911d1f..f27f2bf5a62d 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 obj-$(CONFIG_NVME_TARGET_PCI_EPF)	+= nvmet-pci-epf.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o io-cmd-mem.o pr.o
 nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2642e3148f3f..f6ef3404cb81 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -535,6 +535,66 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+static ssize_t nvmet_ns_mem_size_show(struct config_item *item, char *page)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+
+	/* Only show size for memory-backed namespaces */
+	if (ns->device_path)
+		return sprintf(page, "0\n");
+
+	return sprintf(page, "%llu\n", ns->size);
+}
+
+static ssize_t nvmet_ns_mem_size_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	u64 new_size, max_size;
+	int ret;
+
+	ret = kstrtou64(page, 0, &new_size);
+	if (ret)
+		return ret;
+
+	mutex_lock(&subsys->lock);
+
+	/* Only allow for memory-backed namespaces */
+	if (ns->device_path) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Can only change size when namespace is disabled */
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (new_size == 0) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Limit to 80% of total system memory */
+	max_size = ((u64)totalram_pages() * 80 / 100) << PAGE_SHIFT;
+	if (new_size > max_size) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ns->size = new_size;
+	mutex_unlock(&subsys->lock);
+	return count;
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, mem_size);
+
 #ifdef CONFIG_PCI_P2PDMA
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
@@ -800,6 +860,7 @@ CONFIGFS_ATTR(nvmet_ns_, resv_enable);
 
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
+	&nvmet_ns_attr_mem_size,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_ana_grpid,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc88e5a28c8a..a2a5e10c2bbd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -467,6 +467,7 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 {
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
+	nvmet_mem_ns_disable(ns);
 }
 
 static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
@@ -557,8 +558,10 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 
 	if (ns->bdev)
 		nvmet_bdev_ns_revalidate(ns);
-	else
+	else if (ns->file)
 		nvmet_file_ns_revalidate(ns);
+	else
+		nvmet_mem_ns_revalidate(ns);
 
 	return oldsize != ns->size;
 }
@@ -580,9 +583,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ret = nvmet_bdev_ns_enable(ns);
-	if (ret == -ENOTBLK)
-		ret = nvmet_file_ns_enable(ns);
+	/* Memory backend if no device_path is set */
+	if (!ns->device_path) {
+		ret = nvmet_mem_ns_enable(ns);
+	} else {
+		ret = nvmet_bdev_ns_enable(ns);
+		if (ret == -ENOTBLK)
+			ret = nvmet_file_ns_enable(ns);
+	}
 	if (ret)
 		goto out_unlock;
 
@@ -1121,8 +1129,10 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	case NVME_CSI_NVM:
 		if (req->ns->file)
 			ret = nvmet_file_parse_io_cmd(req);
-		else
+		else if (req->ns->bdev)
 			ret = nvmet_bdev_parse_io_cmd(req);
+		else
+			ret = nvmet_mem_parse_io_cmd(req);
 		break;
 	case NVME_CSI_ZNS:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
diff --git a/drivers/nvme/target/io-cmd-mem.c b/drivers/nvme/target/io-cmd-mem.c
new file mode 100644
index 000000000000..a92c639490cd
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-mem.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics target in-memory I/O command implementation.
+ * Copyright (c) 2024 NVIDIA Corporation.
+ * Author: Chaitanya Kulkarni <kch@nvidia.com>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+#include <linux/xarray.h>
+#include <linux/highmem.h>
+#include <linux/overflow.h>
+#include "nvmet.h"
+
+/* Convert sector to xarray page index */
+#define SECTOR_TO_PAGE_IDX(sector) \
+	((sector) >> (PAGE_SHIFT - SECTOR_SHIFT))
+
+/* Calculate byte offset within a page for a given sector */
+#define SECTOR_TO_OFFSET_IN_PAGE(sector) \
+	(((sector) << SECTOR_SHIFT) & ~PAGE_MASK)
+
+/*
+ * Validate LBA range against namespace size.
+ * Returns 0 if valid, NVMe error status if out of bounds.
+ */
+static u16 nvmet_mem_check_range(struct nvmet_ns *ns, u64 slba, u32 nlb)
+{
+	u64 end_lba;
+
+	/* Check for overflow in end_lba calculation */
+	if (unlikely(check_add_overflow(slba, nlb, &end_lba)))
+		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
+
+	/* Convert namespace size (bytes) to LBAs */
+	if (unlikely(end_lba > (ns->size >> ns->blksize_shift)))
+		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
+
+	return 0;
+}
+
+/*
+ * Look up a page with refcount grabbed.
+ * Returns page with reference, or NULL if not found.
+ */
+static struct page *nvmet_mem_lookup_page(struct nvmet_ns *ns, pgoff_t idx)
+{
+	struct page *page;
+
+	rcu_read_lock();
+repeat:
+	page = xa_load(&ns->mem_pages, idx);
+	if (!page)
+		goto out;
+
+	if (!get_page_unless_zero(page))
+		goto repeat;
+
+	/*
+	 * Verify page is still in tree after getting refcount.
+	 * If not, it's being removed - drop ref and retry.
+	 */
+	if (unlikely(page != xa_load(&ns->mem_pages, idx))) {
+		put_page(page);
+		goto repeat;
+	}
+out:
+	rcu_read_unlock();
+	return page;
+}
+
+/*
+ * Allocate and insert a page into the namespace xarray.
+ * Returns the page with reference grabbed on success, ERR_PTR on failure.
+ * Caller must call put_page() when done.
+ */
+static struct page *nvmet_mem_insert_page(struct nvmet_ns *ns, sector_t sect)
+{
+	pgoff_t idx = SECTOR_TO_PAGE_IDX(sect);
+	struct page *page, *ret;
+
+	/* Fast path: check if page already exists */
+	page = nvmet_mem_lookup_page(ns, idx);
+	if (page)
+		return page;
+
+	/* Allocate new page outside of lock */
+	page = alloc_page(GFP_NOWAIT | __GFP_ZERO | __GFP_NOWARN);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	/* Try to insert - handle race with xa_cmpxchg */
+	xa_lock(&ns->mem_pages);
+	ret = __xa_cmpxchg(&ns->mem_pages, idx, NULL, page, GFP_ATOMIC);
+
+	if (!ret) {
+		/* We successfully inserted the page */
+		ns->mem_nr_pages++;
+		get_page(page);  /* Reference for caller */
+		xa_unlock(&ns->mem_pages);
+		return page;
+	}
+
+	if (!xa_is_err(ret)) {
+		/* Another thread won the race - use their page */
+		get_page(ret);  /* Reference for caller */
+		xa_unlock(&ns->mem_pages);
+		put_page(page);  /* Free our allocated page */
+		return ret;
+	}
+
+	/* Insertion failed due to xarray error */
+	xa_unlock(&ns->mem_pages);
+	put_page(page);
+	return ERR_PTR(xa_err(ret));
+}
+
+static int nvmet_mem_read_chunk(struct nvmet_ns *ns, void *sgl_addr,
+				sector_t sect, unsigned int copy_len)
+{
+	unsigned int offset = SECTOR_TO_OFFSET_IN_PAGE(sect);
+	pgoff_t idx = SECTOR_TO_PAGE_IDX(sect);
+	struct page *page;
+	void *src;
+
+	page = nvmet_mem_lookup_page(ns, idx);
+	if (page) {
+		src = kmap_local_page(page);
+		memcpy(sgl_addr, src + offset, copy_len);
+		kunmap_local(src);
+		put_page(page);  /* Drop reference */
+	} else {
+		memset(sgl_addr, 0, copy_len);
+	}
+
+	return 0;
+}
+
+static int nvmet_mem_write_chunk(struct nvmet_ns *ns, void *sgl_addr,
+				 sector_t sect, unsigned int copy_len)
+{
+	unsigned int offset = SECTOR_TO_OFFSET_IN_PAGE(sect);
+	struct page *page;
+	void *dst;
+
+	page = nvmet_mem_insert_page(ns, sect);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	dst = kmap_local_page(page);
+	memcpy(dst + offset, sgl_addr, copy_len);
+	kunmap_local(dst);
+	put_page(page);
+
+	return 0;
+}
+
+static void nvmet_mem_execute_rw(struct nvmet_req *req)
+{
+	int (*process_chunk)(struct nvmet_ns *ns, void *sgl_addr,
+			     sector_t sect, unsigned int copy_len);
+	struct nvmet_ns *ns = req->ns;
+	struct sg_mapping_iter miter;
+	unsigned int sg_flags;
+	sector_t sect;
+	u16 status = NVME_SC_SUCCESS;
+	int ret;
+
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+		return;
+
+	status = nvmet_mem_check_range(ns, le64_to_cpu(req->cmd->rw.slba),
+				       le16_to_cpu(req->cmd->rw.length) + 1);
+	if (status) {
+		nvmet_req_complete(req, status);
+		return;
+	}
+
+	sect = nvmet_lba_to_sect(ns, req->cmd->rw.slba);
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		sg_flags = SG_MITER_FROM_SG;
+		process_chunk = nvmet_mem_write_chunk;
+	} else {
+		sg_flags = SG_MITER_TO_SG;
+		process_chunk = nvmet_mem_read_chunk;
+	}
+
+	sg_miter_start(&miter, req->sg, req->sg_cnt, sg_flags);
+
+	while (sg_miter_next(&miter)) {
+		unsigned int miter_offset = 0;
+		unsigned int miter_len = miter.length;
+
+		while (miter_len > 0) {
+			unsigned int offset, copy_len;
+
+			offset = SECTOR_TO_OFFSET_IN_PAGE(sect);
+			copy_len = min_t(unsigned int, miter_len,
+					 PAGE_SIZE - offset);
+
+			ret = process_chunk(ns, miter.addr + miter_offset,
+					    sect, copy_len);
+			if (ret) {
+				status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+				goto out;
+			}
+
+			sect += copy_len >> SECTOR_SHIFT;
+			miter_offset += copy_len;
+			miter_len -= copy_len;
+		}
+	}
+
+out:
+	sg_miter_stop(&miter);
+	nvmet_req_complete(req, status);
+}
+
+/*
+ * Flush command - no-op for memory backend (no persistent storage).
+ */
+static void nvmet_mem_execute_flush(struct nvmet_req *req)
+{
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
+	nvmet_req_complete(req, NVME_SC_SUCCESS);
+}
+
+/*
+ * Discard/TRIM command - delete pages in the range.
+ * With PAGE_SIZE LBAs, each LBA maps to exactly one page,
+ * so we simply delete the corresponding pages from xarray.
+ */
+static void nvmet_mem_execute_discard(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns = req->ns;
+	struct nvme_dsm_range range;
+	u16 status = NVME_SC_SUCCESS;
+	int i;
+
+	for (i = 0; i < le32_to_cpu(req->cmd->dsm.nr) + 1; i++) {
+		sector_t sect, nr_sect;
+		pgoff_t idx;
+		struct page *page;
+
+		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					     sizeof(range));
+		if (status)
+			break;
+
+		status = nvmet_mem_check_range(ns, le64_to_cpu(range.slba),
+					       le32_to_cpu(range.nlb));
+		if (status)
+			break;
+
+		sect = nvmet_lba_to_sect(ns, range.slba);
+		nr_sect = le32_to_cpu(range.nlb) <<
+			     (ns->blksize_shift - SECTOR_SHIFT);
+
+		/* Skip zero-length discard */
+		if (nr_sect == 0)
+			continue;
+
+		/*
+		 * With PAGE_SIZE LBAs, sectors align with pages.
+		 * Delete all pages in range.
+		 */
+		xa_lock(&ns->mem_pages);
+		for (idx = SECTOR_TO_PAGE_IDX(sect);
+		     idx < SECTOR_TO_PAGE_IDX(sect + nr_sect);
+		     idx++) {
+			page = __xa_erase(&ns->mem_pages, idx);
+			if (page) {
+				put_page(page);
+				ns->mem_nr_pages--;
+			}
+		}
+		xa_unlock(&ns->mem_pages);
+	}
+
+	nvmet_req_complete(req, status);
+}
+
+/*
+ * Write Zeroes command - allocate zeroed pages in the range.
+ * With PAGE_SIZE LBAs, each LBA maps to exactly one page.
+ * Allocate pages and zero them (allocation gives zeroed pages).
+ */
+static void nvmet_mem_execute_write_zeroes(struct nvmet_req *req)
+{
+	struct nvme_write_zeroes_cmd *wz = &req->cmd->write_zeroes;
+	struct nvmet_ns *ns = req->ns;
+	sector_t nr_sects, sect;
+	pgoff_t idx, start_idx, end_idx;
+	struct page *page;
+	void *kaddr;
+	u16 status = NVME_SC_SUCCESS;
+
+	status = nvmet_mem_check_range(ns, le64_to_cpu(wz->slba),
+				       le16_to_cpu(wz->length) + 1);
+	if (status)
+		goto out;
+
+	sect = nvmet_lba_to_sect(ns, wz->slba);
+	nr_sects = (le16_to_cpu(wz->length) + 1) <<
+		   (ns->blksize_shift - SECTOR_SHIFT);
+
+	start_idx = SECTOR_TO_PAGE_IDX(sect);
+	end_idx = SECTOR_TO_PAGE_IDX(sect + nr_sects - 1);
+
+	/*
+	 * With PAGE_SIZE LBAs, sectors align with pages.
+	 * Allocate and zero all pages in range.
+	 */
+	for (idx = start_idx; idx <= end_idx; idx++) {
+		sector_t pg_sect = idx << (PAGE_SHIFT - SECTOR_SHIFT);
+
+		page = nvmet_mem_insert_page(ns, pg_sect);
+		if (IS_ERR(page)) {
+			status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+			goto out;
+		}
+
+		kaddr = kmap_local_page(page);
+		memset(kaddr, 0, PAGE_SIZE);
+		kunmap_local(kaddr);
+
+		put_page(page);
+	}
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+/*
+ * Setup namespace for memory backend.
+ */
+int nvmet_mem_ns_enable(struct nvmet_ns *ns)
+{
+	if (!ns->size) {
+		pr_err("memory backend: namespace size not configured\n");
+		return -EINVAL;
+	}
+
+	xa_init(&ns->mem_pages);
+	ns->mem_nr_pages = 0;
+
+	/* Set block size shift - memory backend uses page-sized LBAs */
+	ns->blksize_shift = PAGE_SHIFT;  /* 2^12 = 4096 bytes */
+
+	pr_info("memory backend: enabled namespace %u, size %lld, lba_size %u\n",
+		ns->nsid, ns->size, 1 << ns->blksize_shift);
+
+	return 0;
+}
+
+/*
+ * Disable namespace and free all pages.
+ */
+void nvmet_mem_ns_disable(struct nvmet_ns *ns)
+{
+	unsigned long nr_freed = 0;
+	struct page *pages[32];  /* Batch size */
+	unsigned long idx;
+	int count, i;
+
+	/* Free all allocated pages using batch collection */
+	do {
+		count = 0;
+		idx = 0;
+
+		xa_lock(&ns->mem_pages);
+		while (count < 32) {
+			pages[count] = xa_find(&ns->mem_pages, &idx,
+					       ULONG_MAX, XA_PRESENT);
+			if (!pages[count])
+				break;
+			__xa_erase(&ns->mem_pages, idx);
+			count++;
+			idx++;
+		}
+		xa_unlock(&ns->mem_pages);
+
+		for (i = 0; i < count; i++) {
+			put_page(pages[i]);
+			nr_freed++;
+		}
+
+		cond_resched();
+
+	} while (count > 0);
+
+	xa_destroy(&ns->mem_pages);
+	ns->mem_nr_pages = 0;
+
+	pr_info("memory backend: disabled namespace %u, freed %lu pages\n",
+		ns->nsid, nr_freed);
+}
+
+void nvmet_mem_ns_revalidate(struct nvmet_ns *ns)
+{
+	/* Nothing to revalidate for memory backend */
+}
+
+u16 nvmet_mem_parse_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		req->execute = nvmet_mem_execute_rw;
+		return 0;
+	case nvme_cmd_flush:
+		req->execute = nvmet_mem_execute_flush;
+		return 0;
+	case nvme_cmd_dsm:
+		req->execute = nvmet_mem_execute_discard;
+		return 0;
+	case nvme_cmd_write_zeroes:
+		req->execute = nvmet_mem_execute_write_zeroes;
+		return 0;
+	default:
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
+	}
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b73d9589e043..1deea1527700 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -128,6 +128,10 @@ struct nvmet_ns {
 	u8			csi;
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
+
+	/* Memory backend support */
+	struct xarray		mem_pages;
+	u64			mem_nr_pages;  /* Protected by mem_pages xa_lock */
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -706,14 +710,18 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
+int nvmet_mem_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
+void nvmet_mem_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_mem_ns_revalidate(struct nvmet_ns *ns);
 bool nvmet_ns_revalidate(struct nvmet_ns *ns);
+u16 nvmet_mem_parse_io_cmd(struct nvmet_req *req);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-- 
2.40.0


