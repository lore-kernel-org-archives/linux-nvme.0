Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541EECC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=; b=pbrfGc+iT41Mn2muirhdOvDhCs
	xb+t3V1+FIqSt65rDi8aH2X2LwRIvoIXHhHn7IVWE2JZ5K4B0cfukTQUCE9qioEJ7P3vd6W2C1oHr
	FBYo0hf7/o0sRQIqcClEId8GErtZWHZHsDX4Sqc2FeQmGWmxyWuALeC/HCfDJWF1rKCA6eIWoFiv3
	lBVLbjS8R+TADjTI9fzAl/sh62Z1JzolWyX5u3s6XS+HfR9M7fL5RjxX/e/Rhgr96UlwRiycPVMy7
	LCXae/hcNP/Qqswn3Vnl8v8DRIHvXmiiYDixakgao5Eo3/FDvfYPE4Xsnq5N0UL6eKXUciSWx4+JR
	v79seJbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxo-00000000TTf-34bh;
	Thu, 15 Oct 2026 15:01:48 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjX8-0000000E3K2-3K2J
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:40 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1974173f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924937; x=1792529737; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
        b=TWpnEPi1SvUqiLDBK6MoFH2+tXDHFf4CP+QlA6sC7ftMRL3pMGrsTzm7F2nwGF+28c
         46RrEJi3I1TN54QVZBetXDvQ0YPotS1wxn3W2Ab6nN3EMO9qwFWNiNrQksRF+gY6qe+U
         CrIJgJagYxbNyGnnlkdzGEj0maHRwmvy53429POZ6J3n/7SdDQrogpV3spoawd20WECI
         Of2eSkzWDwXLDoKnY90JDAcp2QDdba25VrU2OD/JbbH6J2bIDqgZe+SlQqZ/lvzx8xMB
         wuTrL/fyk5ekjhM67zRwrda6xaIV5HZjnroZKkfeY0r++owRRPdkq92BKEnpzCGI7noD
         phLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924937; x=1792529737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
        b=EIJgFcvHCuxIrNQioWvdy3C6JaFG4ZbOoYWuX+W9pAqgf1FtC8H5KTyj+2aqoBQ8+K
         DFJbSlPHd12IpbpIe34MMrovS5UTnXkjCQ7vWM8OCys5iurT+8x7eCi/kWhUDvybYwtE
         Ks2zvwL1L2Hx5+7bzHKovd6MW0UP5ZXxcfM2fzwubt+LCoIRr2kirdH2Gl8qwzuhcCQt
         ULu2q2dqIDjbElrnKpoKTuVTgIaSH8JX7tEN7GP48QT19U35QCtsL2yJv33pdA32BrYe
         /E2GPILJ1pOZqsZhDzNffpYkew8OIoar+Mf3RPckU8mlF+DcP0P8BdEnndeB7QNZNYu8
         zWlw==
X-Forwarded-Encrypted: i=1; AKwUvByPgj2xgcE1NTJrbntLnYM7BWUPL55OVfk5SMk+mVXfhdOSqgw567RxjVaV1jVC2c2vn4I0zeNLyws3@lists.infradead.org
X-Gm-Message-State: AFq9FYI5bOhl+BwunVxSrWwyn0q6wE+lowVujzx4OVqQ8QCymYmDM4+q
	8pBMCaG4dQG28pE/8QnYj5Er6QtgJLdi68SrN+k4l5hypis298QoGeKu
X-Gm-Gg: AYBFou0aZPQaQwiNjnRB4jm3ntGWPIx/3dkDoQh8+VDEwXYt5m+ktAVrHo6aSxSGUEt
	EOU6c+sREL/YiM9x1mOQFROuaBATsgfTFW184BB0SzQFnr1KNkQZ0mVLZrvIFmS0CpaLMcqzpMS
	PRpFHT1COV5pJjCnKdSPsuaJB1XW1vsq7jUTUzFnAwjqQj1v5YlgXRsTErNlXAUzO/ozPG8Mob7
	EXVE0/efI1UD1ZrbrwMf0qx8QBVxF+TjJ5IX9q9KzqSAzqbUgjl38XOducsDFXVjHWDAGz9Svus
	FKagGiVWrC/SCK1mBdyHICLb0GsGciK+L+l2WrwlBEOVdKX4Vqe/uxzEyr+rPDurFAdOMSpW/W5
	WjPJtCIwO59Mh5raqXB8CrRVvHJx/1ASicExJY16fB9DTFrmaYxUGzMXBVZTzeawBDgS13BXJoN
	9vM9ZvMy9JC6p/r0RLQJ7jITsbi2dCF51FGPyHIf6D3sU8zlo+g8h2XT1NfgBCWWZ/H6t8hjmWU
	e37N859edA2Sgp2rt2ah2OkIw6RSrrWzdPbtXP6YUs735vdz29Sxft+SLwRFaPX+L6kxVyX/Idx
X-Received: by 2002:a05:6000:43c5:20b0:487:27f6:a4df with SMTP id ffacd0b85a97d-48dbad3c1e2mr19287115f8f.47.1791924936713;
        Tue, 13 Oct 2026 13:55:36 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:35 -0700 (PDT)
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
Subject: [PATCH v10 09/13] io_uring/rsrc: introduce buf registration structure
Date: Tue, 13 Oct 2026 21:54:53 +0100
Message-ID: <52b9853215688e10e760ba4d6b4d9e91d56b6756.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135539_366255_9D21381D 
X-CRM114-Status: GOOD (  19.33  )
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7234dcdb8372 100644
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
@@ -870,26 +887,29 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
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
+	if (uaddr != desc->uaddr || size != desc->size)
+		return ERR_PTR(-EOVERFLOW);
+
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
 
@@ -898,8 +918,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +940,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -934,7 +952,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1004,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1028,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
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


