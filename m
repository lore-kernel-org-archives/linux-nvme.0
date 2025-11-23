Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941ECFD316
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cr1T3mHouFLI2INVVeu1NU8Ohycgb7ruAKm6sUveqNE=; b=ehDy3B1KPdXmcdMsrCsByABKSj
	mF0AXMzTr/3XNnMlpDgx++Ax6hDYpAXVqVn5tgaKfy+JiTIv6IaSm5PCPpjRVWX2FffuqJpO0bO23
	2AzlP8DNIAA8sa3JihUkLdfcWX66bxIfNReKlY56XqdiE4QNOmcfJWCwAGU25raJaAGdhXNvb5z6z
	9Yz8xHJ+hvN5uAWzpVy43qicu1id1IQiFbcLVKDzP97UPphmj79NnWJlc3FsAxT+FUR5+KIMfEKBG
	eCZdTTgAeTMx+6tijokK2DJLiCED3fiZTrnIcyb71Pb2eHZatqLGPzkyXWswsaYhhyE6AEJUucBcs
	d93x2S0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw8-0000000AksZ-0ez0;
	Sun, 23 Nov 2025 22:52:04 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw3-0000000Ako1-2GFE
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:52:01 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso3096952f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938318; x=1764543118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr1T3mHouFLI2INVVeu1NU8Ohycgb7ruAKm6sUveqNE=;
        b=IMiNxE69NLXmasuGUrB2JXzqpgbqwb95C5tQBPBMr+rJSAISt61KArkV9NKAeVcZvJ
         H0NAdQentE8ipHVCtxvsjpBtSDPzXzrHt2Kd5/0kMIR8F0DK4XCJJR9M4zrh0OMjOUzU
         C3iIWzsoC0PEp/B63Ni6HAV+w6w+CXMcsWWTfBc4qmDBAMbAugxO92u9aUVAk29UXKoT
         Q6//heoSD7iK13Y1Etgou1qCRrF8uetnl9fTCWrkfAuVqLxJLUkN23VacisVpDnX0GgI
         eFtw6ZQAOip6Go6ovnyQcKFFN+n5/nCB+I5C8ueOEaMf/cSWB12UcEPtnOsDnQWG2BIz
         T+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938318; x=1764543118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cr1T3mHouFLI2INVVeu1NU8Ohycgb7ruAKm6sUveqNE=;
        b=mvJMXWSZa2eTdAxEo3XEBqjgPCgg0pmdITkPsgMraFWSPZfWwvAC9o6bkd92iTAuvZ
         YzmHx+Bb2W6MqAwPiEgTZy7PyW8++zFUhl1sroYXzDO2Xx95DmYvQgfSVH41FKPqa6MR
         wgO2s3U+WvkdaummstfJyciQV/xCh4CoKsY0/RsXAkSJBvpMtmCjfDCmbL7Gc4CujZmi
         kBjX1kPL0dqeohCl7loiyO0zjrOSTQkjS77YYloIhAfkUMTE48X0+MV2pWpvqM2bVVnE
         2beim05ZFkrLBRC+T5z+2pgYf+ACPKu3EuBlmtYHhaeOe4RJk1xxHG49p21JQP2PBl7V
         WltA==
X-Forwarded-Encrypted: i=1; AJvYcCV5SUrDGWsZ4MgFskaU5LWqwc6DDe3y3Nhe7W6ZBbSAWA9KfQp683cUrXGfhibn3rjh6+mNwE7wvClt@lists.infradead.org
X-Gm-Message-State: AOJu0YxAgMHfWIkBKMAWgq5SQuW3Yan1Ha9iW3mdJ7HSQIKXa2OK0boT
	RacfIVoT4X3+YRF3KQ6y+3r2aRNr7prygl1P5ul4bpqBH84HECgd+HVY
