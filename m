Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FC1CC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=; b=12NpocXTAx5EMpMlM/xQ9Zoyfe
	nv/OuP2lu8JPejjRygPURaQQ93aBJV439Ar5I31GhnHtsp3itqv7CmEoZcqyOvE0uhQ003AmWYQAM
	LHgT1tsGlVgwQZ1I7YY/4eJQG6T93LKv8yzoOu6pII9ESUdmtj3E2h+ShuxQp/5UUjVjSwyHgpFCS
	UCNQopmVgLe2rqrebiMhrS5LDLLmG9yD60GFcTsl+Q0KDsARhkgtvRnwgJ2Y0bYBJed+11lXyS/3k
	2EqPPezHpnhjHQBYeYeI6Ff1z4CX5Plc+RK8oMiw7A4HHhvbLXjQgQi1id1NppFA6ZQEIF1rQ/Cbv
	PJa/v0Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyq-00000000URN-0gKJ;
	Thu, 15 Oct 2026 15:02:52 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwku-0000000FHEi-1h7Q
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:53 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a01933b584so34775185e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975762; x=1792580562; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=HOty/sObD1vVFJR3Ckq5F8CqQz5hWj8C2GmIdNLauInF9ckcfSSTxRq0HomiMqJ4h5
         DENqiwITgfakpa0XccteDHJ6KfwbwmgWQCZuQ0DQ/wAn79MVxjJuxVeQWnK8/CAd4ABj
         v3mgq3IMU+BVAgeZCwhG2VodXG6r/v9FbiAZ4hbpEW1XHY/2UrZszzVIFWWbhiI9sBkg
         0lh8DQWmKRUMvRbTjZYJxYvlIxvq71qzMS4molc1twmg/OKffIL5femLM9E9W9w9bpbv
         82WfbknyV7WpY3fmgXl/WuDz9BerY0RBjSB7b1hjdupRxksNj5eGwOVACqQmXVCCL686
         KrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975762; x=1792580562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=B1T1twzG3f8KrsU2FPkW7O6IFAP0jdyhZRQwFD6kdYbab/nNZexzB2XH5w9YM+xpQh
         i5+7iAsejqqVDcMAafMq9BHDi06l0l35sNnJ13yYg9xtKVrZm9w/KtprxT3rTr95oeUK
         ovBgVSu3eJMsfQxoCN5ttq/Wex3gG9FtBoxxODxo2P/YbHjK83TSq73pvP4W+K/pgWBs
         lX2ltpMJPLqNs3KUI5o8GLjw9tgxDR7n83mIJoiFTUUCQnlJdbGETjylG6/0NRJLYo62
         T3k4snfWlGy0MdrY9CXrdfDJGJIFIW3PcOhWR7SBT3LSUD+CDUzDiaH5gpiQ9NYjPMcP
         q/cQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhwiOEJmUkb2SzdonI8ihz0+hdtx3DtNEi2dWs24DoH11YQyYxJyoOIwjbuu/2EtODKQXmbrXsLx40@lists.infradead.org
X-Gm-Message-State: AFq9FYJeYKlk+T0k7m4/Xrxv/ncftE9HVyq79jl0t4z8vPJGJR9o84/B
	6tcsw9io1s+Lwoxog03aYh328BXsi4pLZ5lRaURQuEBfg741ChAEC2oy
X-Gm-Gg: AYBFou2WHOJ5OgTxy3WwK4bbgmsb4MLN105SQ/2NRUDF5sXp2ojn57q+niXqln7Xj8E
	vJ+tuuKxexD5uptqN4FfQSiDcWBr/lmGqyGtrCAFsjCQ+9cMTmjoL0JBmgFoxomo82EdfTB9qWj
	gi6axU04YtAFvtsQSS6m7e6qXaFt1EGiNNVku7AkEQga4JlQLvWHRE7q+0DLQaEbTNJwuZ1sFjz
	SW9KwIvbSLrueeBUuUH2IgWjG+VENrzm715xIwaXPJyCFhGLOR5VkL5ON64AmVM5WDX/3NdKW2+
	kGJ92EWr3al7ncdyzhKNEEhd9NU7+efAxyDLtGbJd0wFWEiunPJrKfl9td1dwUYIm3eyY1Kqfip
	O3w2CHrqCrSVOMqT6u0KAow7uVPuG7l8LF9CXzMc8708FtKIX24IBsvPKfxIm5VEw25WkIvrD6A
	oM6RYBr0CgtideJabSnSaeZWEYpRCONazr7dctIswHUC3wV0Bp9PtdHWbm//QA4HktsndAfPte0
	XfSMO1nrhdfDOaGFUltd3laAU1cegmcFfP0Q+MDxRDv/lBUgtkXRHdKI2b6wwMSwcE2zQ3jTTzM
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a18e4a9159mr329602185e9.19.1791975762395;
        Wed, 14 Oct 2026 04:02:42 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:39 -0700 (PDT)
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
Subject: [PATCH v11 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed, 14 Oct 2026 12:02:10 +0100
Message-ID: <eb798e045bc245ebb7b0b42ba09a34b92f8b216f.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_040245_583092_3D2C48C8 
X-CRM114-Status: GOOD (  13.79  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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
index 532866a1e9b9..f42d201738cd 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1317,9 +1317,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1733,9 +1733,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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


