Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1672AC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u26XwVa4Y9sa7m6bu4ldVW+GkLaumHhW61D3zghrsdY=; b=fcopPnC8K/wGFpwTN0QFOl2Mny
	PhD27r3sZ+JtzsRbNpgsTVKhJelezLZrSN0DSpE9THJI1JImzWKUZvYaLY5UxG8NrR2MSVVgREr+X
	/lTvtqDmh+q61Ja58WNU/hYgj3zbs7UZdmH8EHAHYqoLAHCWgoq8RWTZKibKgqlY6+VbATi6IGs1u
	GD9gPixMvQ1FdkH1iDFYqLhIShrKT8DJSKuCJbs3wWYT9iIMCIJSZiP4XLU0/PikIxIMl4jxXTjEH
	Y34Fa6hcvLDq92Hp+U8vGXZkHk/ZhHDAn/hZ/4yJzMXFeOaoQf5X1cO1oyPb7B4pfMNPs4Fxfx73l
	MF06tseg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvE-0000000F4M5-1ULS;
	Fri, 27 Jun 2025 15:23:24 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhq-0000000F18f-3LuJ
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:35 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-ad574992fcaso395517266b.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036973; x=1751641773; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u26XwVa4Y9sa7m6bu4ldVW+GkLaumHhW61D3zghrsdY=;
        b=CZNoENHkU/uzvIS3YuLDxLrgmdgeOYBZSBGqgQ3TPqNsc9bCC77qJLP74BVHCFiPE+
         utDQuinZ3ggdo4K6+lg6GZQ74whzAUB/Qq4Fpb2MqcAaYcB7LkCHRP4wVn04/WxAXaAR
         9Ru4ACsyggtNWSIqE1iR3FAb1j54+GOf/68RkjuQLCI/mb/pK8OyndogbzceivhGMax/
         U5ejad3HjSYsEAkAcZrQdDNMMn94lS8y3qy5Ktyx0uW6hHASYfUlOyDPgdwZW5oUfB54
         lRWh2lj8eN03MTV8qU1o0C1P1An2z4vumOC+HAEy1mihDspl5CochUPSY2lEoL4MscpK
         luoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036973; x=1751641773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u26XwVa4Y9sa7m6bu4ldVW+GkLaumHhW61D3zghrsdY=;
        b=GE5ezVM/THGN6EGQmQgoZg8HIykjjD5zWuKdSkAEcBxH1mn9IE7hH/p5+CRHFiUVwB
         s8PnV4tLDOKosFBRRrupZyglIB9Xvemr6fcNfuEB37xBb6WinR6/0/Z7z5wZYuubZRNW
         JmVrtoyBsAgOUI6c2CsBufULn7j3xmLodpCFNhhsinsArvFGSx5rfYqhtOIWZOYOmfk0
         SoAQNUwm3BV+aK7ZyY3gR53+ez0XxVRrKd8vAxQXlJ8ZB1F4QspQs0NPZUNwI7XuA4pw
         UaXtte2oS1CPfz0VlYJut1GTy0AsqqaDzy3PfVTb58x5mJwExihQ7DklVJJIQU8gKgUF
         RGwA==
X-Forwarded-Encrypted: i=1; AJvYcCWesVwhm/DH3196MAhV87JjzSwfW5TSRQmxtuCPb+itzs95+eRFIm0mxIKRSO/cQZW+/dQHTBICO0/e@lists.infradead.org
X-Gm-Message-State: AOJu0Yzn4f3LUG8mC9K2ixhJmf+J3fTczQKNVvW7kCRqCNMTMyXAtFEI
	eUiucrLY4wITz5/Timqy56nBFsU1s6PdExZHipDimOte3FvtJDyHAYAIFJgc3A==
X-Gm-Gg: ASbGncs04zWdZQiEDNso+1o3wtW4KYoynNaQCYbKVjbE6B9qc7AOLEN5awRYmPRVZRQ
	IlzSHQ/jW5JqDVjm2o2Mbvt0/9lMbqsUSSs93+FiyjVdyYbXaHCB2oOYNAwK60n4Gn4HY8kjpRb
	+cgrglzNn67G+niLoLWGnj/8UnCV+UhilbnskRnhdDzyC/q738hH3BqX5QYwkWNq/+IpB+XpxLg
	p75C+SPci35qgKKg9p0Rrx93bQjIQOOIeD9ySrEwlBE/0+y7V531rlRM7QmKT0frbX0Bc4tHYjH
	UfnNgg/KWqgkog3HT9tmSD6yGWSzPbsngZG8mYzeyp2LuGqFTWhX6dfjwPjkQTOK8OJ8++HedCs
	N
