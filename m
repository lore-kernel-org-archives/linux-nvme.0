Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8F9C982FC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=; b=J4nt+iNeBN5o3S2ojTqShbsUiB
	BdIJlISszYZok5eoLqZ8B1IYZsMxCFhPkW3gfs4lVP8SkaUo8TlIT5PM0/CVGdeFTFXA2tlNHyp35
	Ai3muieBIZjMKmvZ1hWncNJz9Yv/o36vhY4yeyKc34+2soiR7l+uE33p1WAMriIS0lJz06ek7gHcj
	2bxhklYwAz73bxAQ48v5oxLq3+ttkTHJOq3+55sNHXvwTrnQD7xyHjWWo1x/pDDrpfrmIjp3KKf4h
	W/hBmrB44JZ+UBwwIfZNetLfGDkxJpHy/tD5ncYmWvIWPXTc2LMk/eQyWg9bYoeOUVbj7fXcn2J+F
	Ji0xnLZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWG-00000002VjJ-2mMd;
	Mon, 21 Sep 2026 15:01:24 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eFN-00000002Ga2-0kMY
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:54 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso26283495e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997991; x=1790602791; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=pB2ddW4pkV8zpNqtZOvFVXXHG7RhCc3J+9zmuqYYmVSVnLGm8hvcWrnbcD6Kkrlzyk
         Ew+fomPkhTE/FwRQRBLvCvH+LiaRCQiC8twg/fUndG/sCfTSWmzJmHc/k0FygA5aB/b0
         cnv7+gg+pu5WlOb17M3aJ3JVPNR8U0WAXdAhXUF9PCq9pITWbPf2YLmDwuEfxtu45XJa
         nVaVoAgLXsh/iNESe9SBcLfBSS1N1TmEeKNLa/NMc95NoRcLbU2lkt+h4vREx15bC/Uz
         m8Tb2pXJMedSJJpnJ2YcuSLGJKxRzNBB1Sw9pM14JkRYacQ6Y1OJSysO0b5Lp2kolSwT
         rQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997991; x=1790602791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=CsM8HSmb0EzbzKngmAm5onbFnze0rRQ5WbS3RlURQ0TXVTci/IpM5imcqlpCf8tRzR
         OMGlVf3CwB+wNJPwxUS6n4X2oj3f/EHDs76ulV898TmoD+rTZTbR4OuK3+0l5ak8ri1C
         mMiP9/nli64bwEqNgi+PZWBIvP4QKWDvf2CRM5x093/C29ekGK2epeKxPreysE5w4J2m
         FFp0T4xluF2cll2D4njNBXvd6JTGm+66TcHYaFoZX+k/K5sap61x19ToyYd4ch1ZIup3
         gpWiMVgk9gltVBj2MsQusR0ZtOu+DoPUA6r8W2z0PDdjpsMtL8OBTefKjShWlzbJyzWh
         4bHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8ZeqnqG4OCYpZKRh3M3FQLZj2IiDYEItQDPc8clUiPN+W31LJmjwchk3iwVLKhKqdlc0VnjKUyInb@lists.infradead.org
X-Gm-Message-State: AFuF++nUctfUVUyMykIb5XXzPlWN0ODGZ18PwGjbalBGnIt9Bzuy6ZW7
	B5NaxzB6yRXkROST7zjcF75nfTOJ9sMZZDfWDgORtMbKbStXaVQ9TZBG
X-Gm-Gg: AYBFou1bDhbINWoLWrJdKJQWAOaqI+/Qm2WCmQMoiLGDgfpMfOfI+ChrehyhNU/Kmrj
	DqnvxN/F1SUYI4Kb6PHCK2xrtp+IdF/Fb0S6pcWF8ltE/p++/nik8Tv6LvSZQM5zkxWMIc5gB62
	Bt/LPK8ROjbfHUthldVntc3supWulVa49JPZ0/Gi1CV4u60BQ7xW84fymuzsQngwyV4ICz0zo1A
	o8GMRLnjjHCA8O2E2onpZOpIuT4t+2f7aqbAgPSgB43bxO/itivJKVMZh1KiOMwXl5tPa/RY94b
	mu6tIrDSrfRvc0LDOmbQYvVPPBTruvvLJqpKAjdspNKMj1JTsbEvC9pDWXgybn0lzTDOlPwCO6Q
	x5pUd54qJpjNiLCfNCxU22+0jIEteQ+9G4FCg639wPTIRGE3bB5eezVHiLRlz6k9Ghq2ECjziDI
	zTP/KGdg+1S2BfHwVTLVp+WcGD93U6Rr5GbpBF+NDA+qnB6qpgyZEFA2tpxBKbI/fa021I0dXE2
	WGijIxKJP99hmAyISRwC969A1ieiX2cGSNfDHtVE51w2VVCVtgdadAy4ZbBmMI0CaXZQtqFLwaH
	oOoK01biVvqGD/raIgLoZQOjxV8cmQ==
X-Received: by 2002:a05:600c:e558:20b0:49f:ce73:5e97 with SMTP id 5b1f17b1804b1-49fce735f5bmr54726715e9.35.1789997991415;
        Mon, 21 Sep 2026 06:39:51 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:49 -0700 (PDT)
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
Subject: [PATCH v6 09/13] io_uring/rsrc: introduce buf registration structure
Date: Mon, 21 Sep 2026 14:38:53 +0100
Message-ID: <13677c50b853ec0518528ad03ba06012342f1316.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063953_406534_782BA470 
X-CRM114-Status: GOOD (  18.97  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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


