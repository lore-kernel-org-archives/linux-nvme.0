Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86FCC83013
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQeoeraNZzYHF4/dvoiDZhB3qU1Zz7S1cqKpmMhIX0I=; b=x77x4CdkSh5cWpMTqgxiG7yDH4
	FxW6cStqPxO5o3sxJxbn834P9bKp0qKP0wG97xrqWsc6Do+6iBLGYr+bQnNsEMwvzhIQJjZMTKhTj
	mFQHKY0W2gr0ioxAwNuX+JUuZP/LLmvU4mE+1/ld4lb67poLiqptseAak/Q910yPz7sJMhe4BbY6v
	DgcjHbo2YxIutRxgz9KxTwdQjgW9/JvzARzhwEqk3CWcL5oPcv+cv4hUfqQIqGzL0dOGiItWzFziY
	HrywewTBDhbsor+IgGEbBI2WMkRZC/FjrYpPEbNewGg92rwQYejnTryKaDpBMf65XG+G3EHcZnTbF
	XfsDXJJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvG-0000000F4PU-29lW;
	Fri, 27 Jun 2025 15:23:26 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAht-0000000F1Cg-3wxN
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:39 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso4338467a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036976; x=1751641776; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQeoeraNZzYHF4/dvoiDZhB3qU1Zz7S1cqKpmMhIX0I=;
        b=Gv6AzBnz9AFz7B1s2wZphm8SSV1rhnSEZUZOcB+YFM5aaDje66MTav3VAfw6NfOhSv
         QgouMHzUXY2Sem9RfLwBgfo2FAjQyCkk1BgJDoSoyRi4AIZtZMeOOn+2URMIoezTIDm1
         pw2xs4XtLHzUOYJntQ7TId9s0nccRJ2OuhG4InJZ/Z0+AgxjLah5KBROgzYYf02648lt
         +v0bd8MfjIL1RCjEylS6cZxeCxYtIK65fg/8FYtNGr9auvteZtJAPa7fph/VepR0xxdq
         V9NWJK393ibjBe3qKsQfOWI4fRXMSZAbi/cQ/ClQKKhvA9+JAc6/Auw4IuqYjbKxm0nq
         3aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036976; x=1751641776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQeoeraNZzYHF4/dvoiDZhB3qU1Zz7S1cqKpmMhIX0I=;
        b=iB3fNyjiuGh/9tmsMtVEx/w3XzfmqN4k+ZPz2iWWo/6p85i5HslfuZkZmFkQkpgmBn
         +TetoBwZF1D5J2IJRDE+xruKb4LmVy4VpunfQP4Yxt8lNGjuxGjKa8dTqIDrzOsRP9yD
         cBaD6e4b23wGNWlbJaQLj93AALUkCbOb/6QmHE3U9J3cz/fUhdVKqh/3PQRsCxwBzh5Q
         bkdl5vSDgoXAP1OOmu1MTSU9ycXUO24+ww3Hf2dExQIz4861sgYkkvt9BPlwc/sywboA
         N/g/s0ezKgz37tdmJk5HWYZKHniNfsH0fJ/uKsycozgVZevMYS6JwYVCkaBQ3nX1xuIN
         1VZw==
X-Forwarded-Encrypted: i=1; AJvYcCVm21wmXTnaXMo/jBZUjuMxdGoN2QzAR3y0AT/jdkq/BZxadDTZSFx8aJ0xZMpf/otvdYaa4Gt4Dpjx@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9KVsxMtDZNtmHW3/WmH55+66dRzSYfVM90pamq1+MPwDyzZrC
	O2Rclul1IxgdCzyB/eUp7ky779hfkZ0qUE5eSNihRinCHft58br2G+Wv
X-Gm-Gg: ASbGncuPJqJYyGbwDaIyyrw1Ms6HMawEz8LkyDkuUR+Vrl9KygOcAErPjx90WBu6XII
	299vZAXe4aktlLsmzzSE1w5DQelaJrdOiSYhBS4+I4euheTxrCNB5saDmSUNvgH+QpY4oCPLqRJ
	/O0fjU5HO9MGbEQ29N1RLriBbmtcX0eC7TK9iC4BybexSuUanJ39pR1eGMMT+CvQS4ON8EpWnWV
	dCF3EdW2ZkWd3cNVsYVLazqlmSKKyazgR5l2DPEEUUoNlTjNhfFcHJKfk0n1B0NSbJCuB/UzlK+
	BuauE3FHkUsnmaarJ8/5MRHKQn4qW9sRhvlJEyLbYePADZldZyIT6PAunD5mvBFPqg2KdYz/YVz
	d
X-Google-Smtp-Source: AGHT+IFuo3ZrrB5abnV8yWLtvLJ/KG5Qo2VOtBJKDd4SnuvJbcZvVX2UpVDKWmCTN+ZxiULIBXyKyw==
X-Received: by 2002:a17:907:3c89:b0:adb:2e9d:bc27 with SMTP id a640c23a62f3a-ae3501a3fdfmr362472366b.54.1751036976053;
        Fri, 27 Jun 2025 08:09:36 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:35 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 11/12] io_uring/rsrc: implement dmabuf regbuf import
Date: Fri, 27 Jun 2025 16:10:38 +0100
Message-ID: <b7b48875623e2be55aff6ce5dbf02189d6feb44e.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080937_990931_021DE0C5 
X-CRM114-Status: GOOD (  16.43  )
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

Suggested-by: David Wei <dw@davidwei.uk>
Suggested-by: Vishal Verma <vishal1.verma@intel.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 53 ++++++++++++++++++++++++++++++++++++++++++-------
 io_uring/rsrc.h | 16 ++++++++++++++-
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f44aa2670bc5..11107491145c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1196,9 +1196,44 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
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
+	struct dmavec *dmavec = db->dmav;
+	int i = 0, start_idx, nr_segs;
+	ssize_t len_left;
+
+	if (req->file != db->target_file)
+		return -EBADF;
+	if (!len)
+		return -EFAULT;
+
+	while (offset >= dmavec[i].len) {
+		offset -= dmavec[i].len;
+		i++;
+	}
+	start_idx = i;
+
+	len_left = len;
+	while (len_left > 0) {
+		len_left -= dmavec[i].len;
+		i++;
+	}
+
+	nr_segs = i - start_idx;
+	iov_iter_dma(iter, ddir, dmavec + start_idx, nr_segs, len);
+	iter->iov_offset = offset;
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
@@ -1214,8 +1249,11 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
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
 
@@ -1269,16 +1307,17 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
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
index f567ad82b76c..64b7444b7899 100644
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
@@ -65,9 +69,19 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
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
-- 
2.49.0


