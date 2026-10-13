Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F3BCC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1BimhgbvfojlD6pHPB1upr9KfNd1p9a9GXQsOgOoHN8=; b=wNjMvORb3NieRovDJ/ijTEh/ML
	jwmXjvfImiGosYcJNJS+M++YH79D2y10zC3wwC0bDefgPReOtd7pykiEDDXp17pm4i28vnRF9Ef23
	Nz/6NVpPpieNegoiv/vquUDdXjejKIzzZo1yvTzs7X77fnSNKAprdENTOUCiVGRfCtuQT0T9Yez4A
	faL1npxPvK8Q4l1LlRz/FFH6nmyN2MCvBgZEiFY6RX7dfikRgxw+zxHVDQYqfrhsEE45CUcap2QeI
	wMOpkYv3dZAv2qPUWh4cY+6wfIIy8zbwmkP9sggXv6LqrIQ++Z+Ba2uG8viCzBbahyOM3dTG8+DOE
	wNGdv85w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxV-00000000TFj-40gc;
	Thu, 15 Oct 2026 15:01:30 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjWh-0000000E3CS-1xAo
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:12 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so2734735e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924909; x=1792529709; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BimhgbvfojlD6pHPB1upr9KfNd1p9a9GXQsOgOoHN8=;
        b=jXWf1WJfXuDA8YxDzo6yH2ceZtwGs5lYiziwmYmimgcomF26O7m6UZbLWyMpVAgTq4
         ieF/r+y8tWpL7jPBOu8gCCmWErhsz3UqBn7+/2KRuVjJASx4IH2tQknUQFIQ8MZJmdF+
         IeD5lAbnf5TMfxKl9k07HqpRLCT887XJKUkFvqxqogxZKevO0x6yKEE8dGwSNt9mINVQ
         WUTC2Lar+4RxZe+0jcorS+z8jB5P2u2DtQCiQhLbbQ1IIntJsKR4tt+kBRWEda4P7mu9
         KEJgv32tmcZa/IaogSaJ5LfmH43SOkzioa2+KrVJ6W+ckaIHcj2ZXOhsLIOn4iFha4UD
         Fysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924909; x=1792529709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BimhgbvfojlD6pHPB1upr9KfNd1p9a9GXQsOgOoHN8=;
        b=Zic259BF7aA1ep+nLmObXObsOlk/OdtBVsYGsJSD8nRhVLLlhPcjDWPCPAb7knUMkg
         RMqY9NohGPaZ8j5V9M8AOTmQQ2ho4EgcmD0f+8MSpJxvP0tVBIvf6QP02uPnZzAo29EP
         09p/ZMWJb3xy889EvHnCwo46Yr4x7YSlSx2d2b4ROAEG1qG8/rjRcpxVK9zp98VBbaUC
         jD5vDOMhxOmIptaMFGB2hat45EgnXEqItPLZEtwpbBIC/ucQk/8fN2O7N3fiL6SW4c6/
         iPc7jN9CXC9aAazdVc20PfBC9GHSZnT5xSruT9g1pWnXVThQxmGuvm8hQ0IWil8x96Sw
         KQtw==
X-Forwarded-Encrypted: i=1; AKwUvBzNtHSlftUvdF7xqpZgPU/UONzW22O/AcwY90DwIwKgXxbtbs7DZR1DrLoZqHfXWS2rqm12efxstUrq@lists.infradead.org
X-Gm-Message-State: AFq9FYIdyKJzfn81u07mQqQ+HCisfAx0T7gSZbDIRG6fYNQvNi8rnLKx
	V8PWNVGCeTZKG6H5H2VSwfZCy9jQaOX/Wa8PSZ96O/c7amIyStKFef2X
X-Gm-Gg: AYBFou0VcE7f84/yH9WHX3yX36MlpEqrYUccK3lxQjKaC/KEBRsynqNFel6Rz43cuGS
	1LMcXHssa1QAjoW/3ZvWxnDv8FCotQ+LLlvwZVstg1pkftL3hMwSy9xOgh2YbHCOsyMqq3Gs93X
	vU+Oo1QUrU2k2nf5kX5Pb3gKeu7SmNYfo5grjewQdpn63X8f7PY+u3AYTJ4Wt0vg5JLj1WLaRDT
	eSgV12My5ua3HQrkFkUBCRky4nirDI1aIjIScU3JZ1bM3HZjZzKhjTcrmVB5HRrCweI2RCNijr1
	/ktfVND8PgaiGKUJJhvT4K4qS890T925XhxqgqR+l+OFoDnT7tCcjVOLmgjOz1nYS6tGHrirvQK
	qJ2jfnNohJNNH5+H5KkBl5o3zUq9q1B+UEBmpsaC5P7Ko776Ar5x2v9260z+BQnIxerbSy3toO0
	VpOC21PJT5GnvW6cWHKWLkVL2dg3a30riF/06iTqap/m25enYVBVZft3SMTEWneGxlH0dL1YhS3
	akdqDWXzcj3luvWTY/mmxcU1KsB0L90dc00ZPnEhU+bw8poxc+cN4ZPvDDa+MFBtVH2YvpHwvTU
	jA==
X-Received: by 2002:a05:600c:5251:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a18e4d5a01mr268593445e9.32.1791924909279;
        Tue, 13 Oct 2026 13:55:09 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:08 -0700 (PDT)
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
Subject: [PATCH v10 00/13] Add dmabuf read/write via io_uring
Date: Tue, 13 Oct 2026 21:54:44 +0100
Message-ID: <cover.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135511_555152_0459FDED 
X-CRM114-Status: GOOD (  26.76  )
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
git: https://github.com/isilence/linux.git rw-dmabuf-v10
url: https://github.com/isilence/linux/tree/rw-dmabuf-v10

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v10: - Mark io_uring registered bufs uncloneable
     - Check io_uring size/offset on type truncation
     - Include dma-buf + PI fix from Anuj
     - Fix io_uring build failures w/o CONFIG_DMA_SHARED_BUFFER

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
 drivers/dma-buf/dma-buf-io.c   | 183 ++++++++++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 165 ++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  73 ++++++++++
 drivers/nvme/host/pci.c        | 249 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +--
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 105 ++++++++++++++
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
 31 files changed, 1321 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0


