Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8D0CA5FBB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=; b=LBlgAUtHXLXXV//A1lwtjEtQ89
	m6HFNpJ1WBOOwb1Qvh7/hjtJ7VCfS8CEkPewf6MUa4bzVG/wB3uv97F8bOk67csqh4pvWtCilHUkp
	974M2PBvXKfO8hJSjda1nDRFnP0DdWPw/fe+V22Ysslg5kOh836eZ5cQNSLfoDIOMUwGAb/2/ZXUS
	3gYJ38pvXNXB0GOswDsiMxbBNb5lqxLsZfd75ZyPh8xMZDRfAuewFTEQ5m6D6R12SgY/De8Qp/Z2j
	ri6yMT8sjivscThLfn7wZPHvQdYCAxWyED2mcO2jtv0hjWZnET7UyUAwIy+U1aBjPamCkh+W76IEe
	e6MitR6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7d-00000002jOB-1G8e;
	Tue, 29 Sep 2026 08:23:33 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTb-00000000fKH-261P
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:33:04 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso15962875e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602381; x=1791207181; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
        b=eE5KN7cj9UXtNawtRWq6ZMxh8pJqri1uvpcWCrEST3vIiRM5PXXP3sbPaHlvKUVxsG
         3yv9AXPTr/jGx14MUPCWop5x1TIt3vD11l0XqZm51yHHCKDnqz7LfTMD8horJV2gV362
         zG8HemQzDRq6HZ1o76dJGk1892MbCwca0dbofE6cEZESku75k2M60mkKukHGLpS/+dgu
         UZCVYn2RxX7/DL6MS3iYj59TJmFpcG/zT32/c/ajmYetk9mIjD9gG8xBmdO3Nel7/YZA
         6TzhNfFAnoP+i3ZCAQEtxr9flzVILjhxGG8QNlYD+KDtOFbsxwagAzCxXLku2tCzO51A
         rkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602381; x=1791207181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
        b=hGoEzXwjv/FESeS404BAC655ejhHf7z6LXI0vP0nJ/IZzmiHFcpFqqF5O1uerv8KqT
         P67lGvwPKP2pRL55Zdd4yjQIuYgcGipzbbOSU/OD88B1vw19VLd+nkm11hM5Ewv/Q7vA
         XOm9N1YX1TF99F7/oNGab8U2s6YXaVt65GWH6oEUpFiSjIo7Hzq39u9m4wheBHMQSznz
         fPZCeompvUl2zvo5qHMSqBbtG5gJw1i6HVRLOM+AWOOdCUAHEpvJbQFhjobzdNoZzEo2
         GZ0ahXDH6z/P8eoEqAzE+PmRpJs9QtMX4NTxWw6B4zgecKRN0+hafLhZRZOmFHjWC+jQ
         zvhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtwMEAK6E1pokVbwFkNpejzG/zHnpn99PSdicpZimlIc3lPqrK/aIWRSsJxkZhWfbvNF9iJkEk/Icy@lists.infradead.org
X-Gm-Message-State: AFuF++nZud9M4zx038n0HoyB92DrnkW8+IVmhry4JlZkXbCyvEooQiyI
	i8MBrSl17RX0YbZK3JpaLChXxQgcy/5ndRjDCWp6cGb9yQgqYOAYLxn4
X-Gm-Gg: AYBFou1F/MgCdsVtMUDIRQPFuusNTBOGoV/JT2eM7QKkMha1rPpDvLvBelIXcGFTRFg
	19g+svgx+qgVIE0QxJMXqNYIx3DT0e+2B9zksjDRNi4iFVxucnClzUU/w2YUIWM8lUMbrI6+jNI
	oWnezncr8ZquunpVTMYJXDBJTQo22lP9R1jJm3SQBPOZZiLVCsj2ANzaHdDpV0qNVHtBrHLlm8A
	Q/3Uda9QWnfqAR62hsIrVj2DE8lRoteNtAEMjAxBdr9sw21fzIszbad+CEAzlKJGaQj64/bhE89
	HXQawEAzhGC56cmP/mGWxUFTxC5TAP3jzAwGLkHcljhr0JMHS9fHFhOkJLBGo/n3/6STPw+zG8f
	TKg94QNj0Ce3/nQiGYBLbgb4NYYU0Yf76CQNjXNjXowym3PFcVBbKHY+K0mXDsA5SwviSP9f+Zp
	ANtWDApkq5yxCObBTzT1RmACs+EX977rxv0M5LhuOVpLo2+y9q1EjpImYcw3K+6sPsjqZoEkxdG
	A7THn/uxZmLEOpwU86eiz+XSQ32MyZPeWWM59+FCoGK7qkUjt9zDgzhH3WQH6caZX3sHKc5wUNC
X-Received: by 2002:a05:600c:c3cb:20b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-49ffc131a3bmr73381205e9.1.1790602381298;
        Mon, 28 Sep 2026 06:33:01 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:33:00 -0700 (PDT)
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
Subject: [PATCH v7 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 28 Sep 2026 14:32:27 +0100
Message-ID: <6bb81fd0941222a30477dc849684d47333d1e4ce.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063303_553907_509473C4 
X-CRM114-Status: GOOD (  16.65  )
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
index 83a7ad9f5bc7..65d6cf7201ce 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0


