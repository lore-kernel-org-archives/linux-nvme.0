Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F760C369C9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ORdm4L5XXQJ7LuIOQwPDU0sIVETiNjXowPk1kMCt0lc=; b=iCZ3BKOSoLb3Rsib/XWTqkim+W
	6nc0J9CONrY8ijlk2f+YzTL4ZcjLDe+Zwz3PeHYLALDxaxdpbFbPIueA1J4TcQ4ZioHATb6qGmKi+
	TxltwxjrTNVtqkO1RFqgF5fmfrQXMdq3z3GCS1DJTZXCemUgAV3mO0rgHilkWtxQDrbHyyCKlJXa7
	HP4kPZs83Q0zfdO7Ah52gidq/c/jm1y40wj5cZOnJyMAt08A2nmLg0XZwDgMzE83kpAjHK/NIp1kK
	ZsGSqqdwnLHLY6SrukcmV75udR3cMQa9oN2OniUv0VslegJOETgeOFfvevKCBJIghkQ2HKji2Uo1w
	TNGOT51w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hjC-0000000FipJ-04Hz;
	Fri, 18 Apr 2025 09:09:42 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hiG-0000000Fidk-10aN
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 09:08:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 38892294730;
	Fri, 18 Apr 2025 11:08:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NiCcYCPQPpgA; Fri, 18 Apr 2025 11:08:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B0BF9298566;
	Fri, 18 Apr 2025 11:08:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aOVaWmjy7AMw; Fri, 18 Apr 2025 11:08:40 +0200 (CEST)
Received: from anvil.corp.sigma-star.at (84-115-238-41.cable.dynamic.surfer.at [84.115.238.41])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 4A5B3294730;
	Fri, 18 Apr 2025 11:08:40 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de,
	upstream+nvme@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH] nvmet: Make blksize_shift configurable
Date: Fri, 18 Apr 2025 11:08:34 +0200
Message-ID: <20250418090834.2755289-1-richard@nod.at>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_020844_556336_AE1DF60E 
X-CRM114-Status: GOOD (  12.92  )
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
 drivers/nvme/target/configfs.c    | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  4 +++-
 drivers/nvme/target/io-cmd-file.c | 15 +++++++++------
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
index e44ef69dffc2..2fd9cc3b1d00 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -797,6 +797,35 @@ static ssize_t nvmet_ns_resv_enable_store(struct con=
fig_item *item,
 }
 CONFIGFS_ATTR(nvmet_ns_, resv_enable);
=20
+static ssize_t nvmet_ns_blksize_shift_show(struct config_item *item, cha=
r *page)
+{
+	return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->blksize_shift);
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
@@ -806,6 +835,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] =3D=
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
index 83be0657e6df..a86010af4670 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -100,7 +100,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	}
 	ns->bdev =3D file_bdev(ns->bdev_file);
 	ns->size =3D bdev_nr_bytes(ns->bdev);
-	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	if (!ns->blksize_shift)
+		ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
=20
 	ns->pi_type =3D 0;
 	ns->metadata_size =3D 0;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
index 2d068439b129..5893b64179fb 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,12 +49,15 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
=20
 	nvmet_file_ns_revalidate(ns);
=20
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift =3D min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+	if (!ns->blksize_shift) {
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
2.48.1


