Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D2FCA9EBF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=; b=VEUL25/98X5O0ZhQ+/SbFOwFzD
	egjbS2wWYcNOha/bzyA8JClophEjfa47TjlCFRFngBSrVak0wtG13+oDwHuw0cWPh/HZrwul7Heht
	EucBlbmeGFhHKcmUUi+rO0HLpVv83kV7J/ySzEYVaj/RXDSyXoA0DBF4aaHQDVA0GjxF3N7Gg/2GN
	YCKMmSREHzzXPUdCit+ngzTrzZG+0PTjY1skV7SDTP5809aI9ieq/k0ER3rFa2NLPdlmDPT65e7/P
	SSnbvJBAHY6yvbdlFeTCrbYrpJivMLHqcRmqWWieF2JJdfgGcXIrJAyuRP0GIJjLzRe8dwQiLuPaZ
	tVIRZ6IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtr-00000006hw7-1nm7;
	Fri, 09 Oct 2026 16:56:51 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgo-00000001cH4-3z20
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:28 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a020e65269so9829915e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337405; x=1791942205; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=n99KUk4orI//8Z+Ad5VeAQwg27lop51BdpnLLPLEeg+Mh663BUMfc2+3QIhd+wsbwE
         hp1DlX44c+gIBjm2peawJlK2CAGQp7UzhnftMQxYU6vNx3FFVknJOuQMMOtja7dTowbO
         XbvD0wyjED7KfMFg990D70bKpuXeAY+BBRYhcDBL9arkH7mEWqv1Kfp5Zu4o0ojufG0L
         huhXAG5A7+I21OAotX97Lk01vyspqJItgnLCcVA9MBNRzUodGuYY6Nxgv0EgeP7ldJI/
         zZRX1At/NGMH5hGsL0SFAyj0aoLLUmWpaFiF9vkHO3UlYz2Hx2EarfAq2t39Eh6f2BiW
         /kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337405; x=1791942205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=xng3xUYzigRKFJNYVS/8LBVaf0ZOrF6Cg0lwVC59OuesxvLjfDoT33ryPqK//W+uNJ
         Mm5HqPq/myPqfsoYLfil5B2JUwagHHPiPuE5NSzCzdqmK0nkAOayGefl0+j7/S5X+7km
         xBjL8p6j/fUqfsHB2GGbT8njxY/5NKVXgU+M1QSXH7QKt8myouVyw0FfGH9G45aaGDb8
         DmTzmvpv8iGL2LqSW4MUyGMEBJnDpv2QMFOKhjzuZtiKng8qSlWBXVLFMumk4yqohCEJ
         W6EyRohk6qhdMVBV1amN97V5cqQLTt86K/prBRWQu0HWWmPg0hQDheozGG/7ttrk95t3
         rWqw==
X-Forwarded-Encrypted: i=1; AKwUvBz42m5xxPDrIPNn8GUhYcfZYFIzmOHgxkjC41SNqPsvNCpaockBSihn+ZPyizUPqAJUTSWtoDy11/Jd@lists.infradead.org
X-Gm-Message-State: AFuF++mLbFkQL2GBQsiTtKn9d/E6pRP//d6pDptaNxTZes/oVTM35qI0
	90/eSpEcQV/3akMHkkuSeqXuNQfwAoiR31JBcgTp6haWHb8ecBMxksP3
X-Gm-Gg: AYBFou31PA/1L0QJay+V7LBQ+8N3y0NTzpgTpua06kWkjhx/y2mfEhxwPWvZ0RBoxt/
	CbzrIGGU7oOpBRBvFmFy+jm6uFXyevEUwEiyi/E6042FD5G6nmH0y/MTL8aZevMosbYmBjOstJO
	SbxF1IpifATgIZgjI+hNJlXJU2bgmpJK5aYLnvv9t7daN0hvccv8e1QjJDXRWcQ3UTyVGN44EpK
	WD2spXg+Neki5tai+SlMKnmTjHJ4zThDUVdUIPS/f7mWOnVU895kWaGmQ+Lig07zwlzBKFmj6Fi
	ukoaLFTUoY0AXLVnGVgdQfvM5kmb9praq+7XfRcY6Jw2nK8lTH4rroLKGpdewW6hux8oO8N+5H7
	u9U10UWxG7dDlPtMWbpP6mJ/PRhM8r/m/d2RKEkkUcoRACnXRti3eF66aFFEhydzyLfLk+Lyz/H
	AqztT+C27yaMkX35YG/49JjB4Dln+RRjiZWflZoeuutQcL+7aaRC09O+0MI44T2hWwgabp+4Az0
	ya7u+leF5BNXTKiMFx/euZmxdUhtSVTxxrV8BnmjIkt4iLoihFIg3SqDS5nWh1cH6ZcBFtOF5Qy
X-Received: by 2002:a05:600c:3e16:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a1806649afmr7712265e9.30.1791337405094;
        Tue, 06 Oct 2026 18:43:25 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:23 -0700 (PDT)
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
Subject: [PATCH v9 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed,  7 Oct 2026 02:42:52 +0100
Message-ID: <82a5ed8b6de7015b9ec3c6aac51ec2597749a1df.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184327_012625_218D6DDE 
X-CRM114-Status: GOOD (  19.26  )
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


