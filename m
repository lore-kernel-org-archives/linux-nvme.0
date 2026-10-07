Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFCCA9EC7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=; b=Ln9zuK4OdFIXT2nm1Y0UAqGDjR
	J5k6NmqmU/LYRlyJEg0n4YwyoxyqbXCgdM0nDvV2ryq4pLC5FU9BvGxFwj4X/j4D4JAoQUg1KLcKj
	0lk26l9qvbd9vSIV5yka4W0K22txR2/rmGbY/vf0GEkbzVBVq4PV6q3pW4EiYMygaPwVLgZ+Dx8Lw
	P7Mp6YeYUEz45QOr5rjrpe3ONOQgWFuLtameqCHQTzUtumEj2tegzI3tjbjm1NbDB+1MoA3OAYTVq
	L9tJy1pPDRiHGboibJ6Vb0rWshGJWE2WcpJSz67p5vhQp/0zxvHvqKJFJ8TAgodyIsLuuaLhwsl6l
	m6/fwgLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtg-00000006hbZ-1hZj;
	Fri, 09 Oct 2026 16:56:40 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGWJ-00000001b2j-2uJd
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:37 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a16c399641so13172045e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336754; x=1791941554; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=oPWL87a3SxH1xFGZxxhnAUkOOsVYBM8viv7Pe9D184r5DJXnZWyRX/rn1BXKGhquWN
         nMAbGR4GsivXGRbYnrNqgNXIlfpO2v/yc8THPuHXXepAXpM5/589xknK9fRYQwNNuXSj
         Vexy+3FAI6VujqavIk1Y2JqttXlQpoJzQPqJVbHk9KYEMGa4cN8ohNN88akbg1kU2zKN
         bfodLdQBY+NbABZ6v2928Fk2Gy4GIXUMUl/8SyiqA/Cv2LK0pQus0YPFjVai77NsmPe3
         k8M9UT5H6x5OiZqcqa5D3VKWE4E8Gcj5foP5wcm+cPjjUMHMI+ipUOLZ6OkXS57wcell
         cIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336754; x=1791941554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=AXPJ2CkbAu/L2LLFluCIiWn+Hb4plPoXoFoHbMdyJMEasqwjbFPOfPmerfSaUgM1jt
         +1tN9pKSH4gJR78SuK+DPGzwXoT1B2V/JjzgXfCENCaASWmWq5YSa8SX5oFzhRo1Vs24
         YByNBnLkWazBya/rf2bWvXf3Ml8J5S7kOIj/hzB/IkRE6wJEYZPMiySidOGHQx6kcm9E
         sKbFcfnE3Kl7yNK1SmytoKA91j4cXVsfqP8ty6stQl017b5LgRfdCseApYPeiLz3Pd4N
         xSSgdAovvriq3Do5zp4G6v4i/uliHsWBY6vz4HgR9I7nC6/BIdya97Zz2rkhbBYYwXdd
         nGzA==
X-Forwarded-Encrypted: i=1; AKwUvBwKCObk2kEjdzkDlKywCcrpuirIXocELj4vKWlfVQApSvzfb7Z+FfUlfPRwctfK2C3dEsudWCtEFAhh@lists.infradead.org
X-Gm-Message-State: AFuF++m4E8opwYFmBm1UXpP4NVptzWk4irlKnb1uk1bZWfa9e0LQ0OX8
	B4dSmcSB4cb/Gy1YDNehMdUSs9TBI+ZUSXiJOJU4Ve56q2tsFH7thcn42pN0Dg==
X-Gm-Gg: AYBFou0o6hiR04gt27JSUQCOz5NEZQtvfuVdBsVvBu0A89dZWHgIUP5NAaRs4BjzPiI
	Hl+utneVm81W2YEHgIHM0VOcq00hKQ3g5CyUXDOX+Kg8wZJY2GtDEEVaYIO9M++OOe3HSDHAbeS
	chGROeraRgIkylrdCE6CbhcksJ/DTbFwgg5xUnigwyqaVNA7CvZsOFnAYV4dxOrzOhZ6ho6RwFp
	CSKeGHKg6cFKb/UEw4P1QR/CXwVqM+4ZJLuGt4IDZqwRkPE/P6glNoCteerXAcD+U1JuxMmHDex
	w7ok6Ms4UxfvUvcX/bCyyWKx4k1pmv9hu+sn00Crt5M1yx4IrtFzpF5wIPkgvcXMoowoLkpAArW
	eefacFQsmT4bgfY/T6C18z13/4oIAkbk4kzQKRgS0NQbLe9HB10zmgnOuKOiq57mV9ahO4cZwgR
	wMI1BhkLo0hqepWS5+xZkU7SRQqaVM1pEj+myb/6uCImf1eeckuUxVvzmZGVOXFZzF3CBFH0T6A
	h/+IdztAnQI+vOl2PQZVzM6kc/136gucdJkhBbrJJJq4UM1FE4qVWFbZFuzr4QSh6ir/+W2lHrb
X-Received: by 2002:a05:600c:3b99:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a1806501eamr8969125e9.27.1791336754109;
        Tue, 06 Oct 2026 18:32:34 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v8 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed,  7 Oct 2026 02:31:55 +0100
Message-ID: <4a4bfd9b4e444ecf9025e85b5cf0f864aa45c139.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183235_764747_2CF8E335 
X-CRM114-Status: GOOD (  14.11  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6930a6897b41..6e4fe70b316f 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1315,9 +1315,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1731,9 +1731,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0


