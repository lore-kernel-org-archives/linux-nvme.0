Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49111CC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=; b=j1M678gXpw0KRfTVjbtTRsS9XJ
	UiTpw4WArNlOHehkosjQQB2Exkb5GZ9TTKnEpzd43o/k4tHVnUz6tHMbT8uDrGvAQ3cQPh/7jw258
	7ZGLq03TgK6rprUOlFbbnckyGif0oj0GiEs4KC+tmlQvPbWawr8jmzkPjP5NmK/JnX32rWwsUirLt
	TkblBchbA68bDi7KBao7giOnppLNRTfOu1F51E0UhGt4QYhWsYLG2mftLpJ6Wxg/KSvGSEWAO/HQW
	Ki423l1rR8ZK9MDO+vyyx6qIyBal39OKGQ0sHGxlv+HuWVb5+Zh6kMXUs46FFdW7apSEqaNXxIxiX
	6PqmdTrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxs-00000000TY3-0jVA;
	Thu, 15 Oct 2026 15:01:52 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjXD-0000000E3M8-2TVy
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:44 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3185260f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924941; x=1792529741; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=mSJ7pwlCI4eXiX02hyGNiTsPfnVEZiH638pk0HF78v3tR47HpeOOjkR7Tk57vuXv6A
         l4abGeSTSISmKpqFaSCnQq4nYBZSGUI0Aq6QBsXwlEyCDFJF5a2sR55m2wxqbhPyOjMS
         o7wAPYdTZVrk8jctRANTtlzzC39MQGTnfc5YWyfwCV7+j5oxaSPEDFJF5gMEkq3023rT
         m0+fwqOHJNEzGA9EZuf7BDKB6d7YVsnu8ZrPcbVDvbctcjIyUBOGAokQcmI4ZZ90TWyW
         zVtG6QR3ElJA+CF7PoOlquGfSC8rhmGuOVBsInuCen7o29meKORuH6AwP90dLvw0G/xQ
         wN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924941; x=1792529741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=nRy6AudMVSS0QGtAxrJuptbxVK0IyRjnt1TyOSn8pGC66APVz/Rvch+XV1xRER5rNv
         zbx93c4kQNIhQL7xZe0uKi6AH5lGwlMkANJAdIl0y+Fqssnk0lVp2Ybye43hEG3toFXi
         bbDZbue4PLNcCFM7+m5MR/TzrNsiUbqb9pEz6veAbxb1zaZR70uiFWjjGO5giHfLGxFf
         liEZoJeVKst7Qd1gfhVkoakgqZe25PNb5krukAOPYdia/le0Hc6VSvukhutZU/yA5c6d
         PRWiZMSa5USLMbulBxZsjPz55de4f6INLOiGAKPTmKY+T0vzW5f8BD0dGx3XfG0ardEc
         ZJAw==
X-Forwarded-Encrypted: i=1; AKwUvBzEEteo3096dppFX9KTVUZfnZVAg4KCkMgnyzZGBzHtwvyAtZ1E/RGb1shqOhhMm0lSY2HfkOfJtqWZ@lists.infradead.org
X-Gm-Message-State: AFq9FYKLXO7SvS/rR+ZSpiY7RpVyGCW7RPpRP0PUdIpTLS/p1QYMhBN0
	wqHLKPjdp343LpZp5f9Eepef+BlICPzhpGOZIzhoChkG9Gg+Yw3qHYzU
X-Gm-Gg: AYBFou1IRAAwPzShQJD/m8eVsWuz46J7k6c0EdwVxplyM/deGnhQYMkGEnxSj/LO8sG
	XxewIlvMxh0vPHrMdaARbZY7NvPB4Wy+x64NQCDFtgNebHDb5050V7yf2aNjcDpXDvyKs+OdQ2i
	Zsv2mTjFdCQI5kOVwnlPiaIHEWWlXuvvbShe2eAFEzkXdCQ8taPhhMURnaN3q2krqndh/xLDePP
	nIBFquHTtGExkF2F8Kjb1oRN/zZMo7QHGQTDF5o0QiLBnsrJaeH9gnjecNIAZwtone7I4DiaGPv
	PxwnJeEodDBTsTi9GS4J7plENQXcIhihYt9JYYY5DHoXD1aElcqsfkkIE3wc/P8DEu1lZ4kFJWq
	i6zj+71dR8maY8KVNO2uelLyTnhLWJpq1jjtKw3oEbfVtJXi0L/7pzGcn+rs8s1XDXys/QqquXT
	syDAsrRQXq10+9ynhp1oxA7DIJ9fGZAkqLyu+iuG+mBu0RU+vuJAF0jyHXiJXzPMTg7At0xxuuQ
	IRUx45D7aYR7Ezp4mNdDITRxpVtczrOtr/JDtIUMarmB/uFgnby4lxatb/9SF+0o1eW/68F2UEM
	IPRtT8oya6U=
X-Received: by 2002:a05:6000:2407:b0:487:1ddc:aaff with SMTP id ffacd0b85a97d-48dbace40cfmr24537298f8f.44.1791924941527;
        Tue, 13 Oct 2026 13:55:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:39 -0700 (PDT)
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
Subject: [PATCH v10 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 13 Oct 2026 21:54:55 +0100
Message-ID: <b013774568929cbc3e6fb9ed29079088a1006431.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135543_646352_C149394B 
X-CRM114-Status: GOOD (  16.33  )
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
index 54774729ee67..532866a1e9b9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1458,6 +1458,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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


