Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD1ECA601E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=; b=Jk+Nbk5z5iybL1VI0O5xCAAK8r
	gyuwn6ymu/AZ1mYFfS7pRHG/OXQI1fI1W1kDZXXklyIgPgDfunzYfSRArVR2kyC6QlS9RV7drMRrK
	xinzYqPKbP2zYThZIsTHVXD3VO8crAQ6IjzCN63mBai7oh09pC7lX80zbLvHTy6qG9cY0MmyB9gox
	vnOWgUf2XeLhAM87nBNZAcbeZqqRGOiWhOLMjIquXEmJhnVPjjAuHkedahhm8u1c3SQxQnkH99+4H
	CKijLKhiKDnZgC8OyNmBinj9miH4C8Q38UkRcXb5B8LH3yO28IIRxckkCz5vlFkztOcFuSTciXBrT
	ytL3HvbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtu-00000006i4k-24pE;
	Fri, 09 Oct 2026 16:56:54 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgs-00000001cKw-3pM8
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:32 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49e73611928so8953345e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337409; x=1791942209; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=g5KuczdqYeJ+6iIKlhU/Z8DxOJpLkNQ+x+7wSV5GKPEpWPW4Yea+IYBujIvjOnT9O/
         FNGe6pNwYXibs2pQYSt4R6NYI4v2g0aNA3/2s6FtpIwY8cGiftdWgBNBoLwBVrG6obea
         yGHtjnsHIIPLoGyXh6v+adNQyBIHatGDjctXCKSVYMIHhRIuAALRcTWKcQ3MBfneKTA0
         O3lHdjRSC2JmTaAtOsfG9g18DMW3rgPlvmNRL4/9bl1mLsfUH9qwhZOJ1seBmHiJoLvA
         //ImNdEGYQVI1rrnKidr94vnWi1WAhC7klBlkY72vYIypM8w7UX9vwa+Qc2J5fgDdkJ5
         pUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337409; x=1791942209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=QlWIBaSI56l8qPuZNJ5w6urnnxUGhf3xBToIRTigGuB/yamJcnH8vLqWt7FJpVjbXD
         CcvLvQS1ogPVV7XOYyfx8Cs54obFJy1LUFYaCLGLDyFA/+cIuDW9ewCYzsJZO5iwxnvZ
         MvkfxuO7aCpAONHVEefYrtcl2HCRkQh7IdyAKjGmH+TAbm5sJFZ5FSlD0/HKXACanJgv
         Rbd6h78rNHFaPbbxXY3Lq+94psAm70jAJ2MsgojL371okWGjwic5AqXZa+NexhRBlQJA
         qrEygd30o0UwUxO8JBZfHEhVR5sxHDweCnJc3aC41XJC3jE4XJbLtgvLw7aM/e7jBPsY
         kc6w==
X-Forwarded-Encrypted: i=1; AKwUvByxqPYyrOY/92eSG0ASG+Xxj8+exT0oGVepopNM61oy15TAE6GzTpPiZ85BxmUP24nJkj+8lLRTDgab@lists.infradead.org
X-Gm-Message-State: AFuF++nG882YKOohNxBUuVs0724ErwFeUTozpgufyg84NcN3jA9B6ICR
	srbKP1yTfL3PajxZBWRCVP38qZ3y/RlJeYBSSEQLmqADSooE0FKBnaxw
X-Gm-Gg: AYBFou1jBYUPbBXgrsOVrwn1TyzdyTBkm4GouCPpuTwOEuwavOLAEhZ96+xR92ZcfK6
	CrcyRdXBx+LBGYRRf7da4lhjVk/XG2B76MLzl5wsYphHFO/2po1dstLCgx5+G+EszbXRUX/fkb8
	3VlCw2kBu86mBFeUKDCHEriVoLYlLervtlwWTejctTtUwJ+x0NaB92ew6Sp566t6Ly/E6rWJ9Ig
	hU2olIqiKYeDoynWIeF5GE2WGMa3cEfJS/xZJEKxCLRm0R9I4wAmSPGRULRjGEI95owuqyMnEgS
	86O8u29GRBhhUaT2NzhOP8nsdpmzGzjsK7VfTe7cq5sWrPQU6cNqU/WvVz9nrDDu7TX/f+sSq4T
	nNhXih6O70v1tfm/VfjCgcI3B0EMN73yxEvGpCEBRo1ZnDNKDHu12vuLR1ms204mZOlDoWW5U8G
	bFeTU8Zte7ymwUc3zjZbWCBoVmhIvK98LnMUA32Dcw3VSVDtCOs7N3PTBqPDtZ4GYxu4i+JmaN5
	cAsXqCeiC9wxCgt/5Nu/yBI/MWDs9FEqRkzpBP9OLhIV/PaI7PSB6+XpcJvrWPIgGxGQVPXcYGt
	WaxOoJpF6PQ=
X-Received: by 2002:a05:600c:810c:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a180422b6fmr8853055e9.8.1791337409336;
        Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
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
Subject: [PATCH v9 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed,  7 Oct 2026 02:42:55 +0100
Message-ID: <97d5632343330131e3de5874e482ce5dfa341f99.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184330_971016_2359D863 
X-CRM114-Status: GOOD (  14.00  )
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


