Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3865C982FF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=; b=ilTqFuFvjoUbTi/J5rwwxqclQ1
	hWaweW87YLn0QWBILrFcfLe8aq3lxlGcdg+RnecaBK6up2aUbvv0K5UCuuE5nswR6SAgdo+acIE+m
	qugqYoXvzkM+kj9A5EfgGhJBGAP/V+VyFwaZzxq+rMt6SReQ1xBJEPSo+br7Ezsk15GqwvfRV1gtD
	aQNdupCDPiAQ1SciVPFygiEu4tD6gsUKnpKA+fZa2GNIRSAtkg1g+lIjVNKGPSPwA0SL13U4KtSA1
	fEMRhepK6cJ5oY9pNRW4GUC9Yp+7Rw0x/z6iWt+a9kOzqBlTUS6fT80PJg8qYHy+IIJVH4PX5LYCI
	Z/8IoICw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWH-00000002Vkd-0PU6;
	Mon, 21 Sep 2026 15:01:25 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eFT-00000002GcB-3PQw
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:40:02 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so20695405e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997998; x=1790602798; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
        b=oCkSJ86nOdh6+v583F+2iz85MSi7t2w3owmWGO+DDNCMyI/2nhItmyyPmHl+Melyc9
         lghx2ztwdAHXM6MA/Wo0CZb4Zig9VwFulJbpWbgU4oPr5Mj1d8tQgxWc65BL+kIsMaHU
         z3/WHE6i/8QiKa0J7ca8LzdYf/N8E7ar0uFeuE9GwMgnXVel/sGJMDdf1qFaCPUUkITQ
         T8taC3KUUpx/ogUhz0KNVY4t1HdBODoq7R2Nrz2G7KNX2N5l33/AfJMGydjLf6ufkwjZ
         UDKDA2AIiBzkGgF884Ob5/1A1hcHYVF/rdxpmZgEgpDWEIU7RiWAYG/7wyuc9rNU/e4E
         PJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997998; x=1790602798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
        b=DBnoofLVgCS+ugkLfkaYNYvgcRCknVZyHd3Ggkf1enNiOb6ovyR2Q2ix5xpdrcxW6g
         NnYXAcBuEkFYfa0rgbVXkn9fg9sDVi1+QETdczNwGdLpcevwBXZchatSpuUVrqltCy/+
         0/o/lLqvDLoSPCfMlUpJw449dVriQryVTbsAq9/dMsa3De2hi73xNe06VSZVoRbXTg4H
         6JqlXMLc2ffqf62O/grw8yrue1eEN//0QmxAwMe0wu3vOPzGt5hrNF+ml79jHjJPuv+O
         +mU8ALBM8fBkR0lc9Eco9UjW07poO73D/+KL243m8hUURiif353n2Ss/Guymj2ebosb5
         VE4A==
X-Forwarded-Encrypted: i=1; AKwUvBy1T1GD+2bwNqwmCzCSIPXeIIHiLBetYhYil92xl705SbCZcCxau6pHOLz9PVdBU62FlC2mU5rYvD/X@lists.infradead.org
X-Gm-Message-State: AFuF++k/ZBzK6srp4rtAzU0IkhXWqFDTOuLclarQkh0Q6Ps/iBOgr9l9
	ttLooXyxGTQLGE6k6N+xRoT7mo9FNT88bBCI6mJwC+sTMDjBoct+v9ns
X-Gm-Gg: AYBFou2B158wdCh0qoVHX3arESNnDWjujJEaOmypDGIGh3SnD8KL0s7ot9ufQ1Ho8gm
	NT6uGe4Dq9dgOPa5K1a/uTD4AU7ckp+ZYI5an06/NJmDiyt5jRSNbM3PQvnDIl0Cu0CT8qkciCC
	YNHALkuvE701N42aESuDa2DY3xkeWVhBwP0eMYwJ9zH714m+MlEgpe9h9nWysB0hgqHuefZX73F
	JJRHIXv9/a+5MgtvW6Nyr9xStmS5CKCefo50dB8UbMpFhibRtqXU85Xm4wycvqrHwBhfCg5rJta
	uSuxVqCnH6N2hkd4tyxVsKZp58PPbQluJ4Eh70cVtpJd1lsfKUkZ8LyCOM4A8H1Q6ytc7oDpYWv
	j/pYV6912xKQSv8/KulnB4ph7OH9g12lBk4JbRwwTWQYdnwZ2Ug+PsEhDUedJuX9aAkOVEUc1LQ
	yjBYzICSQ0KRH2cXUzeisY95Prmt4iHlu+zQMQ54KiLdZMYXq508Z3qlna6NqDJ3+d2EuwK4rz/
	H/TcpyX+tGeyMXjdaJvIG25TuKf7Wk1orgOP8QXJlJ1f7tJgIQbMMwTdxVPYtx7wH7rW9JF2lfH
	jXwYOv/eSdj9dAdwNe1DenLVEiQSO6LQUQNjAsGi
X-Received: by 2002:a05:600c:34c8:b0:49e:732e:6b79 with SMTP id 5b1f17b1804b1-49fc574eff6mr149861745e9.32.1789997998153;
        Mon, 21 Sep 2026 06:39:58 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:57 -0700 (PDT)
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
Subject: [PATCH v6 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 21 Sep 2026 14:38:55 +0100
Message-ID: <9b71636a03f2345bcc09127d77eb6b294a1d0938.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063959_867240_32796319 
X-CRM114-Status: GOOD (  16.49  )
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
index 83a7ad9f5bc7..0b526b094dc9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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


