Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8ADCA5FB2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=; b=MhmMtmipIBDAoXtl0tFZF7uXxf
	aHiylp8HY66IPWZMTHTowr3Qzv936VVnJAyeEJtkVZ2QWI1aNmkkAubXMK9mIdVo9QCqCJunmOsX0
	wa78vpDhv45WJ4FqMV9KRxaeOBhMwUmGuPpWXZfGLd58jYDuyxdVnlx6AYgrpGVDP3fY61gk1ifMS
	tLCMvT/eHYyVGElTfr4KGebE+dNkv2LQcchowetsBLH5XcdyThBnZxnPmCvHrl9+aLs29MccVhjNv
	Ei3M3tBVy69bocUUDDFsb0/uHXfBpuXabxQL8OwU983//Mq0jdtj5FPm0BauvjBZo1m8RbC/TMicI
	kRUInfKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7d-00000002jOt-2M0H;
	Tue, 29 Sep 2026 08:23:33 +0000
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTc-00000000fKh-24Pl
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:33:05 +0000
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-488780459e2so2991033f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602383; x=1791207183; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
        b=I3EJchpeHOTDuaR3GNe6bSQU9O6+8pDc82qI2Nrob3QEN6WjRAr061yqrba3aq+qXp
         rUgKv9hfMWi9Qwh78cJiN9J7BrX1oIpqiCmkPWezlkUCSjlO98twSX0r1pj0rvInioiI
         LTFThpYG1hB39Vu5u2Id9q2/yii/zi++uk7UI7vTdk+//lFGfYFB9M3qgAD9w5/jMdKf
         88iIGF3RovyY1hj7Vu/piDq3FVGGJDo+J3FNK7KGpv1iyYVyz+qwLvsIycGtr63ZXdj6
         rOqlQ5yKY4crzWP+GHvef5sotX2JLpBRfV6oclJ53patt72saQ+2Cys8Xn44cp832eUw
         kGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602383; x=1791207183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
        b=w+jaWC+bBbT2OCJIPCPvrwnVe3Nqo4V27dMXY8vbiO3e0b9WQ4mNiDqjTmaIp2qzzx
         WuG0sWFHMC0YOj5/jVb/QjuqG6ZpKUgiB7aXoa6qg6HUyJcJLnLlLeF7aZdjTzf+DGuk
         jNMGCflckzSpRm8+M5whWPRUFGlp4nKRnUHw4dkipPsLjDeCPiPXKuwsQE42XUvMccVv
         qvUspnrkpwxu2Wk4kN0InnHfAn0xy1WIA9AXzUey//qk/KH5A0bkGDDrEHNk24Ki3uCn
         eLiQRp44nDthpcQG15GXs88N1AN02HqEg0nBuWfG4CG5xIly34NxRVGn1DVqp3+IOLtQ
         Akug==
X-Forwarded-Encrypted: i=1; AKwUvBxK/hHQoS15P3NsrAwQ/Yuq22IQCQ2Xmh8u/CsZRjZc+HJWvxKtnfbtQLOxtaoRmhmi/EeitbEivjqx@lists.infradead.org
X-Gm-Message-State: AFq9FYKbT8JbZFqpOfuWdnboh/RZMr7HH8IzFvJ1Jx1XQi5OS5VMuhik
	xJW5q42uFW4UJoo8mcg13yH1rv3AlmUXirDR2zid1hnvFkxD1U6JNa/J
X-Gm-Gg: AYBFou1jBl9kAaiYBbbzI1yFPur+BfPKkDdGPX/o/Kq300elHsGeNMSz9L4LtCxuGft
	CSRcA6F2rKYs4V2Jyog811eMce735VXmxXwir/Q0kLLt/QfcNOMhziINmmeXfRqyMj37u4NvVWb
	i/sIXW9JJ8DoFrylzV0hpCjAXfvEEQ1iLttzsZv8cG9545wX0OYroIyxUDmdPSCeDE1sitw4/Co
	CJ1ley7HL92fS7OAGT+Ep4ebm45qJ4qcZSFumYN/KAINoaXmkE9zCLPj7Jwr1zvmH9fzW0Fp29M
	t/lkrbHkvy7eeYE08r5rn8kkmjc1gXYgrpDjM6RLnizO8VE+kqD+7OfPrQsNzn2UaWiE4eckjZd
	ElMdLNPTV2TVc1KwZH2ZgS4rcPPwNPDBrCYuLlOl8OvnOP54zja+iE83IsimSdOWJQuUqNdIxT+
	LLktsk9M32pOX264yX2vClV7jGwsXp5/Fel34IZqcsznHk7bWSpLPiMrKHqu4WGNf1ylKuRghUk
	1UT3c48tOZLHP8jIs7h8NVKW6tA2MkrxZMr4FTHTHCBNFn9XCTH85mxIOgelcWKm9zbvKPu/2pV
X-Received: by 2002:a05:6000:2893:b0:487:10a9:57cb with SMTP id ffacd0b85a97d-488719756c5mr21965332f8f.49.1790602382736;
        Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
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
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 12/13] io_uring/rsrc: add regbuf import flags
Date: Mon, 28 Sep 2026 14:32:28 +0100
Message-ID: <692972b0ea345774fda580a53e2b1bbe5f771aa3.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063304_559862_94278368 
X-CRM114-Status: GOOD (  13.98  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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
index 65d6cf7201ce..6f6860d6ca03 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,9 +1298,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1709,9 +1709,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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


