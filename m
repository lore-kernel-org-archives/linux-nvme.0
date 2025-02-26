Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA14AC021BC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y0Y/ECEqgQaIDn98rUw+oY23UvTFuskrGecxUwUlobU=; b=CIIt8SGxdYEz86Cb/Xrl63jct4
	A94UJ+92jpsYdQljtgfplLBkVmXmfqQ7Zo+G4gvBNCcMSkG0/sUsCHnTp2mhn3Gr9fgBknsvZ+5DJ
	ha+6vhQybnmbPO+YMW2V5dM4qNWNKYee1tQ29m3dV324MoQEu+0Wn1OSfzOdAd4JAhgv4g0IHcruH
	M79RfCGBSY0QBK+J1x8oW77nSWd/AbWMg/9YujclR6ZcFzCtrUkn/mF/C8SjxMPkbkBXZbYAYFnNW
	DUChxSwKVAZXHb0YLrT6B70PKIaIsmDgWe3j+GXTgN3AM/93oxghhEc766KsHH3Xr91scosv1EWa0
	a/DSD74w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrS-00000004qn3-0nAh;
	Wed, 26 Feb 2025 18:10:22 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrP-00000004qiv-012u
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:10:20 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBHDHm021853
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=y0Y/ECEqgQaIDn98rUw+oY23UvTFuskrGecxUwUlobU=; b=LsIjd3CVm6gf
	yK8zsCuuexFlrR3Qbbn9V9LS13S1grjlNFxGf4cUZ8lc+YczMCBS8xSnHhR32huR
	2u1qUrlbwa2vqW9WZRZkwnIb6JKBxZv9C9xXHFKvH6QquFlwAPhgHqTkBak/o+pb
	dFrKpOXMh8/xsuowWotXr7xY285iPANM9FZgf3HI3c71mX1WheWekJ1Z5jgSc+xb
	yTjtCz1f7Vl9VJTwTu4a++MNi08Lx1pCAda4/JK+VvuQi3bL3Sk+Rat6Na//J3ug
	c5sZMXCm5Qzk5Jb1dSFwMBPqgWyDLWOCADwoD/cUwPL2Mc0mIG9ggQObhqoZzYuh
	nXTRN8a7Mw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4521xrjngk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:18 -0800 (PST)
Received: from twshared8234.09.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:10:04 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BCEAD187C4AD8; Wed, 26 Feb 2025 10:10:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 2/6] io_uring: add support for kernel registered bvecs
Date: Wed, 26 Feb 2025 10:09:54 -0800
Message-ID: <20250226181002.2574148-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
References: <20250226181002.2574148-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HhIM9X4KZz9_RbMfEPFQ20ZapjOXBsIR
X-Proofpoint-ORIG-GUID: HhIM9X4KZz9_RbMfEPFQ20ZapjOXBsIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_101019_057063_51175AFE 
X-CRM114-Status: GOOD (  26.46  )
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

Provide an interface for the kernel to leverage the existing
pre-registered buffers that io_uring provides. User space can reference
these later to achieve zero-copy IO.

User space must register an empty fixed buffer table with io_uring in
order for the kernel to make use of it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring/cmd.h |   7 ++
 io_uring/io_uring.c          |   3 +
 io_uring/rsrc.c              | 122 +++++++++++++++++++++++++++++++++--
 io_uring/rsrc.h              |   8 +++
 4 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 87150dc0a07cf..cf8d80d847344 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -4,6 +4,7 @@
=20
 #include <uapi/linux/io_uring.h>
 #include <linux/io_uring_types.h>
+#include <linux/blk-mq.h>
=20
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
@@ -125,4 +126,10 @@ static inline struct io_uring_cmd_data *io_uring_cmd=
_get_async_data(struct io_ur
 	return cmd_to_io_kiocb(cmd)->async_data;
 }
=20
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
+			    void (*release)(void *), unsigned int index,
+			    unsigned int issue_flags);
+void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int in=
dex,
+			       unsigned int issue_flags);
+
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index db1c0792def63..31e936d468051 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3947,6 +3947,9 @@ static int __init io_uring_init(void)
=20
 	io_uring_optable_init();
