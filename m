Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB7CFD313
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QZk9sSNTwOxRpwZ/DRrF1dwGfvdtNtexBNm/jAu7ryY=; b=QsZfStDfTzTYe8uoF/KaUqRgR1
	jP01Qos71BTYa3EZwVW246ShamShyFFlVe6xBynSK0f3bE23iTtf+lUNh8O91+8dpum0Vug6dYS/U
	436Aeo0EHu1V7AzMDt0MYfHYSv+hZiG75JK2Arkwn2YCbzMDplR/geWKgaBv1NLCz2OlBquzN0L4H
	7KTVwsjMd5eV6KAMDCX+dPDLP2m3HqAzyg4pdwkab9GOdSqGyx/V2pEyYMfx2mGmdP+lrp9p3XE3N
	rNga96WMcQLf/dz1LeAjXTrePVFOAZa6oezLOlb8itCzScPLwjUpwweCPpuGybeg2mKCi4+c2rm3a
	03vBlM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvn-0000000Akfd-1mjg;
	Sun, 23 Nov 2025 22:51:43 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvk-0000000AkfI-2a5w
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:42 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so25640725e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938298; x=1764543098; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZk9sSNTwOxRpwZ/DRrF1dwGfvdtNtexBNm/jAu7ryY=;
        b=KZzq7A81RsBZVLg88OVkLOuOUs7B63+sqNP4s1rmSIR7t1wEAeY3AM1PK2N6pL4Kvk
         cnIefteHMQzWZbKn/XLK8rSrxY+JJl6REcvke8144jRUa/ewsiZ8ksn6Bw6PrXsfghNp
         38b8FWjSDYlb2au6tPSb9dKNg6VwSuKBjtjLARbZzE5yS7eHX3kYz4EruLa6N6S3QAAt
         31vt1bcDDQPlCcO+eTppe80BRJZtPyewlQGjQo5PWbUpOls7q4AP3vcECI0l33w7MYhZ
         OkngnQq/b5d8gHkMMsdJBs5/4z6GovuThnQ5YZOZXTBPiqjlufI2PIptzYjWe8JE647d
         wm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938298; x=1764543098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZk9sSNTwOxRpwZ/DRrF1dwGfvdtNtexBNm/jAu7ryY=;
        b=W1HeOiGSFiAksZCqhnDLpLifeaqdcobEzD70DbyHJjvhbT7ZX23TGCE1H1JURLIKjr
         k4aP5ToTi/BSqV3tsgEujONNB1mktQmp3LrVrUhRxVfcvpm9eAP7aO8Jx4ENhw55YIJe
         SeHauFAHtqUC88Jf7fBV/1DI88WAbAWVbvBJNWda04aE6qbbbE8tB8FbfNCiCVxaD20F
         EIhyHmVZ3j4IFBDbm9TlPKSfHiQ+29N0aQHBTkfINltXLsTaf7nE2pYIyMcG5s9ZGFm5
         P7CDL73O4y4u7f+YKd+JXXGN5JMXQe5chA5dMlnv/Yj9EqNLztJtBHlR/7ZMnnUwCYB3
         eyNA==
X-Forwarded-Encrypted: i=1; AJvYcCUsukyU6x8mo+bd6ntWNJse7jLPZrm6Fji8TeHkZereOHbCRGIEd0c5GeO20JAGtzD10GNSTItQ4YPe@lists.infradead.org
X-Gm-Message-State: AOJu0YxxL7YI7l0uVK5A8+HISvkXMoEeMHYZbEMqb8Ac6gswISTABLcS
	lDXkfTmJtX3Bdc+D7+9eFkry4mFbVYrEXIzwowxhsq0MHbXZQFUkzsdx
X-Gm-Gg: ASbGncsRoCZg4fHx1YAa9KU7MPaoVNAeqlOTemreQDjUpoRFxxj41DKYzRwGZX4CwEw
	bysxlzuWI8cMQzHZI3EFSn1pOCZKofvfrH6UOhIaw8Cf55iVsZw3ONr30d7HhA4CeprKWAvwNuS
	aVu4+vNZ+WE5fQRC7DGUsbTM2gK/hoqqHv40napqhvMADTvGnbKqMxMHEQckpLZhKDpIBw8U2gG
	tMsf2KwBIC8ifQ/Cs9RO5LntkND8eHeO5v/uh1rI//b0vWw2hrS4z9GxSRtmLhVoWsDx91qrt1b
	HdF0HW30aJ4IZpEfZ3Mmbm61Y4MSgYj5C0aSNSvx1hx1o+npaNxqlgNWKZiC9ok77vqhLPxeoWZ
	N7wXGytF3StSzXxoPaWwBX9V4uAP9wpWSt3znVR5/qWXOo2OkBhgpBOaF8aJmpwcj2NpmcIYiOm
	i7G6+9YTMgy/d4wQ==
