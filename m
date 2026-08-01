Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B8C55162
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=; b=HJv0U+iH5E2L01wTcVOOyN1jG1
	LXQS31uEokkGak8tpKjMw+5Hh7j4QjTYVOddWlYVuxeaMp2ixcZlOQeUxhqbKlY9m8rSEsqKthTqr
	f3HVHqBwT4x8hFWD3tMgdpBmUMSYxGjxIjHTzHASI8k8TwuQztBMG3Fm6PnMAw1uHRgeE2e7sHhWJ
	p5qsSAc12F5SVM+pUUElCA3/SMbtQ1ofB+3q2XZCu1wSPOHbFFRUzjzDBqZ5ItZhwji+O7J3NW98G
	njlnvRRTKGpctvSNvZvoSZXss8obHvr1BQzZrHc0AQElTMNLcN1pAH78aDIFHzqtS9SdtdrD6GFao
	TLQDB7rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX7-0000000FONW-4203;
	Sun, 02 Aug 2026 06:18:49 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqC05-0000000EpMd-1AcN
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:51:50 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cedda2ce6fso16518205ad.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599508; x=1786204308; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
        b=C8og+P8g+jLKvUyNfs2uYEovi2Cm8XI4aNtP0f4NiGNUvv7h9gAHLaS/qdRwH3ibZv
         eA7yucvqV9wimnep6ykyuPWuZIhzqeHmvJL62OaHFsLSMmf/pjzhFPgsssQtQoxVs/kA
         I3KPXqietjrMUMCTuLL1XkAQwccxzfxZD9dT7L2HbJ6c9tRzGYFISSXZCfvAeuf8+JnQ
         ots3Jcth0RwRwMjBOU87WlnP3MNzrBgBtcVCXOg36djeSvBGnrTWKp9C08qP7kOO1epo
         avftq2dJN0zW94ThdzOt0DcuX6Uq57hMMy1vP7JsM0meQUjK7P1riaS3+YGXrAGR7RPT
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599508; x=1786204308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
        b=FiumVt6TOqx2KjGnLK8SKKyg2pBHkle87JojfzDDcqt3/x5o6MFP+Cm72Yhkg+Rbk+
         nUKqM8KmLTbF3HQRs6s/T6uLZcsEzLfRqPLX80yrEt1wrAs9/gIRJQiDEhHfdrjI8N9a
         eRKuq2twaZG+N59NqGVxh6blxKNTOoKqNlohfn4a60OGgavIc4To0Y5BLSWPUHBhTLlv
         pI8rV6xTvDnumj9B19SVkeKGPHl4dxdstJFOw7G337RC1tIPUs6+jt3KYWw6kYec9vOc
         fhQY6bBqavHrUFY2uRZ+04ypyKoWIh8Otb3c4LBRISmf69IAaymhJuTAIVNgb7q7Fw42
         PGMg==
X-Forwarded-Encrypted: i=1; AHgh+RoeChrl7D9mY0gsy5my92n1AXnYMzA9ZJeI0Zt5yMEYG4L45NVngJCaLhuX/yISQboPbI2j/On/cv1Y@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+hE7+MWDLzqVZovISllRe3T47i/sPzrcBrDN3kZJvXjQn0yZt
	mDe/AvxQf+vBmWs+TYmf/iWTScp4mYhxJmwyJ/x9O+L1VDsZX/y6HNS7
X-Gm-Gg: AR+sD11bbkNfQ0Mq/6T6y9ty+KHhzTFEn/fq4KtKzkiWSUDcdWKlmED3PC5/ZiMgTi7
	k6ZZVqwvZFkHVDYo+Z2j/qsbuRcVrUARXd4qpA9EddmB6rBBe8tT6jdhQwyIKpaxnQQjCSgJCHy
	Q4L3db7Kl9cAVTnoP/Q6CP8b6uIj7NS7qz+RvEwlyNE44oQs3mkXEOYpL7qXGxuHRWJe8XZKRGN
	+OM41MEc72AsKiokShDxhAscnT8TwR0pT2MRDfVofumN1AJ/OUaz2JH1JiOZuDvDCito3rZp0iZ
	svZ/6Zx58oL6IY6F/5XKzom9qoGDNGMMAd3u/zNB5lpUJwzyZnDRqoBn7cLRXL3PoTYWcDv9J1f
	B7OOLBJmiH8O0Qc/iM/WmjG8kmhNHEknj0ebz4PtA8+Ttm5CTaO7U7YBEJ9SsMP8bLU3ARI6yHq
	MEClI9OLRUndJHCw8b9SVjnLzik5regYGoDuEPUUfENd2GUfRGrp50XsMbIA0tm8ETWg0HAK4LS
	U9Yn03ukhIzjV8GefzuCoAw42FxY4It0J36HKEOSbiFfldgYhM3yesFN0Q=
X-Received: by 2002:a17:902:e945:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d0521e87a4mr39523185ad.8.1785599508438;
        Sat, 01 Aug 2026 08:51:48 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:51:47 -0700 (PDT)
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
Subject: [PATCH v5 14/16] io_uring/rsrc: add uncloneable regbuf flag
Date: Sat,  1 Aug 2026 16:46:26 +0100
Message-ID: <65be6058af60c33328f9ccd8133d24e2bbbd0f84.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_085149_350631_BCE300C1 
X-CRM114-Status: GOOD (  15.86  )
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
index 406619158fbb..f041b0db77af 100644
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


