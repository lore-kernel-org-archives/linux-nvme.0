Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1FC25B07
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFDrbwl1OghudBrhZ8bM3Vo53Lyi9PUTsA+MOO0ackM=; b=ZFlElKgT12zh05nskYdSBKA8Ge
	jjctrJwEmRDNHsi/5y+uRnokBt94F+/1Djb1BVs05enwdsg3IKC5yVa1ApP9BKT7kCRmuM+F93AoP
	lPX1d/oTbo+KSUi0IRMZY4uWo+6kQ9Hh3yTH6hBI3rimdDWSjLWft5Vb0oDqMYVM+r3+IWfLF9eXt
	49GqPLrjSmV+/yet1WDPOCuKEkiaIFd22ETCn1n9Qm87G2JmxlXiJY28tIE3JGvUYCKjntdRaZhoL
	0OXhPY6a9RNkM4UwrgijWGpHC0rNF02cyCXp/vEdUkffIgc3wHhbYGZd8kDocHdwTiVHe5hbtYHvj
	DGkmPc7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08y-00Gic7-GX; Fri, 05 Aug 2022 16:25:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08W-00GiOc-4C
	for linux-nvme@bombadil.infradead.org; Fri, 05 Aug 2022 16:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SFDrbwl1OghudBrhZ8bM3Vo53Lyi9PUTsA+MOO0ackM=; b=gwV2b0VDifAc7eQ+4B7Vj2pSsu
	8WV05ktB0+9Ohq0Go62kikAAzyQxdZ9y/h9zo7VZ1LhhN7cvS3NKcGKpbyjpoYMjKjP74GetXrXZd
	wkA3fQuWW+jZWRRZpJN8ZCOYkLm7qAAxsNBLgZJ0NOYRRB629jvX42pvl8Xd2T8Kv73QdhTSmRCzg
	nxzs8GeC0yEJ7zGW4zEr7vRVQXWipKAarEXZqLD20q7sZK+XJTiuHaMAj5dLHDIT79XB1k2svxweJ
	EPcMcb9Vu+M7sW6tP8wLYvokR/ZuC30Xn4r2YxY4DeU1zdzuwH69GimbXiPs6/Tpnte+rZQ+Ubv30
	/WVKkYcA==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08P-003IhD-Pj
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 16:25:18 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G7Kwk002713
	for <linux-nvme@lists.infradead.org>; Fri, 5 Aug 2022 09:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SFDrbwl1OghudBrhZ8bM3Vo53Lyi9PUTsA+MOO0ackM=;
 b=K66/ajyfhoMGFqyKlRGwzYoQPV9ti373+Vl1CyXGcnEaSqcsa6LwkWBK/xibBpFnxwX1
 VcmWECqJXl6IondSLBp/qCnOLJgT91QouX7JZDwlVER7H1uFKx/MBwi1QxdMrvSw9aig
 fPxAwGQIf5cX2K6tZTsqhxiwQaxa2RUi5cM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hrfvf84f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 09:25:04 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:25:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 649997037501; Fri,  5 Aug 2022 09:24:45 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/7] file: add ops to dma map bvec
Date: Fri, 5 Aug 2022 09:24:39 -0700
Message-ID: <20220805162444.3985535-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220805162444.3985535-1-kbusch@fb.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: r7DYMGuoY3HaWFiwTB9X4Tmosi_iN-eO
X-Proofpoint-ORIG-GUID: r7DYMGuoY3HaWFiwTB9X4Tmosi_iN-eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_08,2022-08-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_172514_584888_050C60F2 
X-CRM114-Status: GOOD (  19.75  )
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

From: Keith Busch <kbusch@kernel.org>

The same buffer may be used for many subsequent IO's. Instead of setting
up the mapping per-IO, provide an interface that can allow a buffer to
be premapped just once and referenced again later, and implement for the
block device file.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c       | 20 ++++++++++++++++++++
 fs/file.c          | 15 +++++++++++++++
 include/linux/fs.h | 20 ++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 29066ac5a2fa..db2d1e848f4b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -670,6 +670,22 @@ static long blkdev_fallocate(struct file *file, int =
mode, loff_t start,
 	return error;
 }
=20
+#ifdef CONFIG_HAS_DMA
+void *blkdev_dma_map(struct file *filp, struct bio_vec *bvec, int nr_vec=
s)
+{
+	struct block_device *bdev =3D filp->private_data;
+
+	return block_dma_map(bdev, bvec, nr_vecs);
+}
+
+void blkdev_dma_unmap(struct file *filp, void *dma_tag)
+{
+	struct block_device *bdev =3D filp->private_data;
+
+	return block_dma_unmap(bdev, dma_tag);
+}
+#endif
+
 const struct file_operations def_blk_fops =3D {
 	.open		=3D blkdev_open,
 	.release	=3D blkdev_close,
@@ -686,6 +702,10 @@ const struct file_operations def_blk_fops =3D {
 	.splice_read	=3D generic_file_splice_read,
 	.splice_write	=3D iter_file_splice_write,
 	.fallocate	=3D blkdev_fallocate,
+#ifdef CONFIG_HAS_DMA
+	.dma_map	=3D blkdev_dma_map,
+	.dma_unmap	=3D blkdev_dma_unmap,
+#endif
 };
=20
 static __init int blkdev_init(void)
diff --git a/fs/file.c b/fs/file.c
index 3bcc1ecc314a..767bf9d3205e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1307,3 +1307,18 @@ int iterate_fd(struct files_struct *files, unsigne=
d n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+#ifdef CONFIG_HAS_DMA
+void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs)
+{
+	if (file->f_op->dma_map)
+		return file->f_op->dma_map(file, bvec, nr_vecs);
+	return ERR_PTR(-EINVAL);
+}
+
+void file_dma_unmap(struct file *file, void *dma_tag)
+{
+	if (file->f_op->dma_unmap)
+		return file->f_op->dma_unmap(file, dma_tag);
+}
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9f131e559d05..8652bad763f3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2092,6 +2092,10 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
=20
+#ifdef CONFIG_HAS_DMA
+struct bio_vec;
+#endif
+
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -2134,6 +2138,10 @@ struct file_operations {
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags)=
;
+#ifdef CONFIG_HAS_DMA
+	void *(*dma_map)(struct file *, struct bio_vec *, int);
+	void (*dma_unmap)(struct file *, void *);
+#endif
 } __randomize_layout;
=20
 struct inode_operations {
@@ -3595,4 +3603,16 @@ extern int vfs_fadvise(struct file *file, loff_t o=
ffset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
=20
+#ifdef CONFIG_HAS_DMA
+void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs)=
;
+void file_dma_unmap(struct file *file, void *dma_tag);
+#else
+static inline void *file_dma_map(struct file *file, struct bio_vec *bvec=
,
+				 int nr_vecs)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+static inline void file_dma_unmap(struct file *file, void *dma_tag) {}
+#endif
+
 #endif /* _LINUX_FS_H */
--=20
2.30.2


