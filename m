Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D3CC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=; b=g1WEVu1poqY+kJtVghi/V4JsHW
	tOiMpi+NPjTMyTHbH16kRIPts1ZwrHVsBTZpAwufEWUULj+nXoK6p6hTRokkBeJbYNtLD7dXKWjMS
	XltOcApTcWsUd8TKqU5SQGDap1ak9+Pb5WGmvfT5cZQ+14i1F8C8QaakG3Fm4lCDDkJaJGgdto84I
	qiJ8tok8AsKIi+QHBKSJTmaLjW0+U47AxbgFVZsGK4BcFddjQpJm3b0tRfTjJWar7eHMK3Rj1rT2+
	ioITVrjYUzyZouV4NpvXwchvWooLu946LHWyJM20k4yiELF/Iamt4tZi8X8/SsT6o8rhidEVSo2G8
	vRaBTCbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMy6-00000000Tkp-0fgZ;
	Thu, 15 Oct 2026 15:02:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwkZ-0000000FH17-2ZXF
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=; b=oD7OVo5c+b0aTk9JtRooFJt44F
	MwRYU/ufLPWbTxfnKXpErq1JAs/FpxdAEREPRYBvibLnOxg1LB+xj3hSuzz1txvYcwDG3DzaOYhWu
	aDOqkK+46x0TuFTRZ23B3A/76+Bl1FKecjOG4TErDlQwd3DrxtKBUJ/R9sw7OGax9FrOuhXh2mAXH
	KVejMAX3rEE3OhSoql/7Hrc24betkwcIp0RFsf78bm0Vh1zGQbbsu/K4QLlgeuvpRNHgEZZOIX3KU
	DlJloihH/0x1OPsnjt1eK8xW/lz+2MKnvVWaRdOQVpzipPJxMOHwxTkTuLeMyyrpq5js63wyrkIxv
	a2devFqA==;
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwkW-0000000Gezy-1JAZ
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:22 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso37090385e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975738; x=1792580538; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=;
        b=Miy3clT5Wcg/nmvx/kuxOLMeAp+Y1mkGu/mNh/eIxUJUlj/PqTAoFhXF1O8F9kigNL
         Ioj9rYD43OUv0BkxjaRoCidC0/c9I4LI25pMOaSqJTjeSq5ygGOVXukTJ1NT+vafuhVY
         oZYPMr/CVJRZ7ds+YeHdPclIn2lfiOlAfxH1I20RSL4bOlxJDXeMGCKxqqzyDTFVC7cF
         0juggz4UvqTMCXvgmeCYKgIsJVklHXyxRpkDdRrYGH1BN0HyqsbnD2ZoXv4X0pa8hxWN
         BjI1zhHx87fe77sqMfT8UnqHvdqEuIr+hfwfJT/Gb8iHTf5FydUD4+2nMpT31d2A6oJk
         YRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975738; x=1792580538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=;
        b=QT9kXc7Co8qeQ5IXW7cOPnBSXyZiM9kVZzMAy/MG1a6vgjx9DdfeSQNb1PXK4PmdO0
         rE6r9DJ9Imlui1v/EemDwQDxOxZaA7pBwP2LqzaDqnRTOIMBKa3AI56EQeIpwrKrEzTI
         1Vhx6gZRAS+t8ib4YPvzAr0c5j0UkX8WeFKZ4kJ7D5WgeetHat1xry0/H+65wn/0sVRA
         fxnfgDa3orpiaqyCs37x7OWkYMED7TnlO0uUI3h3gMRC0b8cZAv6kvy7wwn6Cha65hwP
         FTz5Xf0IhnzfPmQRP7Vvrv6JVsk/x/mLZDmQ76YtMIg2THXTcZO+5za04919baSSbqZl
         ga+g==
X-Forwarded-Encrypted: i=1; AKwUvBzo44fqRDEOgG3THB0Wgh50p6dx+Vfm8DKsZQnSo/eG84TfBV5sydyGcRxkZnah2bAARNv50uvJaPIJ@lists.infradead.org
X-Gm-Message-State: AFq9FYKR5jcJGXOOQSkhvkmMDpH5Yn9i2P//SPd7zcWFtUCID/8obDTa
	9dxk1f6dPWtH/wYIWdHumzOFb06ZlD+vlarIOa6dL6bjTMVrmNXXqxjG
X-Gm-Gg: AYBFou32R/0DxEqd0oPlV8UBOzpL6eKnHE80qvnGIGMArB8dl2b+GK+6B+YpORn2HWG
	L5doBlRsXSmoqMXYNVkBhgmnIxoU0THK4ige2l2S0Z79veKWJyXVkWPfzxrvKYv2DIqpk+3acI/
	+Kc6SgdD7NnC5/flQI2hxDI1nVS4TWg6wOB8Y0uGQtorf52ZSEH2OLNuaIasL2koMbh9c56YOZD
	y1xkYIMoqE087IqzRkP6O8PJMILsyYYT2vOHGJ0BMvQb93ytC3SjirTGJ7JqL0THUD5rrqDxBxI
	JKC56hSMytsEKTnzrgSuNjmSCn08uH4dFU1BSf4wC4HtT08F0RAfZfjWlR5CAw4fkYmNNDtvdjq
	qBLOu8McUo66H26pxGVrMcC2EZn9LrnVZqGxZR+poYYz8iLh9PSZxTMqCeJXBxY58XHBUCJp26n
	MmM8ndKFUOJsKp5A5w3Qw+8XgS5RDtBIuaphV0uZc7nHZCyUeLZbflX26oryGjtYkwgyEKdi+G4
	EnCZMnlfvoXcILNluT1uDiZyHWwiJWpy2eM/fzNOBKmtK6sOld0bgiE93x0XfhG+XX6y/pzx1J9
