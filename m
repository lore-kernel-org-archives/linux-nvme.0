Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F2ECA5FBA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=; b=NdYmodnWjP4atFTeFjZxyXHKZN
	kp/hq81z5+7+SuCnqPBoYG7ZxI+hZ9wax+yAZ3S6nizF4ZyJcxYkjmquTWPv8M32F+3j7rEueDIRL
	SpxQXkQMsJP+Qr63IZ/za1o4hnwJSabEoduXfVPGvRDhtKN9gEgFuAR18SPkZiRSRx6F6ovXSxhD+
	jfNwaF5pqkR3BerX5NhKhdYveC2Xfg3cBK0e18Q6kn3JxBNM4JPfxq709WVNqkTNMSxeWIhqvsgmZ
	A01qf+oFVTM0aIMd2SZh5om5RPu/hVO6OCXYdZvQymL8bOmHFnzG1SMirZSVcmWit1qHD7124zVAy
	wVKaDfZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7c-00000002jNN-3P75;
	Tue, 29 Sep 2026 08:23:32 +0000
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTY-00000000fIN-2EE9
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:33:01 +0000
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-4885d4825adso1839472f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602379; x=1791207179; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=HbbbHcAqKggy9ND9VqQCNcpNBgAj27yC6RltaQ4+VsSVx74Xnmi7fOAX4DIo6Wdnx7
         Kq87wgcvWslQuG7ZMQJO15dN+Q+GfrPSVMkTHn5WLRUfz31cj2hWaWPNXlV42etBVlc3
         4GD+k+PhBuEECMOofy9pGdp73hXsvff8L6eISYaqWILYHrrIDzk7jnkOqh7HC2ElRFXq
         ge3a+MbfWslalkjpXKeMxz6NGhCezjUJwJzUDOleS68SogD3C0F1tJ/I69mtshuDaQnR
         jMx4cLUiMBVB3oaJJMrUjPCNMdGgVCApGedEIiru++7JgH0tjJvckDDU/HrRpes8KWhr
         xg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602379; x=1791207179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=g0vL6n23X6fHVNhzF5/+4lbm8xMsApQdhOxDN+t5IPdSRYsMl1IZ01UMP03nNx2Zj1
         EZUatGBfWL41JKaVebYoW+kW75gAhN6JMBmfkDK7HmVfUmAhCwks3EfXFzXoxj5HW/X+
         1iklgLGhY8ai/9Udk2gsWrW0EulOLQvhhrmDvEJpneCFCOPEdSFwXQGmQ/56dYv+Py1n
         TpfXN/ota/v/Vl7GPA+IdjoebHk1veWqCWgyLMn/pM0FghK6UYQX4MjVP43omL1WK+tz
         ZzVRfJX9itArPizsWWOtPAOLcFZrqKNwCBTbyDkLdA7PfzUtzMsTSHpTHBaPkoD3pccS
         UKpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwymyCDma0mXi3Dbu849T1uyv0al17n2/WUrvGqTK4o6ysrlTCE0ZFA6v/T8uTlydAL7Pgzqe0HqtOe@lists.infradead.org
X-Gm-Message-State: AFq9FYIHMtLlWbZVdM37puiAS+eduY4pYGwsAuMjQ7BDI0f1UsPygrnI
	T8T54U0XZp0PvHmHXBOY/kHNPdivYK3naUK130HP6G9CydOzZNLimmja
X-Gm-Gg: AYBFou0WpaLDQQFlRYA0llHKmYu8Le/yC+lHAHFK/q9McDQYEPm7A5uyER9WMPX0VIN
	83e2LS5jbRbz2jNziFHPG90FDc03T0oMIFjq14Zl4mEdhYxCTFK34oGFaN5cjwszosmI5MfF/E0
	PcJ6EvKMWCEmub7QEUMSGz9smHaDd5JAXzbe/0oIK/y9u7uz/Mc0G/FimNm3TcZtXWE5yFz+BYL
	CTQ4GhZNYqaX9ePoyC2B8goVMBrR3iJId0OPnMOmrVLrBi8GZq3iLJefTfX41VBzliO1YscOiTT
	fz9ZsHSl84Xn+loC0qE5eY/lYxjLprv10IKJsK+FaKd8Yk4ch1imVC5pPuOw/uOvBgDVW/P8SS6
	kpriTlKhfryexCZPvXzM6BNBnJSAHK+QiKKHGSLTjM3fZiVtKkp1Q+hz6sMCHq4Fe/h3CSsbXmk
	wSIrwtRd8U+dSZKpYtRzs/Fddx2wlSQN5f4ZulBuzhHKZkPV850xMbomYmcdC6lRD36HFqAJ4V2
	K4yK+FHYyLzxWo7s20764i1jxcp7W1DzKqwIOfXmdIzQRtIwj9CavXqillpgOqUq6GUsmEnQfPt
X-Received: by 2002:a05:6000:1887:b0:486:f4ae:72a2 with SMTP id ffacd0b85a97d-4887170dd0dmr23900440f8f.1.1790602378210;
        Mon, 28 Sep 2026 06:32:58 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:57 -0700 (PDT)
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
Subject: [PATCH v7 09/13] io_uring/rsrc: introduce buf registration structure
Date: Mon, 28 Sep 2026 14:32:25 +0100
Message-ID: <f0305198380997a88a3ed020fd6e69246992220d.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063300_599316_450CDC06 
X-CRM114-Status: GOOD (  19.13  )
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 51b46e624ddd..da767b34eb55 100644
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
@@ -381,6 +395,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -394,7 +409,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -853,26 +870,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
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
 
@@ -881,8 +898,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -904,10 +920,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -917,7 +932,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -969,6 +984,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -992,7 +1008,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
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


