Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED33DC36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfjEq8IyL7/x/8c9RdusJ/wqPO/dcQUh+COX5jmkRnk=; b=3JbOlx2xmtNNkpgp/R+exyNAuN
	jGIZY41kK8oyA/OSg2Ml1Bw8xBjz39sxV2qxVrE2yxuAHPrG0wPs9xR4gF5ntnnanUzGo1cefaUuz
	W+UTF6AjbpYdBi1kJPP8nGnICm8BvHk3EZtd+/wHURT9qHUGXXWGJD9YLfDY5iNPA+DqxkjYjTIrB
	8EwCZbPoBEMq0YwtOPP5z6YOwB7QsrVb7i+rowL5c71VKfA9187Z3B04+Sk2fif93DC9iyC1Bxa9B
	2iH3PJo9l2GScRbrNBGTMjuFxLYG9/zXZgf+Mo+sOSqRqno2zM7hMlq99OekCdfJ0iphwx4AGUGzd
	1/scH21Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQE-0000000FuMc-4AEY;
	Fri, 21 Mar 2025 18:48:46 +0000
Received: from mail-qt1-x861.google.com ([2607:f8b0:4864:20::861])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQC-0000000FuLN-0D7m
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 18:48:45 +0000
Received: by mail-qt1-x861.google.com with SMTP id d75a77b69052e-4768a4fdf8cso1283991cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582923; x=1743187723; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfjEq8IyL7/x/8c9RdusJ/wqPO/dcQUh+COX5jmkRnk=;
        b=IwingnyKVpiPRsV8IBlq5nRRSOn5wqoiDnKy8XQH5BBK8xY4AhQLRSRMrYI063l18n
         cP6TY+bX9OYK9rbG9ZO56qBMXoQyxhTQbb9k1mSYW2bIEjVI1iK4MRJPEOFbYnGNVMbZ
         dl3Y79nlUXAes/ieXQHZ74e8tDZHSCT3KxMTq2pSWmwxD6cDmuD/cJRijc4ZPlmQUKQA
         +qI2pyUKPjMy9rZGaa2QdtjfTTE3mNJQtUeIDT2TM0o1ss/aX8EXMagkVd+mHDwg+IKn
         svgDRjXNQNnwniqDWkRpslgPVhHbQf5vk+U8tLa/5csYBEVQ+IwKhlM6cejuIpv4y7zZ
         naEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582923; x=1743187723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfjEq8IyL7/x/8c9RdusJ/wqPO/dcQUh+COX5jmkRnk=;
        b=qu12E80OOltL0Uo4Z2M6olD4rihKTO2ZoqGRcpN4LAnFJ1+/fsSsA6ouv7DACpwI1j
         PLXDBNLQyfqTCEoVGLMRb0PIWyb0lrDPMZMVNMDNKwU78vD5xLgvMB6eWSW50GlRbaA5
         CaCK9yoa9NFoxXuRjXvTc4qT65vcdV6h4eRGRzQnLulmUz0u/roFLOmwDN5rj5Rm7Icj
         XiOR52bttK5hHprG3nf4ZxMqPx6Eu3fsGyl6XrmLa1dd0j4+q5dqVjykdJlC5zqSU9AU
         aiGFLzXKu9HSX9ixvPqVXF1GDC9ZstTiyJgXZJgGmxqU/xQkvoGTzLT3jPfFaTtpvk3A
         UkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9D/dnvJ48E0T6peC3FBXjlpt39GZEKR+SWM1IN+Y9QdCj08NwwyPgZqJ30qZ/iq8JARibfRYdmYl1@lists.infradead.org
X-Gm-Message-State: AOJu0YyapDdzlu6pjnq0FqvuX6KygK8Z/5szq5VNBzfmEuXCDFSWlfxV
	cbIaO/1qOUmnqnJXuKlx0kgaByx+zbodMoGu8vdUMT+xHJfMhxh3BxMbZF7/lAb3Ke6bFts0ntQ
	zUFD0ABHjQnRq9MW+XAGvN+VViK+tBQB4
X-Gm-Gg: ASbGncsIc5SkQZaOC+gvhE+bgB5HHCCX0/wws+hp5xseBOSi25b9JjfF1UzwwqJrXN4
	byHdSgI1fM04zaI8obEe4FgTb9DHMpggYANLFqWn8dRO43vtLBmAO7lWQ4PGqHSyAyRymf2Dd/6
	FQPxJewYr/EPuHvQCWzlv31qS64IwkR7VFnXQYUgq0sl7N+zstvBvyPlubwXE5PmNefCViScCkz
	lK9lloUrTvX0cwNi613JJ4G8/SiPCpDTXJk49ElL5hJKYMI77bWw3B4qCs+tuXq7qjDnuTuSnnW
	PLmaSGdCeG74UjJKWT1DmQ/W77jeVfIo3X0oheKAF+j59Kw6