=20
+	/* imu->perm is u8 */
+	BUILD_BUG_ON((IO_IMU_DEST | IO_IMU_SOURCE) > U8_MAX);
+
 	/*
 	 * Allow user copy in the per-command field, which starts after the
 	 * file in io_kiocb and until the opcode field. The openat2 handling
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f814526982c36..5b234e84dcba6 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -9,6 +9,7 @@
 #include <linux/hugetlb.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
=20
 #include <uapi/linux/io_uring.h>
=20
@@ -104,14 +105,21 @@ int io_buffer_validate(struct iovec *iov)
 static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node=
 *node)
 {
 	struct io_mapped_ubuf *imu =3D node->buf;
-	unsigned int i;
=20
 	if (!refcount_dec_and_test(&imu->refs))
 		return;
-	for (i =3D 0; i < imu->nr_bvecs; i++)
-		unpin_user_page(imu->bvec[i].bv_page);
-	if (imu->acct_pages)
-		io_unaccount_mem(ctx, imu->acct_pages);
+
+	if (imu->release) {
+		imu->release(imu->priv);
+	} else {
+		unsigned int i;
+
+		for (i =3D 0; i < imu->nr_bvecs; i++)
+			unpin_user_page(imu->bvec[i].bv_page);
+		if (imu->acct_pages)
+			io_unaccount_mem(ctx, imu->acct_pages);
+	}
+
 	kvfree(imu);
 }
=20
@@ -761,6 +769,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(st=
ruct io_ring_ctx *ctx,
 	imu->len =3D iov->iov_len;
 	imu->nr_bvecs =3D nr_pages;
 	imu->folio_shift =3D PAGE_SHIFT;
+	imu->release =3D NULL;
+	imu->priv =3D NULL;
+	imu->perm =3D IO_IMU_DEST	| IO_IMU_SOURCE;
 	if (coalesced)
 		imu->folio_shift =3D data.folio_shift;
 	refcount_set(&imu->refs, 1);
@@ -857,6 +868,94 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx,=
 void __user *arg,
 	return ret;
 }
=20
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
+			    void (*release)(void *), unsigned int index,
+			    unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
+	struct io_rsrc_data *data =3D &ctx->buf_table;
+	struct req_iterator rq_iter;
+	struct io_mapped_ubuf *imu;
+	struct io_rsrc_node *node;
+	struct bio_vec bv, *bvec;
+	u16 nr_bvecs;
+	int ret =3D 0;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	if (index >=3D data->nr) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
+	index =3D array_index_nospec(index, data->nr);
+
+	if (data->nodes[index]) {
+		ret =3D -EBUSY;
+		goto unlock;
+	}
+
+	node =3D io_rsrc_node_alloc(IORING_RSRC_BUFFER);
+	if (!node) {
+		ret =3D -ENOMEM;
+		goto unlock;
+	}
+
+	nr_bvecs =3D blk_rq_nr_phys_segments(rq);
+	imu =3D kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_KERNEL);
+	if (!imu) {
+		kfree(node);
+		ret =3D -ENOMEM;
+		goto unlock;
+	}
+
+	imu->ubuf =3D 0;
+	imu->len =3D blk_rq_bytes(rq);
+	imu->acct_pages =3D 0;
+	imu->folio_shift =3D PAGE_SHIFT;
+	imu->nr_bvecs =3D nr_bvecs;
+	refcount_set(&imu->refs, 1);
+	imu->release =3D release;
+	imu->priv =3D rq;
+
+	if (op_is_write(req_op(rq)))
+		imu->perm =3D IO_IMU_SOURCE;
+	else
+		imu->perm =3D IO_IMU_DEST;
+
+	bvec =3D imu->bvec;
+	rq_for_each_bvec(bv, rq, rq_iter)
+		*bvec++ =3D bv;
+
+	node->buf =3D imu;
+	data->nodes[index] =3D node;
+unlock:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
+
+void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int in=
dex,
+			       unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
+	struct io_rsrc_data *data =3D &ctx->buf_table;
+	struct io_rsrc_node *node;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	if (index >=3D data->nr)
+		goto unlock;
+	index =3D array_index_nospec(index, data->nr);
+
+	node =3D data->nodes[index];
+	if (!node || !node->buf->release)
+		goto unlock;
+
+	io_put_rsrc_node(ctx, node);
+	data->nodes[index] =3D NULL;
+unlock:
+	io_ring_submit_unlock(ctx, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
+
 static int io_import_fixed(int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
 			   u64 buf_addr, size_t len)
@@ -871,6 +970,8 @@ static int io_import_fixed(int ddir, struct iov_iter =
*iter,
 	/* not inside the mapped region */
 	if (unlikely(buf_addr < imu->ubuf || buf_end > (imu->ubuf + imu->len)))
 		return -EFAULT;
+	if (!(imu->perm & (1 << ddir)))
+		return -EFAULT;
=20
 	/*
 	 * Might not be a start of buffer, set size appropriately
@@ -883,8 +984,8 @@ static int io_import_fixed(int ddir, struct iov_iter =
*iter,
 		/*
 		 * Don't use iov_iter_advance() here, as it's really slow for
 		 * using the latter parts of a big fixed buffer - it iterates
-		 * over each segment manually. We can cheat a bit here, because
-		 * we know that:
+		 * over each segment manually. We can cheat a bit here for user
+		 * registered nodes, because we know that:
 		 *
 		 * 1) it's a BVEC iter, we set it up
 		 * 2) all bvecs are the same in size, except potentially the
@@ -898,8 +999,15 @@ static int io_import_fixed(int ddir, struct iov_iter=
 *iter,
 		 */
 		const struct bio_vec *bvec =3D imu->bvec;
=20
+		/*
+		 * Kernel buffer bvecs, on the other hand, don't necessarily
+		 * have the size property of user registered ones, so we have
+		 * to use the slow iter advance.
+		 */
 		if (offset < bvec->bv_len) {
 			iter->iov_offset =3D offset;
+		} else if (imu->release) {
+			iov_iter_advance(iter, offset);
 		} else {
 			unsigned long seg_skip;
=20
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index f0e9080599646..9668804afddc4 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -20,6 +20,11 @@ struct io_rsrc_node {
 	};
 };
=20
+enum {
+	IO_IMU_DEST	=3D 1 << ITER_DEST,
+	IO_IMU_SOURCE	=3D 1 << ITER_SOURCE,
+};
+
 struct io_mapped_ubuf {
 	u64		ubuf;
 	unsigned int	len;
@@ -27,6 +32,9 @@ struct io_mapped_ubuf {
 	unsigned int    folio_shift;
 	refcount_t	refs;
 	unsigned long	acct_pages;
+	void		(*release)(void *);
+	void		*priv;
+	u8		perm;
 	struct bio_vec	bvec[] __counted_by(nr_bvecs);
 };
=20
--=20
2.43.5


