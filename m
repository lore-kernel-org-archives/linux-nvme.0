Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC0C55184
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4DE9iwPHyfteVjhRD5r56Chvjj2EVxXiQr3A0KjARNc=; b=v2qGYpn+ZkQBNeWN/OzCPGURzS
	NOS1NesOzwNFiwmHmV1ggd3T+3UWVGk4CTwqUuxTEC2GM7pGBCEmZ8EY33B1ohwXiAqCrVtJpTn4b
	mHefZ4E+rK9cTdrZ4saiA15aAV4p6mYc9LVolsnMd32CNWNGufS8A4a+YdeE6ldnJUMxNlC5tkZwr
	w0tJ1kwXxAMvPvBmZk/7KqXkv0lQrYjfxlIpD6LyT+fMTX9pCFZVk33QgLhVyjdyZ25GG/oQKYiPK
	+yMPsBTfn1uCcbBlTkbHZz8rQlZhpK7oN1k6k6VjKgzNCdVvx5oWHjmhUN404Id/JZqAFlorlPtG3
	5F/Z2p7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX8-0000000FONe-0Fdi;
	Sun, 02 Aug 2026 06:18:50 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqC0Q-0000000EpOW-31Ny
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:52:12 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d02b4c3601so23016485ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599530; x=1786204330; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DE9iwPHyfteVjhRD5r56Chvjj2EVxXiQr3A0KjARNc=;
        b=H6HeY1iIqCa/PzpEq/iCykjVB0rPFXkGRqm7R7Mo7AyBhvV+h00ps5rCjscaOo6Cgx
         B+ZrvgNO5rk9nklLX843o0B+Nid0RfV16xhTyOwQNehJzps148sO0GpcjLKRMNRmLzBm
         FAVtuSNwv4OkLnLt21456d/d66U4k4Mnzr610ejZAduhXA6lgmeP+4JBKTDEKyf68LpT
         bJZQGTB2vquU00+bFmpY+iyyKcxlHmGjm9ck/kmITQbiik28HuR37+omXYxZnLuE4zYk
         PMajt/+503tuVYiDBbBxhVMfwpZN3+kTFLEjMrTtE7RWnpKo3vgmOgMnqfEK6JH70q/Z
         Bzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599530; x=1786204330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DE9iwPHyfteVjhRD5r56Chvjj2EVxXiQr3A0KjARNc=;
        b=gRqdntJwa0RvdGaLQbCR/lznlItx6Bozg1dox/rMaXDhg+PoV3XP20+hH2td7+Qz1e
         rFXpf9k8UDR9sKJVOCczPhw35ZeggWRzXoBeTA0oqzIOybEAA7VsPyL8TDkDQy5C4VQq
         jl6U5vkGAqDJUqzTfP2+PPonjzs/wFhqN+honaYXDEqx0V/Gw4f3OiWn8pLqVO4XorPL
         plJHXy9rmeHVxPPepBIeNRvjdjz0vse2szkQhKAbwT4JQhx9cZnN+iNvoOd7Fkb1Qtcc
         dBvMJVTW+z18/9Wto0Vt5pkX6JK3srbNBcqrtXhI1lHYLMzYYf1IE2//tssxdDo+OOHB
         eqvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLvukKsF3DUH1NcmeRoebBTAU3pEW8KTJ0dC1ufCkk/gg2nyOkhK+8hiByMdzcZ75ee1nt/hf/LjVX@lists.infradead.org
X-Gm-Message-State: AOJu0YwoNxJWyCVqSWt6azyRUMUDZJi9wea1gYQ/D9lJXzIuzxAQh8cL
	HbqA1+vzKy4HxGzYYJMKJXoJcP9KPYGmSF16LNPjokrXVYyynnCDqPmc
X-Gm-Gg: AR+sD10xZmyzUhL0ea/dw6/Mg6mvqp6Vw4gKEYZunLWDFbdkN0CasqjKU3gRE2ATkPp
	j6fgQwrkBdwAj0IdokSlHGSDTRjdJZ8QJAioh/CIm3j7JUUUDBsbKzJlGpavHbPpEWeJdQ6VsMF
	0Nh7+eaEggkljlhI+CIf9D6qW8Dd3PfqkIik95BHdSK6f1HnXnOXAm4n+W7e5aVhaRksTseJazG
	ZsfIKaswVN/bj749omWB8U/bkhkt0FxpG9/B+79NbsT8y+abBKPZhBqUggW2ZOgkxlw0zDwqfLl
	7OrHxix+0y3bIeUm1fhBpZLhNslbT/ypAkKVCK93Qr/YCSBGZy225bOB9fg9NcoBHaEctjRsfqr
	bjCV5HL2nC/jacTbDJjSdXZadtS8gZZAZRyzeAQ9a378l2RY0ntX8reQaLPWLaypxlgYv4IzNwK
	YLVo1Bim+Y9DyEBlsYd6q8FwV9++je6aR30uY6pLlCedk+dUrIkGX2pbGHsN0nfwElq82Q5b/em
	rAXxNQEYjQOw9yqqeVVXEGM26XyhtrTYgQme03HUs8vMzg=
X-Received: by 2002:a17:903:1aa6:b0:2cf:32bc:9722 with SMTP id d9443c01a7336-2d0524671d5mr36849685ad.34.1785599529680;
        Sat, 01 Aug 2026 08:52:09 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:52:09 -0700 (PDT)
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
Subject: [PATCH v5 15/16] io_uring/rsrc: add regbuf import flags
Date: Sat,  1 Aug 2026 16:46:27 +0100
Message-ID: <ddd0458a78fd1666fb109993668afb01d35bd155.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_085211_151168_BD4C4678 
X-CRM114-Status: GOOD (  13.48  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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
index f041b0db77af..fcdc4edd2858 100644
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


