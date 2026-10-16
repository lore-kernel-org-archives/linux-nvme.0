Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1D9CCA464
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HtjzVVsA6JArz1B6fu2Ta+i9SWusgx63z4Tf4QofPAI=; b=w1QI1HF7vRYVr7SpHyU6jO3EYi
	U0vOrdHmCgTpcZiJMzef59cD+rlXEkUH48rxDB7AdPeO7E+k/PGsxVSdk6fGdzmvvlF53t8yMvXnw
	5XQxln15lXuwXEfAg6Z76k39m4P2WSetbaYf4al2wtU09YCwEarEBSfP68FgK2edWCne7ENygS62T
	6jTjiRx1k3xKi9UZRx9IRLq/N2BALdX1TO24J1PovRw3LQbo+TPSu48mW/scWKPl4HlthCYnlAsF4
	1lhzqzMX+oX908/V5ci52AquRF/Q9NhnQFRy1EqsADX138knbxLg+KrD/LAg0+9nbKKtpxakynZiL
	0varTHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHfHI-00000002enp-1NsL;
	Fri, 16 Oct 2026 10:35:08 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHfHG-00000002emw-054z
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 10:35:07 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-3514b90bb89so5570838eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146905; x=1792751705; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtjzVVsA6JArz1B6fu2Ta+i9SWusgx63z4Tf4QofPAI=;
        b=cW7mJF5dhmmuSkabtXga5QmuHANB4rBVnv3UvkO4ZDz3vDeK7ND2+QmcfN8/c2i0gn
         vqFhqX1XpIT2X1LFdG3E2V5NiGXC19zV35ed7mUZzY+RI8bchWBcJab6FJRf5m6Z+YLb
         y5b2b+ThC5f51cVU4WvvuYYPleA0e3Yo9b7a5ypMM9C0Z9dqmF8B7bKYf2ySaofqYwDJ
         bTjQQlpZMbqt+y/25l8+DvMvLorRaTqOvgeom4NdzsnbwyqyXnbi1GgJk1HqhIn0GYJe
         TXiEfxrNxmKZ/bnlFikWckONvOk7CG2BmYx45Otjl/kvrx6TIgW3L2BKSAipWjxSU+eS
         9R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146905; x=1792751705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtjzVVsA6JArz1B6fu2Ta+i9SWusgx63z4Tf4QofPAI=;
        b=EQduBjO21Iy/MnOc2SVdloJFUNg150IbfZ+BKimuuPBnfHpKqNfbkFsw7Ao9uWcaKs
         9XPs+iFsQ5AF5B0Bc5smp1Vk/VNUDfosyl8JZioULJQCF8B77eM+k7a2WMS2gyawz+nd
         2Y2pF7bDCqGMvj1IW1Fpe8CP7u6Id1k5VDrcr7ogVPoYY/tKy+wcy7XOTKFBtHYFUDFB
         OmR13m9jkdVYhEraz22TE+EYt/cAU9wH3rjD+InoReuT+AeLq4s0qbmxmGxZL54r8mUq
         pXEQbAUVfigXZnkXDfONF4LjyCbcLSGpXltgE2coI6rdkJqCpjRI/xm0fOJvPz+p+66e
         fVpg==
X-Forwarded-Encrypted: i=1; AKwUvByWe4XAt/SBe3VDmD7oOFZeBQbHVViSKFQ8/bm1kL68T/QOCUNi9rLns/jVEbFCSnYRFXXw/qPUg8Wd@lists.infradead.org
X-Gm-Message-State: AFq9FYKr+xFsLHVOxNagZFSoyftVHctapdo/vHvtuKzrPpK+rIbiHlfd
	TcXyDtqN8voL5NiMsrl9oClz+1uyjNGxsLxeiEAThr76xB+idNxyzTs=
