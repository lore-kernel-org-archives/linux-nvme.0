Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6CD44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=akv2+qO8RNiZ/MdlD08p6GimzeODp1R3NwsVs3l8fTM=; b=3RP497FN3fzXZDWvVggkOK8Hsy
	QKMuY2Z6NHG1b43iFjIe83G5M28B+qwAcEbI6DYxgSAL1ZI4krM17mKZL+vruOeQVIh4eiyF+gldq
	DaOUPxWTsgzNtZoEWu6W+Bpu+VoY9xbFeyvBuMdwMZanyBarw307i36+wIZvMXUs46f0YV8wu99EA
	3443HT/ftdk6sHkwoZZYUNq39kj9K5KwB0sLTENscltkzrXgobhtYGqqiOEX4x0CVyMfGN6WaRSKf
	RvCfKzqtixqL7AhWtE2dMepg06BKaEA333gVv7mNpzoY/oynCnh8T8e7N/Bhy+IsaGFfCGsAJHUrb
	8UaQXNdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDN9z-0000000CIvG-3qxs;
	Tue, 19 Nov 2024 12:16:47 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDN9y-0000000CItq-1hWL;
	Tue, 19 Nov 2024 12:16:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 03/15] io_uring: enable passing a per-io write stream
Date: Tue, 19 Nov 2024 13:16:17 +0100
Message-ID: <20241119121632.1225556-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Kanchan Joshi <joshi.k@samsung.com>

Allow userspace to pass a per-I/O write stream in the SQE:

	__u16 write_stream;

Application can query the supported values from the statx
max_write_streams field.  Unsupported values are ignored by
file operations that do not support write streams or rejected
with an error by those that support them.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[hch: s/write_hints/write_streams/g]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index aac9a4f8fa9a..7a6a1b3726d3 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -98,6 +98,10 @@ struct io_uring_sqe {
 			__u64	addr3;
 			__u64	__pad2[1];
 		};
+		struct {
+			__u64	__pad4[1];
+			__u16	write_stream;
+		};
 		__u64	optval;
 		/*
 		 * If the ring is initialized with IORING_SETUP_SQE128, then
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index da8fd460977b..a54da2dd83a1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3868,6 +3868,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
+	BUILD_BUG_SQE_ELEM(48, __u64,  __pad4);
+	BUILD_BUG_SQE_ELEM(56, __u16,  write_stream);
 	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
 
 	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=
diff --git a/io_uring/rw.c b/io_uring/rw.c
index cce8bc2ecd3f..88a5b5f65a9b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio = get_current_ioprio();
 	}
 	rw->kiocb.dio_complete = NULL;
-
+	rw->kiocb.ki_write_stream = READ_ONCE(sqe->write_stream);
 	rw->addr = READ_ONCE(sqe->addr);
 	rw->len = READ_ONCE(sqe->len);
 	rw->flags = READ_ONCE(sqe->rw_flags);
-- 
2.45.2


