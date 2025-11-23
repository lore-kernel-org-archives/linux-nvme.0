Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD42CFD2F6
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjKpkoDBMFXqwI53pRDJnxFi7xwhurS0a3ahU0JbCgI=; b=JbpxYcx/PIATaR4xPG7QPMTejZ
	wVTgqfaTs36u8oE7PUUNQhbb5iUvFlpG79NrgeE+cMrBxgyDKm3UOnbTbtoZGfbfzncrAn4QF9v8e
	RzMrnm/E8uKpzzd0GDJ0J4POILTB/NxJbL4laUWHyWTBondQuMsjhwwblADoo9mwE/78oJj1lMgi4
	mE7h1y7WKGZ6VUNIqsr0/bbdO5Q0PmMS5L1RGG6uIcSXtWqf0LJfXVt4hyjMzAPsep0NX/kXZgDzs
	CLAg/SvwwquT1KXgFBdhw1TbU6M2U3YmSQ7ZSt9SlM8oHHw2tjObbE5is1soyd8IbJXDzJN8/4/+p
	WqoIsLyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIwD-0000000Akz8-1RYn;
	Sun, 23 Nov 2025 22:52:09 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIwA-0000000AkuS-2Gd1
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:52:07 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so35573235e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938325; x=1764543125; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjKpkoDBMFXqwI53pRDJnxFi7xwhurS0a3ahU0JbCgI=;
        b=exVw/M950yOnb4P6Zy01tdLZC/6d6GcUsvOWpmzYpV/LopUD8DX9qeRaaii8qYMzGz
         EUsHX8m6+3QE0A6cfQptanpyGOFwlsrJbpVmcQaXEFDE6hWku+2JrlFxxihHdPGti/+z
         uowEqUYbWar591AjvPHHjnTibjyduZv/8tgW5mReuWisE26TXR/iEwBfyRN4j3oJ3Q1X
         bgKeMMSrB2+K3A2tSeUnLzuO8vzj6OD7TZKfVsDDnhZ6T4O2LbjxdlLKzG76RepzO1uw
         7ahl7q7m9Fs3qOZe1U+XnhiNJWKZ+YX1GdNQJW5+Fghcl+G7168BBFPc/UWE7Ew841Uz
         JQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938325; x=1764543125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjKpkoDBMFXqwI53pRDJnxFi7xwhurS0a3ahU0JbCgI=;
        b=NuMCyhKciz3htsZCxk1w376k2hh1JNWMc06reGP0qcv+fuqk8ZMZYWzkb53hQsXmSC
         Je3q2P94rB/pUVtU7+MzHnWkPxdyes5MYPyiCBY/ipj0FOZ5zzATB3/rN2lfWYTds6OV
         Nl8pZsEAgK0mvL+6qnPR8wIYTz7uic4bxURyBXywDqhltJQ5e1gj5A8LRr3sJ/udj/bW
         3gTipiw9yvcaA/RFW1IiZ0zkwI2qiKl/x57Yd+8h0semWGCgCYzIqE+RJrtPEA/hJ3fi
         PXl1A2puzuyw1SwWCH8ctA7vz1c4JdFqLq4iPRw+8kCFUaMfTUrZRholX9d8JlzDpm4w
         J50w==
X-Forwarded-Encrypted: i=1; AJvYcCUXM/vk6jqH/59XJPO0iEy7gizyA2wdSMyDb2OlgRnqNFKsCF6TMeXPOaYHLaQfzhWeQfJhyXkQbuAo@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1BLqLMfzIMKd4BXT9bF5xGTqJNU69KPxcBmDaoGjiT/UYFDfW
	222tVks9sUe4ABEabl3bJuPoqHlzaZVRL+HNBDIk3FHK58FupViD14gp
X-Gm-Gg: ASbGncuwMoCK/Na10fCql+8xQQni/yQnXh7kmYLzWKwi2VongSu2YBt4HAPlHt61ELf
	uOYOVWYRyP0xn0UJBGXQn3ClxOvwxcud54FSYNYbWUSyiTDAPcY0Dnti9VFi2p9p1I9tQDpgbDp
	ckV87r/iMbCp4En7tWQgiwXbG+BPjD3yBpqElJCCCa4zg1IXUf4wqdXE/KZLh0ut02vKyCAAJYz
	FowXq452PKCoCzhWoCjmFgUpq2iiptZU2MGNlWjOktJe+BoWQfr7vT3DxvxiTEcE3M3itUfrwgN
	fOPZ7Dvjb/fJx0/XkskHowqHWCw3rwzNPuP/RV1WTgVNDBbFV2wbuNQvwya9ND3SzVZ+ulMp4Ca
	HDnCCCkNMvVr0iWpFejgGSta9VJfleSIXJFVGi4Ct802hAsPiDegz2r+Q3aGLaubSQ8HOVYhWiI
	zPV3/4o9/ZoZnJEA==
