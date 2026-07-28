Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE9C54FCD
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhCvEG3xgv0esCi48jrWlXZeUf+lVK0keP2zUsWb1Q8=; b=DQpr//hScomJ+oDyTG0f+Fy0Vx
	dAwbCrNl80RyEl0Rl9gc6ci1WNHok+ilbe8v5fBskYY4X5KgbwoQeg+3vzFqGX6B0tysVrjr4qw66
	SRCMXQCvVDJF36UYDITWl6hMobZ9iIZ8f5QkeuiRTR7iAo6IVHzrBErC8Xt473Xqn3MNG627mcEBU
	R5R6UmOcEqUfrk0jc3MhPp+sBfnbypGwgP7qa1NLUOViBMkHSnLB40zWzeEszJwa7OuZjtpJdnqvZ
	dJuZUAtm46O0RJ6MNM3Y6nvakaEyxT6FvwqPAuKAB0zPR4CaLUroR+Y6MF0FW9iIWiRWMpzVBru8Q
	RCntwc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqK-00000006fVq-1FSz;
	Wed, 29 Jul 2026 02:16:24 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopNM-00000006KUJ-0jfs
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:30:13 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso167300f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274210; x=1785879010; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhCvEG3xgv0esCi48jrWlXZeUf+lVK0keP2zUsWb1Q8=;
        b=Z+itJ6Zx2yWk/tsZlbnOjR2AXQfR/slpxAwqujiBIQZq2fgFB1PXOVY8rll7DYk7/v
         V6xNAt0eVWZPBytkdc0ES3vhSGsJwOPVFCCdUeH6pLMgoiV6j+x27r/EcIcp4Th5MgLg
         dPu8COtfAuiOJQPSV2k5S3ew5ALxRgFMKELdgwH/ft1eLWBZte83ajwoY0EPrKL2d4V5
         E+c4Av6Qjcx7WPQlcecJO9Wves4w+AlSVRfqjSTnThg1C6VXMXMoHyYucsFCXyiwSSHJ
         NOTDw10gxCxW+asPGARzg171/0oHmKR5TXhAdjqnxBn5tk5S17b+wvZhhWGdRYqjK/xf
         +9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274210; x=1785879010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhCvEG3xgv0esCi48jrWlXZeUf+lVK0keP2zUsWb1Q8=;
        b=ZSLiS8SZ2/5wj0MWRanPiIOoHB41x8qEHMNT0jJiTmHQQivyGrc/y2Pee9bAD7jgis
         iwdvNW6z2L4uMdxBa2QPALj3aocfcVAreznGLp09GJZTSCQNWUqD7D29EFtZXxixxtFy
         0KM8DUCRJPp+Cwn9kKHDoP/W0r1NGGOa3RxWz4D6srMsFhCQze0o9XqW40PbC+zj2I1o
         ImujpqtuEqc/yYX1ZCjDPhDczDBvPhc6ArE+18ErV9cZzE9ijUK7jQ+2ahkgXWvXrd5s
         /MgYzB40zsCGdUh5QIiHeesCUxRTc1w4P7slVL5jsDmmSTUejpBJ92aHMs4TF0+TkILX
         W2eg==
X-Forwarded-Encrypted: i=1; AHgh+RpHHdEvBVOwLAOHatkME2bjd8jx1b/eF8lBBgcfBQIiT4Dvl0eXzIxx/vTrX65OyJUOYhT4qNIGRxQb@lists.infradead.org
X-Gm-Message-State: AOJu0YyiHuCXRuVg/5FkmDK3l+FvLBF9F6EETjowys9FiwDR1zPakVSr
	QG3UVmk0NeanU/ApxkDn+li44th5tIeDIdPJCtiOvZjhsG8Aa9QAdjR/
X-Gm-Gg: AR+sD13GFEKPWJhebHQPdxL84F6xhiZVMpCB5LUmGWkSrl2H4LJJqnZukVHhuqJ0CFh
	f/Y6f/RR6EhquUec9eXWAzmcfBAYS+huwo+9UCnZRFdgtird68zgjX+xN/77gNNIntNEFW8kai9
	3uqJRcxqc/L2j/h8awTe3y5I+cQVfgTM8G8AwwU4sDOk+WJJ6/prqZ8zha9DqDosO/NBpSGsHqi
	Ghdi6VEpGYLj5gkW1n4o+Ih5dEj22b9t32w1W9xWvbHEBWWg56fBQBWEV6UXGcYU6QfN72yPsIk
	7ODgFYsdG2CHBHdbN/G5ohBs3/Uf8r52RGVIkrCFuF4GKwEGJQ/D9RM6xF+2VpWtiKXAjkFezTn
	xycdfNxe2OeKLua5WfT64fTKIEMsZzoJLgvjiVXQGKonYTjv400EK4lDGhka/GtjeXnmHYKgjpw
	fL6YOjFD2Hun/dqmg4eecPxZDiDDXpt5SAWe5EHQ8yMGCdK29j0BmS1/JZBHxk8dE1Vi0vAwuO3
	urPDs2t
X-Received: by 2002:a05:6000:26c1:b0:476:8a:5 with SMTP id ffacd0b85a97d-47fb1f12d18mr4496873f8f.34.1785274210211;
        Tue, 28 Jul 2026 14:30:10 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 13/14] io_uring/rsrc: add regbuf import flags
Date: Tue, 28 Jul 2026 22:29:25 +0100
Message-ID: <9eac63cb6aae06f591e6d0c67505ea2c16dd99e6.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_143012_258626_1F74F4FE 
X-CRM114-Status: GOOD (  13.71  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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
index d57e8a0380b5..05877b4c0ee5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1245,9 +1245,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1656,9 +1656,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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
index 83aa86e6f320..f12abaf63270 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -65,12 +65,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
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


