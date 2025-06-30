Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6277C8302F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YksxM+AbQ7ICfaWvFK0R+Tcz00cCXzjTXV4WFd+obyI=; b=DtHctmqfE0D3TacQu9ajgyQ6Kd
	4K7cUouLkvmldDT3t2m1Glc/EGtLLjNJMfSZxin98GBr7FmWUErR9MbUq19PJGFz2b2cuscTVD9FE
	0gGnXv4+9ATc/0BkBDs85LQW+YcC4QjYdETuIuz2xKVBnFdH5bInG/U2Tin6RZLhB7NdZrQdAsfIz
	LVIhOpWQJqCyTtQYPP6qthhhtMZOxeHdD4y0sZQtpxHtLrYanhqvb3Xpk2vEZSE8Ee8J57+L1WT79
	bWAfMgwW9pOYN1iKm+/7M9X8ACwcWc+DZM7oXMO1ugQt/0DvHBrTQTdySDPWSU/Yqml4pX3UrZdBN
	GJ+Fge+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWMAG-00000003Uyc-24vq;
	Mon, 30 Jun 2025 21:35:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWJxW-00000003Gim-1o6a
	for linux-nvme@bombadil.infradead.org;
	Mon, 30 Jun 2025 19:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YksxM+AbQ7ICfaWvFK0R+Tcz00cCXzjTXV4WFd+obyI=; b=ixVQpUvcg+MH4w0WpRIzp0833U
	r6zXhmQGNkPWjfebYQ7JbJyNO/ASNUhoVerpHPrXwgy8J6aWN6/ywykRylwvz2sWNN+5+e+MBthGF
	GH0YEqA2MQw2Y/j119IhKo5uGHcEaUqdSGNnwSTPh2sTBErs9Bu1soN41kM+GK8qw3ACEC8sX60PM
	MjEThuMdDcz2SFcwaDt3U80K3vxkQniyh3wrb9FNJwgiXe7Am6/KCiElFb1t3uxJiOneR7Nrhcy4U
	Bxg3b9EHvtlM4BO1AENF5fXcXG2+3hPGI46EHjDj6oaVfXD+uUwO+aYCyZL+Vly5YD5IEIpvF7no2
	owBPuRGw==;
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWJx1-00000006sL7-3x5v
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 19:14:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C4A8728FA02;
	Mon, 30 Jun 2025 21:13:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YZ7k-ld464wG; Mon, 30 Jun 2025 21:13:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 56F8C2A7F55;
	Mon, 30 Jun 2025 21:13:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9plolHkoNwC4; Mon, 30 Jun 2025 21:13:48 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (85-127-104-84.dsl.dynamic.surfer.at [85.127.104.84])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EBC382A7F43;
	Mon, 30 Jun 2025 21:13:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de,
	dlemoal@kernel.org,
	upstream+nvme@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] nvmet: Make blksize_shift configurable
Date: Mon, 30 Jun 2025 21:13:41 +0200
Message-ID: <20250630191341.1263000-1-richard@nod.at>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_201409_249786_9453C9C5 
X-CRM114-Status: GOOD (  17.14  )
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

Currently, the block size is automatically configured, and for
file-backed namespaces it is likely to be 4K.
While this is a reasonable default for modern storage, it can
cause confusion if someone wants to export a pre-created disk image
that uses a 512-byte block size.
As a result, partition parsing will fail.

So, just like we already do for the loop block device, let the user
configure the block size if they know better.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Changes since v1 (RFC)[0]:

- Make sure blksize_shift is in general within reason
- In the bdev case and when using direct IO, blksize_shift has to be
  smaller than the logical block it the device
- In the file case and when using direct IO try to use STATX_DIOALIGN,
  just like the loop device does

[0] https://lore.kernel.org/linux-nvme/20250418090834.2755289-1-richard@n=
od.at/

Thanks,
//richard
---
 drivers/nvme/target/configfs.c    | 37 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 13 ++++++++++-
 drivers/nvme/target/io-cmd-file.c | 28 ++++++++++++++++++-----
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
index e44ef69dffc24..26175c37374ab 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -797,6 +797,42 @@ static ssize_t nvmet_ns_resv_enable_store(struct con=
fig_item *item,
 }
 CONFIGFS_ATTR(nvmet_ns_, resv_enable);
=20
+static ssize_t nvmet_ns_blksize_shift_show(struct config_item *item, cha=
r *page)
+{
+	return sysfs_emit(page, "%u\n", to_nvmet_ns(item)->blksize_shift);
+}
+
+static ssize_t nvmet_ns_blksize_shift_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns =3D to_nvmet_ns(item);
+	u32 shift;
+	int ret;
+
+	ret =3D kstrtou32(page, 0, &shift);
+	if (ret)
+		return ret;
+
+	/*
+	 * Make sure block size is within reason, something between 512 and
+	 * BLK_MAX_BLOCK_SIZE.
+	 */
+	if (shift < 9 || shift > 16)
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("the ns:%d is already enabled.\n", ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+	ns->blksize_shift =3D shift;
+	mutex_unlock(&ns->subsys->lock);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_ns_, blksize_shift);
+
 static struct configfs_attribute *nvmet_ns_attrs[] =3D {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -806,6 +842,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] =3D=
 {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+	&nvmet_ns_attr_blksize_shift,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
index eba42df2f8215..be39837d4d792 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -77,6 +77,7 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet=
_ns *ns)
=20
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
+	int bdev_blksize_shift;
 	int ret;
=20
 	/*
@@ -100,7 +101,17 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	}
 	ns->bdev =3D file_bdev(ns->bdev_file);
 	ns->size =3D bdev_nr_bytes(ns->bdev);
-	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
+	bdev_blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	if (ns->blksize_shift) {
+		if (ns->blksize_shift < bdev_blksize_shift) {
+			pr_err("Configured blksize_shift needs to be at least %d for device %=
s\n",
+				bdev_blksize_shift, ns->device_path);
+			return -EINVAL;
+		}
+	} else {
+		ns->blksize_shift =3D bdev_blksize_shift;
+	}
=20
 	ns->pi_type =3D 0;
 	ns->metadata_size =3D 0;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
index 2d068439b129c..a4066b5a1dc97 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,12 +49,28 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
=20
 	nvmet_file_ns_revalidate(ns);
=20
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift =3D min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+	if (ns->blksize_shift) {
+		if (!ns->buffered_io) {
+			struct block_device *sb_bdev =3D ns->file->f_mapping->host->i_sb->s_b=
dev;
+			struct kstat st;
+
+			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
+			    (st.result_mask & STATX_DIOALIGN) &&
+			    (1 << ns->blksize_shift) < st.dio_offset_align)
+				return -EINVAL;
+
+			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(sb_b=
dev)))
+				return -EINVAL;
+		}
+	} else {
+		/*
+		 * i_blkbits can be greater than the universally accepted
+		 * upper bound, so make sure we export a sane namespace
+		 * lba_shift.
+		 */
+		ns->blksize_shift =3D min_t(u8,
+				file_inode(ns->file)->i_blkbits, 12);
+	}
=20
 	ns->bvec_pool =3D mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_sla=
b,
 			mempool_free_slab, nvmet_bvec_cache);
--=20
2.49.0