X-Google-Smtp-Source: AGHT+IG0SGMWMdVe66Rksvn6v5FBe6opsohs/EM0p8y743GggDbgal5u09Oo75v6mEVGyS+Z85JlHQ==
X-Received: by 2002:a05:600c:8b35:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-477c111b94fmr113406075e9.12.1763938324588;
        Sun, 23 Nov 2025 14:52:04 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:52:03 -0800 (PST)
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
	linaro-mm-sig@lists.linaro.org,
	David Wei <dw@davidwei.uk>
Subject: [RFC v2 11/11] io_uring/rsrc: implement dmabuf regbuf import
Date: Sun, 23 Nov 2025 22:51:31 +0000
Message-ID: <44e4ad8c4bd72856379c368e4303090c44c9e98e.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145206_611980_601D7637 
X-CRM114-Status: GOOD (  17.65  )
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

Allow importing dmabuf backed registered buffers. It's an opt-in feature
for requests and they need to pass a flag allowing it. Furthermore,
the import will fail if the request's file doesn't match the file for
which the buffer for registered. This way, it's also limited to files
that support the feature by implementing the corresponding file op.
Enable it for read/write requests.

Suggested-by: David Wei <dw@davidwei.uk>
Suggested-by: Vishal Verma <vishal1.verma@intel.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 36 +++++++++++++++++++++++++++++-------
 io_uring/rsrc.h | 16 +++++++++++++++-
 io_uring/rw.c   |  4 ++--
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 7dfebf459dd0..a5d88dae536e 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1201,9 +1201,27 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
 	return 0;
 }
 
-static int io_import_fixed(int ddir, struct iov_iter *iter,
+static int io_import_dmabuf(struct io_kiocb *req,
+			   int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
-			   u64 buf_addr, size_t len)
+			   size_t len, size_t offset)
+{
+	struct io_regbuf_dma *db = imu->priv;
+
+	if (!len)
+		return -EFAULT;
+	if (req->file != db->target_file)
+		return -EBADF;
+
+	iov_iter_dma_token(iter, ddir, db->token, offset, len);
+	return 0;
+}
+
+static int io_import_fixed(struct io_kiocb *req,
+			   int ddir, struct iov_iter *iter,
+			   struct io_mapped_ubuf *imu,
+			   u64 buf_addr, size_t len,
+			   unsigned import_flags)
 {
 	const struct bio_vec *bvec;
 	size_t folio_mask;
@@ -1219,8 +1237,11 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
-	if (imu->flags & IO_IMU_F_DMA)
-		return -EOPNOTSUPP;
+	if (imu->flags & IO_IMU_F_DMA) {
+		if (!(import_flags & IO_REGBUF_IMPORT_ALLOW_DMA))
+			return -EFAULT;
+		return io_import_dmabuf(req, ddir, iter, imu, len, offset);
+	}
 	if (imu->flags & IO_IMU_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
@@ -1274,16 +1295,17 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
 	node = io_find_buf_node(req, issue_flags);
 	if (!node)
 		return -EFAULT;
-	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
+	return io_import_fixed(req, ddir, iter, node->buf, buf_addr, len,
+				import_flags);
 }
 
 /* Lock two rings at once. The rings must be different! */
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 280d3988abf3..e0eafce976f3 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -33,6 +33,10 @@ enum {
 	IO_IMU_F_DMA			= 2,
 };
 
+enum {
+	IO_REGBUF_IMPORT_ALLOW_DMA		= 1,
+};
+
 struct io_mapped_ubuf {
 	u64		ubuf;
 	unsigned int	len;
@@ -66,9 +70,19 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir,
+			unsigned issue_flags, unsigned import_flags);
+
+static inline
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
+			unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir,
+				   issue_flags, 0);
+}
+
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index a3eb4e7bf992..0d9d99695801 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -374,8 +374,8 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	if (io->bytes_done)
 		return 0;
 
-	ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-				issue_flags);
+	ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+				  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMA);
 	iov_iter_save_state(&io->iter, &io->iter_state);
 	return ret;
 }
-- 
2.52.0


