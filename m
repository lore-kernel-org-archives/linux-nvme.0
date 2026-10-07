Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF69CA9EC8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=; b=l0UNtxRWmZt1sfSkNen3J5czeE
	PG0KeLpaBaThKohJRNNFTl7MkSkw954BaZ6smfh9JTbJzQ2th24LEMsKrf4vl/F4ZMZbrFekU3ay6
	1yBNgO+9tPGYDEFT70kp34SUg0B11R8+7ahuCL09oBtTulox3LbbySElwYZtPTuoOJ3Uf/Znod3LK
	xczbobFL0SQWOlrnwHXk40ncI1YUd4L1hKeXUthH2wyKWM6uRikOyHmOTqqFGDZXm/YPyAldkC7ci
	Q61E+VaJlyceJVshI/zismWiefwMNTb+WQxK7phXMxp/kwbiOw5kR8Wnfqciv+/2YVQAWLWkGTrM5
	wgQR0/Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtf-00000006hac-3luF;
	Fri, 09 Oct 2026 16:56:39 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGWH-00000001b1L-0ZiW
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:34 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso33694385e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336751; x=1791941551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=mPq6PIW+AJXKpUYBE9eyKjJatUnpgjveHyVMm3hskWOJqUyMku3eW1s+ODUuKuCQXK
         Ev5nd5wy1dQ6YAI+fNZhVNd3uQ7yxv6v+vorg5NSLpgnzwnMnXiM1imDo4EtEnEOE9TX
         t4ImyFPpbnCnYnWACzS/Cr+2iLYUXq2m2PeMzQt8MUZRnHX4g7xShEv8tNflNFSfTMAC
         QL4xGCsP4QN92iwzcUq9DiheI+z014ccNJ1iDSgGYXUS5/cA8+G4qGNuw7qeURp4bjXH
         IzTkc23gM1B8IZWNi8DuRm7N9RXfGiQHza7Y/7LWZXuoPLE0ScCCsm6/0wHg4gmgBFah
         +vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336751; x=1791941551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=Noupl7nBEzvTWGSopBa7p+C0Ygyb1P/GxaNJMYN8k1ickWPeccEpFTgAUCIyr94zhj
         zw8qQgmtjR1bViM94evX01dm0p2QA6qpocVL2JkdocGCo/+RO/DIvzERJoRVvjME1hYI
         ark2mSm+zzC432FoFURIzMwBTbxz+ZCTX1nrTLBgPBZNprN/Z7L361L45//KD3lFGRFu
         mt+6u91I3Yc/yzoK7oStwkO01seEbNOx07NX/PY5ebNDVcAdY7bM72ovOhXZzQu2+g96
         89VZ4JCaOab3v85+ZUn/m8yFoUPupxNoG24SSFk8JryYeFLfEWEn/SGOZqk0BmrS0V7i
         SVLw==
X-Forwarded-Encrypted: i=1; AKwUvBxo5xxnDQYWgGi+qg4U8wvKV4AIg20UdtcX9BdzWtujwv+ysb71PjQDWro4LLPofJXZUYisa5LXS6qe@lists.infradead.org
X-Gm-Message-State: AFuF++m7fAaMVkOq2oshlC2PxlUWjrwEG5Qc4GseeYYHx4erNipqgQdY
	6lfSYWJwQlr68fC+cY/v/YymuHQ4fboKDx6t+R3Co57Od1VEbg/dqfeS
X-Gm-Gg: AYBFou08SUSY3gZ3HIWUNNq8eOCRStHPGG900DzNWV3ZEZrchrNR3OXU3K9srQdpttu
	deR9iIF3aSH7ac4wPeK0i72pp/q5CQkplflRmX+pnxPY0L/yhN2zo0PsxVL2sTy+Djrp9I8v7+s
	7UaetdR3Ee610c6sx5OFHclA+nQH1woOthtzxEhbJ+0zTsD6jKWNt2UmSZZr7yn3IOgoM/b6JxD
	GbJ9b7sL2lRQShslfsaO7ofv7ZoVGEkyfrLfZ71NRQHJ2KoG4EEyaxwqF5lV+2/QJOfZbMoehbu
	h4q2YJ/leXzB6nIcWsJ2t6UuUEXswPqm1DxG+xk/Lwx1Edi6gUaTDlUiBLwtS3vwJcJSDKhE9rX
	NFRaCRVCOznMuyRRxUOWF9O4OL8ZUx/vyPn62hY3h3tcwhy4rT8Elm1UODIHROtF8vDnu9aoKOV
	BpFDXuFHfLvJ/4VFOLZes2KkL/6d9dF5D8Hs1gIunJt86E/RhryZlqG/+oEUk/B0eJBKqSzVMJ0
	qqRbgI7Y5BtsVPQMz2YrUNRbohFZnz0aknRcfw2i+PtrV3YSAlyotoTeYU+dGQDV55x6q8v7jqR
X-Received: by 2002:a05:600c:3155:b0:4a1:7ecc:b23c with SMTP id 5b1f17b1804b1-4a18041ad89mr5983065e9.6.1791336751486;
        Tue, 06 Oct 2026 18:32:31 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:30 -0700 (PDT)
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
Subject: [PATCH v8 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:31:54 +0100
Message-ID: <5ccde8461121af903a18cd6085ccac98656aba4b.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183233_836169_E6F1D437 
X-CRM114-Status: GOOD (  16.77  )
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
index 77e6929f665d..6930a6897b41 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1456,6 +1456,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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


