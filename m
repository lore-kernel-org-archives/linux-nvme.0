Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C64CA601E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=; b=CCSWDWv7jch9gkYbsu09AMnzbn
	KccGBY3Mm30gjVvITkudjvszQ5PsSuWocy0ywZxU0s6v5lv/LEDvcR+79N5wG5NI6NNdBpfiwp7Dp
	wpcHzEwW2Hkkh39RuqQq8NTploAJs/FFQfFzuRiFtnMfGQ3twKwyXrytN7FVqI2d63h/1rfS5NxXu
	/9uIDmYhu0YYah4XozxTKcTI7DdNoCk4JQB3Q1Q7o70kghBPqFuU1JbYe7jalLV/pRQrlqIsobtUK
	q+eQC6HhClM+ds6viTsDCWXXO7rBY5g/YTiHngZRYbdayoT7fHpIcTg68NfAZswcGHWIxRE4pS14P
	DkEmIGbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtf-00000006haB-2zNS;
	Fri, 09 Oct 2026 16:56:39 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGWD-00000001azT-07IQ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:34 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so21778115e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336747; x=1791941547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=reR62My2sgwrJvb+ddcRo6Hq/rImqZyLypzjlLYna7oe0+ek5U1ddfuMwJ5cLCb54R
         DrH/LdUV5wk9mEHTQRtGRX9OBjdnnUE8f18ajkcXOyN9o5K/SOE3sjQzKh6SqDGvcAXe
         pqSH8tZpRyjiWGrzQDRZw21fwb+cne09on/UuyZ625W+3Yjb8gVk0ynmsUekQ0P7ybaS
         UX5Spt5Cc4u4ZoSkmmggcpw+L9YJuG7tiQkFFHbGPPQdmdGpTkKaiBH3gi0r4fs231Si
         CgtuJ774CJvGQ8v7ymVUEYUEX35WQkbrCq7kirEnMRfI8MzB3+hM1FekE2RLQc61NGYq
         QuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336747; x=1791941547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=UbxVUIY6QHlvHE8ZHRA2wAME/2s8KMS8V9aCMYR4ALYz9GgudGA+F1w9NAJsX2YD07
         7UEaJD/D3dED0NSHsRWbN6bag8XBaLcG/uFvW6d2W2JqPcSWJZnP7BiQ/8P6pVIbnBs/
         Cfh03hTr5laizRqnzN+PkyH0maJRzPakG8dvF1dL/5UupJTtgoFt1Jdl/OSYNL/ltKPN
         Trgfhb+WYfSusq30IsvLmXMU6zQcMLEWQV3gf5FfW4EYi1dTbSfqhQBdmRTqSNVjavNP
         0iOS53E4+yRP20q2IkYw15iVcjZt8zd2i6lrV1AN4hYEcyXIbPG6vJDGK3MsY/ijg+Fv
         TPmw==
X-Forwarded-Encrypted: i=1; AKwUvBxno+cJ9mdX05H6dYQeqjHKUSX/7TOGoUIZGyyeeIMDRLaQWJfFRU7DBenj91G5mZVZitRfvCdv8ONI@lists.infradead.org
X-Gm-Message-State: AFuF++lSdStebdAfBQl1Ziqgf8ccgxXfDaz5Pbzg50UQpDH5u/g4XPJ4
	cfW0Wms8+Sxq1qKKv0/fITlfB0UQzL2CAHSgpXopqCmq6FoG8ef36jth
X-Gm-Gg: AYBFou2gcJaF/PdNOJ2WlHD2/OMTjQDKJVmsPYUNtpOjwM48WJ8B/9HyUI/ujvb+3m2
	DGfZg/xwBSB7s9nU1qtgvnfDDoSbZCKWmVSmNvenllyvYwuRBG1jWbPmrhGsoEnyglrF4OPIm9f
	DKNjOrPPiiXpFenN07lvp9JCCVSFgQAbl44A0hjWdTf4rzxkspeLYF4JE5WBO5OaEj3VwvS9Oza
	UzsGHANxHXhzLqO3/S05cFzHsjQ8Xf969Imvj7+3RprQlzCCcZejxBHmVSXlBLUHBjWOKqGiH7Y
	ZuJo9jAwwOZXHRDK07ZOGm/OZdeltWCUZH82FVBt9hwKZaDobevSjKl0/sh7/AB4ztqmYVrs+IM
	qGVp5bfJLw44HiB+RlUxdDaQw01FrYk7gbHTrHyYfFQlqsGSxiHfqmoqG5Z3wI4RcIaAblkdtYe
	Q2Z9lHYAluwCgPzskaE3XtAJCaEjHe2nvlV+GNjX3EpBTaV3l2zB47AA40mDlVbxGby9y7aLRrZ
	o7FM3StiPZQTGqZgLaG7KCNS7/7DVRpgd1qVLkAVg5gJH8V3HhrDnIfqibeHKuHbh9Ub7nHERzx
	gA==
X-Received: by 2002:a05:600c:609a:b0:4a0:c4:a1e0 with SMTP id 5b1f17b1804b1-4a18031122fmr6686705e9.9.1791336747330;
        Tue, 06 Oct 2026 18:32:27 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:26 -0700 (PDT)
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
Subject: [PATCH v8 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed,  7 Oct 2026 02:31:52 +0100
Message-ID: <766ededb7a1e3b4152408fa17dbf92f5c4a34c90.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183229_126433_5E8EC5EF 
X-CRM114-Status: GOOD (  19.27  )
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7e58e9d96055 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,13 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov);
+						   struct io_uring_regbuf_desc *desc);
 
 static int hpage_acct_ref(struct io_ring_ctx *ctx, struct page *hpage,
 			  bool *acct_new)
@@ -81,6 +86,15 @@ static bool hpage_acct_unref(struct io_ring_ctx *ctx, struct page *hpage)
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)(uintptr_t)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -398,6 +412,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -411,7 +426,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -870,26 +887,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov)
+						   struct io_uring_regbuf_desc *desc)
 {
+	unsigned long uaddr = (unsigned long)desc->uaddr;
+	size_t size = desc->size;
 	struct io_mapped_ubuf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
-	size_t size;
 	int ret, nr_pages, i;
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base) {
-		if (iov->iov_len)
+	if (!uaddr) {
+		if (size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
 	}
 
-	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
-					 iov->iov_len);
+	ret = io_validate_user_buf_range(uaddr, size);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -898,8 +915,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +937,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret)
 		goto done;
 
-	size = iov->iov_len;
 	/* store original address for later verification */
-	imu->ubuf = (unsigned long) iov->iov_base;
-	imu->len = iov->iov_len;
+	imu->ubuf = uaddr;
+	imu->len = size;
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
@@ -934,7 +949,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1001,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1025,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.54.0