X-Received: by 2002:a05:600c:4688:b0:4a1:8d46:6228 with SMTP id 5b1f17b1804b1-4a18e4a9ba5mr321894465e9.14.1791975738524;
        Wed, 14 Oct 2026 04:02:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:17 -0700 (PDT)
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
Subject: [PATCH v11 00/13] Add dmabuf read/write via io_uring
Date: Wed, 14 Oct 2026 12:01:58 +0100
Message-ID: <cover.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120220_524238_46780CF1 
X-CRM114-Status: GOOD (  28.48  )
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

The patch set allows to register a dmabuf to an io_uring instance for
a specified file and use it with io_uring read / write requests. The
infrastructure is not tied to io_uring and there could be more users
in the future. A similar idea was attempted some years ago by Keith [1],
from where I borrowed a number of changes. Later it was brough back up
to life by Tushar and Vishal.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to glue it together, count requests, manage
lifetime and implement invalidation.

Tushar, William, Phil did a lot of testing and experimentation on various
devices with previous versions of the patch set, and I've received lots
of help from Anuj, Kanchan and Nitesh with investigations, testing, and
patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
showed:

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-5: block layer support + prep patches
- Patches 6-8 implement NVMe support
- Patches 9-13 add io_uring support and uapi.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v8
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v8

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v11
url: https://github.com/isilence/linux/tree/rw-dmabuf-v11

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v11: - Disallow creating I/O ctxs for a nvme dead device
     - Add dma-buf-io.* kerneldocs and Ack from Christian

v10: - Mark io_uring registered bufs uncloneable
     - Check io_uring size/offset on type truncation
     - Include dma-buf + PI fix from Anuj
     - Fix io_uring build failures w/o CONFIG_DMA_SHARED_BUFFER
     - Don't poke at bio_vec with dma-buf in blk_recalc_rq_segments()

v9: - resend

v8: - fix blkdev_buffered_write() returning 0
    - fix kvmalloc-kfree mismatch
    - fix invalidation hang
    - remove cpu dma sync as unnecessary for dev-to-dev transfers
    - move nvme dma-buf code into a new file
    - tighten dma-buf [re]export around io_uring issue
    - simplify dma-buf-io locking/sync as proposed by Matthew Brost

v7: - refcount *_io_ctx 
    - wait rcu grace period for ctx->map before freeing maps
    - increment map counters under dma resv lock
    - more comments about bio splitting
    - make ->unmap responsible for freeing maps to match ->map
    - replace dma_sync_single* with full table sync
    - detach dma-buf on nvme reset after cancel nvme_cancel_tagset

v6: - remove fences and wait on invalidation synchronously
    - report all map requests are detached earlier, outside of wq
    - handle nvme removal
    - gate nvme_free_descriptors() on iod->nr_descriptors 
    - fix error handling in nvme_rq_setup_dmabuf_map() 
    - fix iov_iter_alignment()
    - relax the 1G io_uring registered dma-buf limit
    - fix type overflow issue in bio split
    - allocate struct dma_buf_io_ctx inside the dma-buf-io code
    - harden block checks against dma-buf + buffered io

v5: - Reject dma-buf with buffered IO for raw bdev
    - Add lim->max_segments bio splitting
    - Add bio_iov_iter_set() helper
    - Fix io_uring uapi validation
    - Other minor changes
    NVMe:
    - Rename nvme_pci_sgl_set_data() to nvme_pci_dma_iter_set_sgl(), split 
      into its own prep patch.
    - Convert segment walk loops to do-while.
    - Drop adjacent segment coalescing logic.
    - Drop first_dma/first_len from nvme_pci_dmabuf_sgl_nents()
    - Remove entries > NVME_MAX_SEGS bailout; moving to the block layer.
    - Factor SGL vs PRP decision making into a helper.

v4: - https://lore.kernel.org/all/cover.1785274111.git.asml.silence@gmail.com/
    - Add sgl support from Anuj
    - Move it under drivers/dma-buf/ and rename
    - Fix mis-sized allocations
    - Fix io_uring re-import mishandling
    - Drop map before io_uring "task work"
    - Move blk-mq callback to block_device_operations
    - Convert bio flag to REQ_OP*
    - Other small changes

v3: https://lore.kernel.org/io-uring/cover.1777475843.git.asml.silence@gmail.com/
    - Rework io_uring registration
    - Move token/map infrastructure code out of blk-mq
    - Simplify callbacks: remove a separate blk-mq table, which was
      mostly just forwarding calls (to nvme).
    - Don't skip dma sync depending on request direction
    - Fix a couple of hangs
    - Rename s/dma/dmabuf/
    - Other small changes

v2: - Don't pass raw dma addresses, wrap it into a driver specific object
    - Split into two objects: token and map
    - Implement move_notify

Anuj Gupta (2):
  nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
  nvme-pci: add SGL support for the dmabuf path

Pavel Begunkov (11):
  dma-buf: introduce initial file I/O infrastructure
  iov_iter: add iterator type for dmabuf maps
  block: always adjust bi_offset on bio_advance_iter
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  52 +++++++
 block/blk-mq.c                 |   6 +
 block/fops.c                   |  26 +++-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 229 ++++++++++++++++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 169 ++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  75 ++++++++++
 drivers/nvme/host/pci.c        | 249 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +--
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 125 +++++++++++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 ++
 include/uapi/linux/io_uring.h  |  31 +++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  66 +++++++++
 io_uring/dma-buf.h             |  76 ++++++++++
 io_uring/rsrc.c                | 174 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 lib/iov_iter.c                 |  29 +++-
 31 files changed, 1393 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0