X-Google-Smtp-Source: AGHT+IGmTdCvB1188jBMmyDMG3MYl9833lk8K/s6kZSo8qwO5x/RMDQKhQyV5LroO0Dqzra7vD1ZM+pBTfVD
X-Received: by 2002:ad4:5c8c:0:b0:6d8:e6be:50fc with SMTP id 6a1803df08f44-6eb3f2ec191mr22803036d6.6.1742582922650;
        Fri, 21 Mar 2025 11:48:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eb3efaa3a3sm1211626d6.35.2025.03.21.11.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:48:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 66D26340245;
	Fri, 21 Mar 2025 12:48:41 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 628F1E4195E; Fri, 21 Mar 2025 12:48:41 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going async
Date: Fri, 21 Mar 2025 12:48:19 -0600
Message-ID: <20250321184819.3847386-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_114844_089868_3C065862 
X-CRM114-Status: GOOD (  21.72  )
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

For uring_cmd operations with fixed buffers, the fixed buffer lookup
happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
implementation. A ->uring_cmd() implementation could return -EAGAIN on
the initial issue for any reason before io_uring_cmd_import_fixed().
For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
which can return -EAGAIN if all tags in the tag set are in use.
This ordering difference is observable when using
UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table.
If the uring_cmd is followed by a UBLK_U_IO_UNREGISTER_IO_BUF operation
that unregisters the fixed buffer, the uring_cmd going async will cause
the fixed buffer lookup to fail because it happens after the unregister.

Move the fixed buffer lookup out of io_uring_cmd_import_fixed() and
instead perform it in io_uring_cmd() before calling ->uring_cmd().
io_uring_cmd_import_fixed() now only initializes an iov_iter from the
existing fixed buffer node. This division of responsibilities makes
sense as the fixed buffer lookup is an io_uring implementation detail
and independent of the ->uring_cmd() implementation. It also cuts down
on the need to pass around the io_uring issue_flags.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 drivers/nvme/host/ioctl.c    | 10 ++++------
 include/linux/io_uring/cmd.h |  6 ++----
 io_uring/rsrc.c              |  6 ++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 10 +++++++---
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index fe9fb80c6a14..3fad74563b9e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,12 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct io_uring_cmd *ioucmd, unsigned int flags,
-		unsigned int iou_issue_flags)
+		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
@@ -141,12 +140,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 		/* fixedbufs is only for non-vectored io */
 		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
 			return -EINVAL;
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd,
-				iou_issue_flags);
+				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
 			goto out;
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
@@ -194,11 +192,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags, 0);
+				meta_len, NULL, flags);
 		if (ret)
 			return ret;
 	}
 
 	bio = req->bio;
@@ -514,11 +512,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec, issue_flags);
+			d.metadata_len, ioucmd, vec);
 		if (ret)
 			return ret;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..ea243bfab2a8 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -39,12 +39,11 @@ static inline void io_uring_cmd_private_sz_check(size_t cmd_sz)
 )
 
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
-			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags);
+			      struct io_uring_cmd *ioucmd);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
  *
@@ -69,12 +68,11 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-			  struct iov_iter *iter, struct io_uring_cmd *ioucmd,
-			  unsigned int issue_flags)
+			  struct iov_iter *iter, struct io_uring_cmd *ioucmd)
 {
 	return -EOPNOTSUPP;
 }
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5fff6ba2b7c0..ad0dfe51acb1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1099,10 +1099,16 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	if (!node)
 		return -EFAULT;
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+int io_import_buf_node(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir)
+{
+	return io_import_fixed(ddir, iter, req->buf_node->buf, buf_addr, len);
+}
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
 	if (ctx1 > ctx2)
 		swap(ctx1, ctx2);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index f10a1252b3e9..bc0f8f0a2054 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -59,10 +59,12 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
+int io_import_buf_node(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir);
 
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
 int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
 int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			    unsigned int nr_args, u64 __user *tags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..15a76fe48fe5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -232,10 +232,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 			return -EOPNOTSUPP;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 	}
 
+	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
+		if (!io_find_buf_node(req, issue_flags))
+			return -EFAULT;
+	}
+
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN || ret == -EIOCBQUEUED)
 		return ret;
 	if (ret < 0)
 		req_set_fail(req);
@@ -244,16 +249,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_OK;
 }
 
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
-			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags)
+			      struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	return io_import_buf_node(req, iter, ubuf, len, rw);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
-- 
2.45.2