X-Gm-Gg: ASbGncvNmnQh2KBUU4fikE5PyeMo2o1/jNl648Cucy8GPUbcWwxYcG58kQCnu2xcKyF
	eTq9LWM8vCSrbJcnAixVaztsUgi4wcRHNY/IB93ANAYTRQyTMTqZV0twFaR4hJ7XW2UhIMK14eY
	GSlLIzEplbHOmkv8Z1dlQhdM7nKZhq+J+Gtyfl8YylIe7NrXY6vKV2tV6uVLiS3WdVgC0hqOvy4
	mLbQgXRe/k57QeQp3l8b894+2Wy5OglsClQkJpdpJqk/Vh+0FRtY2sQHy9LdDWSZctfk80v7OsD
	UGUbjI2S2vWAdCfTed9R6ibmaPg1kaXS5paaNlfBqocdj2VilxK0Y9Yyn6O2CcHSmuQIvZLadvr
	MFJMulNy4qtYkQzPEGB/bkDlmYWMOnfyC90NigpfYviE+JlGpUwkL/pfFO9O2Q51P2Ku5EjYmHL
	S9PsR2YKoXGK7tng==
X-Google-Smtp-Source: AGHT+IFWQMi7JjnPU4iNqrFrw/2a7As2OTjK90JEPF3SEC3P6oOl1QIY7pfuaXnoytjEpQNeSrnvkg==
X-Received: by 2002:a05:6000:200c:b0:42b:4139:579e with SMTP id ffacd0b85a97d-42cc1d1983fmr10129976f8f.43.1763938317609;
        Sun, 23 Nov 2025 14:51:57 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:56 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 08/11] io_uring/rsrc: add imu flags
Date: Sun, 23 Nov 2025 22:51:28 +0000
Message-ID: <25a416c7f2673d39ae31bfe8bddcfc7eef710e71.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145159_657855_7C580626 
X-CRM114-Status: GOOD (  15.69  )
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
index 3765a50329a8..21548942e80d 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -828,7 +828,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
-	imu->is_kbuf = false;
+	imu->flags = 0;
 	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
 	if (coalesced)
 		imu->folio_shift = data.folio_shift;
@@ -985,7 +985,7 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
 	imu->priv = rq;
-	imu->is_kbuf = true;
+	imu->flags = IO_IMU_F_KBUF;
 	imu->dir = 1 << rq_data_dir(rq);
 
 	rq_for_each_bvec(bv, rq, rq_iter)
@@ -1020,7 +1020,7 @@ int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
 		ret = -EINVAL;
 		goto unlock;
 	}
-	if (!node->buf->is_kbuf) {
+	if (!(node->buf->flags & IO_IMU_F_KBUF)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
@@ -1086,7 +1086,7 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
-	if (imu->is_kbuf)
+	if (imu->flags & IO_IMU_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
 	/*
@@ -1511,7 +1511,7 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 	iovec_off = vec->nr - nr_iovs;
 	iov = vec->iovec + iovec_off;
 
-	if (imu->is_kbuf) {
+	if (imu->flags & IO_IMU_F_KBUF) {
 		int ret = io_kern_bvec_size(iov, nr_iovs, imu, &nr_segs);
 
 		if (unlikely(ret))
@@ -1549,7 +1549,7 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 		req->flags |= REQ_F_NEED_CLEANUP;
 	}
 
-	if (imu->is_kbuf)
+	if (imu->flags & IO_IMU_F_KBUF)
 		return io_vec_fill_kern_bvec(ddir, iter, imu, iov, nr_iovs, vec);
 
 	return io_vec_fill_bvec(ddir, iter, imu, iov, nr_iovs, vec);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index d603f6a47f5e..7c1128a856ec 100644
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
index a7b568c3dfe8..a3eb4e7bf992 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -706,7 +706,8 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 	if ((kiocb->ki_flags & IOCB_NOWAIT) &&
 	    !(kiocb->ki_filp->f_flags & O_NONBLOCK))
 		return -EAGAIN;
-	if ((req->flags & REQ_F_BUF_NODE) && req->buf_node->buf->is_kbuf)
+	if ((req->flags & REQ_F_BUF_NODE) &&
+	    (req->buf_node->buf->flags & IO_IMU_F_KBUF))
 		return -EFAULT;
 
 	ppos = io_kiocb_ppos(kiocb);
-- 
2.52.0