X-Google-Smtp-Source: AGHT+IFkXr9u8nDlNj9mlCHAPJP7fvPn3kwFSuk77qsB5ddM3lpGccW8aFFP0oRsAdnZ73s0dkmQow==
X-Received: by 2002:a17:907:78c:b0:ad8:a41a:3cc5 with SMTP id a640c23a62f3a-ae34fd18405mr332552866b.6.1751036972952;
        Fri, 27 Jun 2025 08:09:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 09/12] io_uring/rsrc: add imu flags
Date: Fri, 27 Jun 2025 16:10:36 +0100
Message-ID: <ff094ad30f783ad515e48474d66201e909070827.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080934_847410_0C080161 
X-CRM114-Status: GOOD (  14.52  )
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

Replace is_kbuf with a flags field in io_mapped_ubuf. There will be new
flags shortly, and bit fields are often not as convenient to work with.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 12 ++++++------
 io_uring/rsrc.h |  6 +++++-
 io_uring/rw.c   |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 21f4932ecafa..274274b80b96 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -850,7 +850,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
-	imu->is_kbuf = false;
+	imu->flags = 0;
 	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
 	if (coalesced)
 		imu->folio_shift = data.folio_shift;
@@ -999,7 +999,7 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
 	imu->priv = rq;
-	imu->is_kbuf = true;
+	imu->flags = IO_IMU_F_KBUF;
 	imu->dir = 1 << rq_data_dir(rq);
 
 	bvec = imu->bvec;
@@ -1034,7 +1034,7 @@ int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
 		ret = -EINVAL;
 		goto unlock;
 	}
-	if (!node->buf->is_kbuf) {
+	if (!(node->buf->flags & IO_IMU_F_KBUF)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
@@ -1100,7 +1100,7 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
-	if (imu->is_kbuf)
+	if (imu->flags & IO_IMU_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
 	/*
@@ -1509,7 +1509,7 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 	iovec_off = vec->nr - nr_iovs;
 	iov = vec->iovec + iovec_off;
 
-	if (imu->is_kbuf) {
+	if (imu->flags & IO_IMU_F_KBUF) {
 		int ret = io_kern_bvec_size(iov, nr_iovs, imu, &nr_segs);
 
 		if (unlikely(ret))
@@ -1543,7 +1543,7 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 		req->flags |= REQ_F_NEED_CLEANUP;
 	}
 
-	if (imu->is_kbuf)
+	if (imu->flags & IO_IMU_F_KBUF)
 		return io_vec_fill_kern_bvec(ddir, iter, imu, iov, nr_iovs, vec);
 
 	return io_vec_fill_bvec(ddir, iter, imu, iov, nr_iovs, vec);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 0d2138f16322..15ad4a885ae5 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -28,6 +28,10 @@ enum {
 	IO_IMU_SOURCE	= 1 << ITER_SOURCE,
 };
 
+enum {
+	IO_IMU_F_KBUF			= 1,
+};
+
 struct io_mapped_ubuf {
 	u64		ubuf;
 	unsigned int	len;
@@ -37,7 +41,7 @@ struct io_mapped_ubuf {
 	unsigned long	acct_pages;
 	void		(*release)(void *);
 	void		*priv;
-	bool		is_kbuf;
+	u8		flags;
 	u8		dir;
 	struct bio_vec	bvec[] __counted_by(nr_bvecs);
 };
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 710d8cd53ebb..cfcd7d26d8dc 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -696,7 +696,8 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 	if ((kiocb->ki_flags & IOCB_NOWAIT) &&
 	    !(kiocb->ki_filp->f_flags & O_NONBLOCK))
 		return -EAGAIN;
-	if ((req->flags & REQ_F_BUF_NODE) && req->buf_node->buf->is_kbuf)
+	if ((req->flags & REQ_F_BUF_NODE) &&
+	    (req->buf_node->buf->flags & IO_IMU_F_KBUF))
 		return -EFAULT;
 
 	ppos = io_kiocb_ppos(kiocb);
-- 
2.49.0


