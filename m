Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB7C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kz7kTMiUXatS23BONeE1P0qll3os2DhBQ8wjy9d+oXQ=; b=C2w2FOmn6RsGjj4n10mjBAoecD
	pjbjwnr8NKg2INcMs4cF06krcJggh5DHz6gzOUI/O/JVIpehOmwDwXAgYmlfqAJo2yjEqrusndwvW
	k3ml2/B7UI7CZZyZni//2m3vmLgiGFvEpJap8O7NqCAfYf7Cbg0PiD9I8U/xrZCBLtYciIg+64i8z
	bKo4awXLj3hnRmdL8+i4VQYs2mfcwj2yPI+JaOjxCiDjLJpN8BxeXjpJgSSqzCDNesQhQqSAjZ1tB
	wxzvQ3WEcme5hGvIt2B+az6pIiPurOgl24MHImwfJM/UVrSI9SauGnWZ3CRDYR5DQsL4IgreLGtS9
	VZi9dnUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrK-000000097q7-1fO7;
	Thu, 03 Apr 2025 14:47:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrI-000000097nj-0sOb
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7203068438;
	Thu,  3 Apr 2025 14:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11BAC4CEE5;
	Thu,  3 Apr 2025 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743691675;
	bh=lCnEaRTtzJ+0EOJv9vLnKCtNCJbYHCwQzN1uu9PtQ8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdwmVcwz5GIJxxyCvBQxbXvVRly7xdxeXE0ByFWRasbpcU6EoJepyGpxfJHlg2DEx
	 Vw6QivjWHp9yYsorwkalukHOMRJ38gOE9ndWsolWe0gtNB4GGe8QQ2/mc3yA3OOQvb
	 1NzlCAH2gXDIRhvpde10U3q+P8u2S3irYTeLjzK2C+pgtQDcXqkg+Z2BIoc3oQcY0r
	 AzAlE15O3DIBJd/TQgzM9obqgz7i4FFvv93yl441Ac6AA9Y+OSo3Tm3jzTxIyXml7Y
	 G0B8XBmkL9h237L/vbgjMyS49p1mEUnDZ0uFbrNhTD/DG0VtU/qEe0qdKDFG4Hi1ti
	 lhGsoaRAWR4sw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvmet: implement persistent read-only namespace feature
Date: Thu,  3 Apr 2025 16:47:47 +0200
Message-Id: <20250403144747.43043-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403144747.43043-1-hare@kernel.org>
References: <20250403144747.43043-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Per default we try to open the 'device_path' read-write, which might
fail if the device is read-only. So retry with opening read-only, and
implement a new 'persistent_ro' flag if we did so.
And map that flag onto the 'Permanently Write Protect' setting in the
write protection feature.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/admin-cmd.c   | 15 +++++++++++----
 drivers/nvme/target/configfs.c    |  5 +++++
 drivers/nvme/target/core.c        |  2 ++
 drivers/nvme/target/io-cmd-bdev.c | 11 +++++++++++
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++++++++++----
 drivers/nvme/target/nvmet.h       |  1 +
 6 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 43f819b0f89b..2fea7ab05408 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1098,7 +1098,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nstat = NVME_NSTAT_NRDY;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 	id->nmic = NVME_NS_NMIC_SHARED;
-	if (req->ns->readonly)
+	if (req->ns->readonly || req->ns->persistent_ro)
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
@@ -1225,8 +1225,13 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 			req->ns->readonly = false;
 		break;
 	case NVME_NS_NO_WRITE_PROTECT:
-		req->ns->readonly = false;
-		status = 0;
+		if (req->ns->persistent_ro)
+			status = NVME_SC_FEATURE_NOT_CHANGEABLE | \
+				NVME_STATUS_DNR;
+		else {
+			req->ns->readonly = false;
+			status = 0;
+		}
 		break;
 	default:
 		break;
@@ -1418,7 +1423,9 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 		return result;
 
 	mutex_lock(&subsys->lock);
-	if (req->ns->readonly == true)
+	if (req->ns->persistent_ro == true)
+		result = NVME_NS_WRITE_PROTECT_PERMANENT;
+	else if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
 	else
 		result = NVME_NS_NO_WRITE_PROTECT;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index cb03b448ae6d..1efe1ed2ae50 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -840,6 +840,11 @@ static ssize_t nvmet_ns_readonly_store(struct config_item *item,
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
+	if (ns->persistent_ro && val == false) {
+		pr_err("the ns:%d is permanently read-only\n", ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+		return -EACCES;
+	}
 	ns->readonly = val;
 	mutex_unlock(&ns->subsys->lock);
 	return count;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2e741696f371..42605c67cbeb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -725,6 +725,8 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->readonly = false;
+	ns->persistent_ro = false;
 	ns->csi = NVME_CSI_NVM;
 
 	return ns;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 83be0657e6df..f28dfac2b9fe 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -91,6 +91,17 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
 	if (IS_ERR(ns->bdev_file)) {
 		ret = PTR_ERR(ns->bdev_file);
+		if (ret == -EACCES) {
+			ns->bdev_file = bdev_file_open_by_path(ns->device_path,
+						BLK_OPEN_READ, NULL, NULL);
+			if (IS_ERR(ns->bdev_file)) {
+				ret = PTR_ERR(ns->bdev_file);
+			} else {
+				ns->readonly = true;
+				ns->persistent_ro = true;
+				ret = 0;
+			}
+		}
 		if (ret != -ENOTBLK) {
 			pr_err("failed to open block device %s: (%d)\n",
 					ns->device_path, ret);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..770dec653bab 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -41,10 +41,23 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
-		pr_err("failed to open file %s: (%d)\n",
-			ns->device_path, ret);
-		ns->file = NULL;
-		return ret;
+		if (ret == -EACCES) {
+			flags = O_RDONLY | O_LARGEFILE;
+			ns->file = filp_open(ns->device_path, flags, 0);
+			if (IS_ERR(ns->file)) {
+				ret = PTR_ERR(ns->file);
+			} else {
+				ns->readonly = true;
+				ns->persistent_ro = true;
+				ret = 0;
+			}
+		}
+		if (ret) {
+			pr_err("failed to open file %s: (%d)\n",
+			       ns->device_path, ret);
+			ns->file = NULL;
+			return ret;
+		}
 	}
 
 	nvmet_file_ns_revalidate(ns);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 29ae0657ba8f..166add3c119f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -103,6 +103,7 @@ struct nvmet_ns {
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;
+	bool			persistent_ro;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
-- 
2.35.3