X-Gm-Gg: AYBFou1tzR7ZXoUwNQwbaqziiw1FCcsOyx18yrJD92bra2WL4H5cCJgVJevyiCNsMFf
	W6rNKxQjNPIy9fDWWxY0PFGbwj2hlGvhzIGdFcYXyutitblqMJBfMlxYb2i7hZgcsbNJA5xR0c1
	QeG5uXyIKbngz3UTg1YeFU1ibkJMYcYU9L/CUR7cXJMLv3IX6dHavmH3A3prvls0F43J1S1rASx
	4sysfx/IVcyFnRyV8kHA7yHPhAH2cqnuWRRrVAgSFQqQOnPGjd28WigysbcTEtCdRRmzW3z5a7m
	NHuzY/UxD330j+8/Z2u79/C2x1THWLpV42TSqqyDIHTs59x4mRs89rxmNx6s+Z1LP4kA7KGMi+7
	BOxRwaL+kLAQYmg3OWc/2CCJFkfEIgRB9EWGRJOtLdPow0TwaDaYZ2tyZY0OMoUkhvQXkLVTBy4
	iJHcX7raGcYrXr1X9DgmMLmBCioGpA4hkbeGYQY35qITXoao7RqdbCLssEfZAC/8C8Wskl6eHns
	gsp9MY/pojsIGVQhUQAj7K/2BNIYTHvCgwX96OiahfhvgfYmi8=
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id 5a478bee46e88-35a47edc590mr19750851eec.37.1792146904412;
        Fri, 16 Oct 2026 03:35:04 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm6213192eec.7.2026.10.16.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:35:03 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: asml.silence@gmail.com,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
Date: Fri, 16 Oct 2026 16:04:20 +0530
Message-ID: <20261016103453.1129150-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_033506_070272_A9F484DD 
X-CRM114-Status: GOOD (  17.47  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Allow registering a dma-buf against an NVMe namespace character device
and using it as the data buffer of fixed uring_cmd passthrough I/O.

io_uring_cmd_import_fixed() now accepts dma-buf buffers and attaches
the current map. blk_rq_map_user_iov() maps dma-buf iterators directly,
since they cannot fall back to a bounce copy.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c              |  9 ++++++++-
 drivers/nvme/host/core.c     | 13 +++++++++++++
 drivers/nvme/host/ioctl.c    |  1 +
 include/linux/io_uring/cmd.h |  6 ++++++
 io_uring/uring_cmd.c         | 16 +++++++++++++++-
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..8f03e21fd5fe 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,7 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-/* Prepare bio for passthrough IO given ITER_BVEC iter */
+/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
@@ -506,6 +506,13 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct iov_iter i;
 	int ret = -EINVAL;
 
+	if (iov_iter_is_dmabuf_map(iter)) {
+		if (map_data || (iov_iter_alignment(iter) & align))
+			return -EINVAL;
+		ret = blk_rq_map_user_bvec(rq, iter);
+		return ret == -EREMOTEIO ? -EINVAL : ret;
+	}
+
 	if (map_data)
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d81462e864a4..29c29dad06b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3982,6 +3982,18 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
+					   struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
+					  struct nvme_ns, cdev);
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (!ctrl->ops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 static const struct file_operations nvme_ns_chr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_ns_chr_open,
@@ -3990,6 +4002,7 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.init_dma_buf_io_ctx = nvme_ns_chr_init_dma_buf_io_ctx,
 };
 
 static void nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..6343da1f6c05 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 			status = blk_status_to_errno(err);
 	}
 	io_uring_cmd_set_res32(ioucmd, status, result);
+	io_uring_cmd_detach_dmabuf(ioucmd);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index e18d4af62e1a..33e0ebeea5a0 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -70,6 +70,7 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -136,6 +137,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
+{
+}
+
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
 				       unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 73b606899833..0e0509edec6f 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -10,6 +10,7 @@
 
 #include "io_uring.h"
 #include "alloc_cache.h"
+#include "dma-buf.h"
 #include "rsrc.h"
 #include "kbuf.h"
 #include "uring_cmd.h"
@@ -28,6 +29,7 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
 
+	io_detach_dmabuf_map(req);
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
@@ -48,6 +50,12 @@ void io_uring_cmd_cleanup(struct io_kiocb *req)
 	io_req_uring_cleanup(req, 0);
 }
 
+void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
+{
+	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_detach_dmabuf);
+
 bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx)
 {
@@ -257,6 +265,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
+		io_detach_dmabuf_map(req);
 		ioucmd->flags |= IORING_URING_CMD_REISSUE;
 		return ret;
 	}
@@ -275,11 +284,16 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      unsigned int issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	int ret;
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	ret = __io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags,
+				  IO_REGBUF_IMPORT_ALLOW_DMABUF);
+	if (ret)
+		return ret;
+	return io_attach_dmabuf_map(req, iter, issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0