X-Google-Smtp-Source: AGHT+IEIzt6XAqBENWHKeltpmV3b1E5pfBhghZPeIUxjN0aB1YgGqF8Sp/+lNyxIs5uZ/0aP6PM4yA==
X-Received: by 2002:a05:600c:5491:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-477c016e60cmr94038575e9.2.1763938298240;
        Sun, 23 Nov 2025 14:51:38 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:36 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 00/11] Add dmabuf read/write via io_uring
Date: Sun, 23 Nov 2025 22:51:20 +0000
Message-ID: <cover.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145140_699899_26662C21 
X-CRM114-Status: GOOD (  18.34  )
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

Picking up the work on supporting dmabuf in the read/write path. There
are two main changes. First, it doesn't pass a dma addresss directly by
rather wraps it into an opaque structure, which is extended and
understood by the target driver.

The second big change is support for dynamic attachments, which added a
good part of complexity (see Patch 5). I kept the main machinery in nvme
at first, but move_notify can ask to kill the dma mapping asynchronously,
and any new IO would need to wait during submission, thus it was moved
to blk-mq. That also introduced an extra callback layer b/w driver and
blk-mq.

There are some rough corners, and I'm not perfectly happy about the
complexity and layering. For v3 I'll try to move the waiting up in the
stack to io_uring wrapped into library helpers.

For now, I'm interested what is the best way to test move_notify? And
how dma_resv_reserve_fences() errors should be handled in move_notify?

The uapi didn't change, after registration it looks like a normal
io_uring registered buffer and can be used as such. Only non-vectored
fixed reads/writes are allowed. Pseudo code:

// registration
reg_buf_idx = 0;
io_uring_update_buffer(ring, reg_buf_idx, { dma_buf_fd, file_fd });

// request creation
io_uring_prep_read_fixed(sqe, file_fd, buffer_offset,
                         buffer_size, file_offset, reg_buf_idx);

And as previously, a good bunch of code was taken from Keith's series [1].

liburing based example:

git: https://github.com/isilence/liburing.git dmabuf-rw
link: https://github.com/isilence/liburing/tree/dmabuf-rw

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

Pavel Begunkov (11):
  file: add callback for pre-mapping dmabuf
  iov_iter: introduce iter type for pre-registered dma
  block: move around bio flagging helpers
  block: introduce dma token backed bio type
  block: add infra to handle dmabuf tokens
  nvme-pci: add support for dmabuf reggistration
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: add imu flags
  io_uring/rsrc: extended reg buffer registration
  io_uring/rsrc: add dmabuf-backed buffer registeration
  io_uring/rsrc: implement dmabuf regbuf import

 block/Makefile                   |   1 +
 block/bdev.c                     |  14 ++
 block/bio.c                      |  21 +++
 block/blk-merge.c                |  23 +++
 block/blk-mq-dma-token.c         | 236 +++++++++++++++++++++++++++++++
 block/blk-mq.c                   |  20 +++
 block/blk.h                      |   3 +-
 block/fops.c                     |   3 +
 drivers/nvme/host/pci.c          | 217 ++++++++++++++++++++++++++++
 include/linux/bio.h              |  49 ++++---
 include/linux/blk-mq-dma-token.h |  60 ++++++++
 include/linux/blk-mq.h           |  21 +++
 include/linux/blk_types.h        |   8 +-
 include/linux/blkdev.h           |   3 +
 include/linux/dma_token.h        |  35 +++++
 include/linux/fs.h               |   4 +
 include/linux/uio.h              |  10 ++
 include/uapi/linux/io_uring.h    |  13 +-
 io_uring/rsrc.c                  | 201 +++++++++++++++++++++++---
 io_uring/rsrc.h                  |  23 ++-
 io_uring/rw.c                    |   7 +-
 lib/iov_iter.c                   |  30 +++-
 22 files changed, 948 insertions(+), 54 deletions(-)
 create mode 100644 block/blk-mq-dma-token.c
 create mode 100644 include/linux/blk-mq-dma-token.h
 create mode 100644 include/linux/dma_token.h

-- 
2.52.0


