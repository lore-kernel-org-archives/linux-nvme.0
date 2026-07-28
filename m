Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5EDC54F9B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=; b=YuHVzeDV2xqNtGLOb1WN7rkhkV
	FqHnI/Y0hMIMfoUShfBvL4C23r10Yh9xLxSW6+5LgNDO9PPNMA3LhtERSn/dnREjbc5ig8h8GFDe+
	gHEZMFjmPCTLOll0Kllhr/Jt66FYk53cYJ3/5lv2vmyPn86re+e1DP9pvmIz7zWXGZB9Ge0cXYnp+
	JQvavnpzRr1FnHe8XdX/R9+ITCRgOgcFXAtxkAWEZxyX/IH9rf/0bnlS3eqvvHwAJiu5vQ/sltXdJ
	puwDBOBbgiHBmkoTjpjGKd/OA5Utsz22WQ8fSEeMu5ywkLeHAfQ4bqIsyb1qkG/93eVUHM3O9lvsE
	9Y4hyHPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqK-00000006fVL-0NjI;
	Wed, 29 Jul 2026 02:16:24 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopNK-00000006KT7-0MBT
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:30:11 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so232742f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274208; x=1785879008; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=fUNAhZ0kQNr31sQd1vj/t6MJrqYisMlijzsVnc8grO7oFsqq1PACSBC271VPfp4SsJ
         ZuZ9fvNsW45TVvZrwWnFEqCEVl2DtOEoRs6XZRbgxA4/OicwghoAe9eZulaZ+LbaOLfa
         cBKwjLrW1QGG8lj23nOQRfbFxn1lM87NFffQXzh1a804twNKTb59HMKUmG3JulEJoTTc
         bZW6xNaOrgPt3JihZzi+jPZM4n1S678tdFOJGaSROJTMidy8mrgEngNB2XrN1GjQ23DZ
         9XN/z1WpQhwJXOIc2SJnOnz/rfr+eokpWSXehm1R0IcAwt8L667URfXUKHVRXezMJ5vp
         M3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274208; x=1785879008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=d1vtuGLW8gEp0w1Wc+jO461cNwfUOYPsPSxu2tTGMedbzvDJmRCQxaA3wasj6PvdE6
         StORg4IScNcoSsaULkw4EQ5vBlb51lSrpEOfcmeAUYyvLVR1QsI9DzS51jcUWLzTr8qM
         CrqWC976LhPIZGA8VJ34wN6gekPsoinEamb/TT7iC8xtSfWfjeMAPLsY8bhHkzWXHEm5
         cUttmVToGfuJEm//Z3nH9NsCHB8QCpcVJq0rfGe5OywwQqYqPlJjKI77bqQhS8Xag+vq
         6xcGMyzSxRFvwCVIr4mztyIPZrXdWX9x9MLOqpVVOc1W1kZNSzz5VzIJvJz+N6fnnlI1
         LfHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQQCmePMOi9EhBfaYDs1+o8yBs8uoHqzSDTscY5gkVYpoz84fuJjzd4CK9P55Ml4yEBjQDkbS0u4r8@lists.infradead.org
X-Gm-Message-State: AOJu0YwYhFQBH6ntF9NX1nQR2xcsgYu2yW2+53z3rTcGtKsuiu1EPYhl
	gFaX6I2Yy60g+IEnnILYmT7xRHAZcm1FOMJah7dhSQuBjLPzAYDaeEy1
X-Gm-Gg: AR+sD12X3PqVwS+0AHRYQPRgUMRTz+7EnTGaYMHLI1ZzYkE2ky6mEY5DqWNZQMLUk14
	6FRjTBgCPdrTuGyappgf0eA8qIupLXHg+mJzhuo5uAEDPssRqvsGAS7aKfCKy0zZmVIfnaxtz+X
	8HztU6ZCv4+j5SSi72RBPJtobFdMtTPjKzXXXTtuYPOltWRBrNypJHvFgT+PFKA5rzeblNXudsG
	qu07sd6HE/x3b5ULUynwE1kDdxWNTzXzMvi1NPeuTJg5Qg5uZ5+93tb+8eX9JPkJBv7XuuL2tK/
	rUUre8rcY/Ti5TvHUaNIy8hhDOrLlvO1+BhbAidt8VE5uWthhVAtMIeKN9l5WH97AfUDz681+Gz
	nm/mmVKCZV444XSasAoCrO97zW8HQGp8LBz6bmVJZIe00d5WdF8fCU8yljG1kEdjGOw098njs26
	jVogLAnhUJW/BdDdRY0pRjYEma5QnMSgwATfKGX4rSvJNqMy5UO7GZtl4OIjoC4WgrT5iK/M0zs
	xDqFH38yLfO83aqH30=
X-Received: by 2002:a05:6000:2f81:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47fb1f108a5mr5045703f8f.30.1785274208062;
        Tue, 28 Jul 2026 14:30:08 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:30:05 -0700 (PDT)
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
Subject: [PATCH v4 12/14] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 28 Jul 2026 22:29:24 +0100
Message-ID: <a138961611aadf950ce6ab9215f00ae888b8ce72.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_143010_142133_56E2F135 
X-CRM114-Status: GOOD (  15.68  )
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

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 24fc3232a66a..d57e8a0380b5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1381,6 +1381,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 98ae8ef51009..83aa86e6f320 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -29,7 +29,8 @@ enum {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0


