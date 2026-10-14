Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D59CC6B3D
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=; b=JOveTcS6jIrPnJa8oTMSdIAWxa
	t7zT5knnga2mGd4sb303FNzDLAMlt8zgXvwKkV5lrLMMRGMYys5VriRLAhwZT4X8d9uhfbm8wfSDM
	dHBIl+g4kY5ufvJEPHR4KcaL9+lpSSlpHFV6XlneglXtUpTAiAv+92u8ddY1RZ3NBwHPGeeuBzY23
	U5ESm8aTCwzD3LLURocg++n9HLNCindhYKuxoP+jybFLNMCtAHdoKhS6jxZke6wyHTpnv/b1RL7vp
	ZiWyPEQeNUesc3c9MS++7FZHB7WxI0KVVTPqrcdIqiFtVYizy7yu57ioPv8kmZs0oPXEHgQKM7XXq
	JPt/6VcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyl-00000000ULt-1coS;
	Thu, 15 Oct 2026 15:02:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwkw-0000000FHF2-0WuG
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=; b=V+M7tFaHzQOZTTwhQ/ZGzvvqap
	C6JvX1hrbg7jcYNlN7/V5RqbSZhIGnK1t5SE4ecf+SvW8PfFc09McyuLnVMY66o0sAfvMkTDS2qWm
	fuZ9dNNSfw2F5/AqqdEU4yMq1e0ysXvgUr4pxNdnVQDoiRvCllJhefy/srAfLfQt+auuQkbWVdPXE
	VF+KyPnIXqypnow17O49uIpPg63EHtcDagl8U2657oruL5IsHwVHFd1yxLqzfLUq7/joqkz1UYoz7
	5316P2XEQmDXIPZg0TEGj7wnHa5m7i/3Y+itXXYebQSxyqLFd5vZgD7USDydnDu9Jfy86JdvzyhA3
	ZoAutuTw==;
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwkq-0000000Gf4M-1Dvw
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:44 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-49d05d51553so5096285e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975759; x=1792580559; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=UlpPLtJPCt617pvM+8es7LtUo5/zOy3EtmV79Ml1sibfBG+e2GUWHMs1cA7vELxHPT
         xiRv9bbUJDGYzwEOWstGdkjYIRxSz6V2bJCTlNYVkBQFCbbNgP34BXHP/F/FnVbXTMeP
         5selfN2/OfKc2Fg1NLby1F38XGu1wdhFDhCbCbnZt3iHaFyiTBx6ZnfsYcGXfYCEoxD4
         Vx1EDCSFU9O8maaF5s35LOznMnC5tO+wBwTV6d/E94532rNiFGtdB+Sufiqmln3RyFgs
         5qpGIcqHPXimpKW9Cqbn9VFnlsPiyQDXaGs18lYMiQqPlbIraFEw0Bh4viMb2kvut8hG
         KXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975759; x=1792580559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=v3bFdbntqHPL7w6ORPEqJK4+9U5ZwEJRBhlScyNwr0Zze/xhenE0Yb7kcQ0Zx3SenB
         Lk0JCWtwep6Sl4jV7RyqPnhY3kOm2L76JX7pERtQNDk3LIR902+rVpl7zdXuDnEulI7z
         d362VhmrniUPgB7aHsDAxSpGLMT9Lx6kfc+16XkSOp9Rg1kjjCmXwdorOAEmjO82MWAI
         +HHKGNqWCe/hCMYKnecHvpDs5sJZazF27d51eyj0XZgG8pF6HN0s2ZVy6PyJbj3TubRU
         5RfN07A678sq1VbQ+cwg7zHhSxIDULtr5sCRRwOcJ8IvbxVxC5+fKEjzo+f8758y3Pwp
         B9Xg==
X-Forwarded-Encrypted: i=1; AKwUvByDEYTr6M8tAO/vYj4jRpqIlzJVnCZ8wBAmgF/5P0+J+gu5haoZrKlGGVUCU42vQArXYZ8w4NF/I9PJ@lists.infradead.org
X-Gm-Message-State: AFq9FYJ9irO/eMaGfnMDRRRX/MP0MoGGGPL7r6xcxxC5l9YkzOHTSDY2
	ZDM6JNdVwvF1OfX0RdcwF8Df0XOIb0qI7rIIwzsHVD2Q+9zIOeyD6zz1
X-Gm-Gg: AYBFou0mbQz6NKLTwTuLwaeWF1Lb18TOtRbWcfQIYpYW35/9Udw3t7w6G5pbrCMStl4
	X2OI+AZd6OwK9vbuZp67IHen30wZ3nH3HViIAY2RGwRcvJT5X2z2j4+77I5Hkay0CyUh2SoSDYM
	gjcyoDYRJSgSYsOJFD6mY2JsBiEYUi3NkF4SYb69cIMIcyE+m+y2z3YM65ZbXYg6m9DNr532/rK
	e6GC6CBHBq/0EzVQ6X7SRz6vn8xmTGIdRifYudnK+xggZHhwuM3v8XbuFGI02OPX6yF11u+oGH/
	L8faMWdk2p7QNdI+ODZEpOhms1XJPywKUId3/fJ2xAuTzqsah4wQp7VB+AN7ykb9yPPHEjSkIYh
	O6g+ZVnHeGkZIFoDo6DdoxL6ICOKPdoc24yur6yvL9793wIRLwdxi4EpOvfBseooDNtITcEG85z
	rdZznDfQnqqiIxMnc030LrvLQQ8D6MkWRyl6wjPQH+sn6UXwFG0hK5HzM3s4HDd7iO60VDg1/I6
	u7sAkGYUHmP8wDwfZls4q9wvk1AqBrjdMcGkJSJOqjGw1fnSVBCjGsZsDIyHsNQeymquaNg/73U
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id 5b1f17b1804b1-4a18e47aa9amr321452385e9.6.1791975758979;
        Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
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
Subject: [PATCH v11 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed, 14 Oct 2026 12:02:09 +0100
Message-ID: <c73c459578981e64a352e46c0db39ad46621c63a.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120241_906704_E4957FD3 
X-CRM114-Status: GOOD (  17.38  )
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


