Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC38BCA9EBE
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fc70of9qa63H69HPY6cKldSOdAbIZywdpsgVw4Pfjac=; b=hJM3lVMRV4KgMkEJiLjQlzPSxH
	q+No/CAFwfdSH3k1Bmzv8auzHQoyGacCtJECQMXIqIixk2G0Sg8KpsKO/JQ+whXmCuTK8VB5T9CAT
	TccblvJdUEUchKCFRu3ub2Q7nsMnpfIkdxdmk5VRUxN5MPaQEXQK9H+woijtYn/NdNpicut9ZpbIc
	ONTEF90JCAvMlqYx4nCTRIs97m18Uv9uM4Zmvy0XHVhDcJxGMt54tLTJclCaWrRhK2s8zKiVqgxvF
	liabTPV6IKUIQdxHqkajq6SmC70JXd9yu//2TCxEb92S4sxOJ7NqI8f5XhRBWEdWlH/CTJGZ2E98A
	ferZ9uVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDto-00000006hk3-1GyD;
	Fri, 09 Oct 2026 16:56:48 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgY-00000001cCY-3yyp
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:12 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso15451255e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337389; x=1791942189; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fc70of9qa63H69HPY6cKldSOdAbIZywdpsgVw4Pfjac=;
        b=SIAM7C/0pJfr8HoCGmUQ3HlTb0YY+5UixHY25lySJowKDOPwVo4Hzkshcd70ofMdLg
         tHCjcClktOIghx1nWR299o66DY9dED8F4jRZCOh2Fzvdt56d/URb5ztdR//Jd6HTnhK+
         dw5jnmwl/eeWpvSCwYQKOjqqk1S+O7DeSZSnR+3VAuaHAFaidKmJxbR8pM1fO/Ep+SMV
         dVgxM8P0hNaxiZ0d6rHAL/Iw4efGRLSAORxiQMrBHOt+iJaYbWQ395Fd/mkA9XvssQAJ
         EFTAav/kjNI4XeY/DwTJsE7dCK6TRBPBRXnGCBKGpZeEJ6PEsFPF9yjyBDzV9TP1ANIz
         uPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337389; x=1791942189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fc70of9qa63H69HPY6cKldSOdAbIZywdpsgVw4Pfjac=;
        b=GINrBSUCOLl0rcSQkSOKLZe15KapKK0PvD5szxbvu3I+bTLb679UHNdTZD5f+gmg6p
         imPQfBD1eiJFIla1poV1MJy9HJpj2p4xDNCzgxEuP1zPiUg/jczK5DA5NyP+1V7Rvz8t
         FlY9Q9yVRlVmVfYhrCoRj6tiCDB2IY7IcacVQ9dt2Xw+jvgCcv8yf+AD3Tcrh+q7zkOh
         UePhA+T/+YrOZ5sW3NVzVJE4Ra7R90nFXaC21SxTSRyHQ1rmo78ZKRPG6of9a6F4R555
         +dMY2wCLo99o+tddGybEj7MT6neNc4YhbvL8+qACY2wFr80WVGo6AA2tOeMZJ6ni05sm
         XpBA==
X-Forwarded-Encrypted: i=1; AKwUvBwvB3tGxHtp4ZZ0so5nAQG2e92VkxaltLV7WAhEn6eOtj8NPguh25Kn9/RDG7IESx5AMhMwFxWSS5EJ@lists.infradead.org
X-Gm-Message-State: AFuF++nOYxzMtuvcQJ2tQeM4QRyoXApMaz/HTmMudDbAehGon4aFjy0N
	TsONW2jDeeLCOg1n8TaWl2oIpaEnZm7P4FAcTx3SHQ4PZY8vN4VaUH9S
X-Gm-Gg: AYBFou21bYXM1+HwzxGzyW62ZCF3Y9b7PRIztRZ15DP/7bxjnvR+Nnxhkq8qcIv6QJt
	toqLwjvh8NYFeCSHxCzs+KsiWhnkgsVbHcTTzkSjAjOaDNjKicO8Cn0WkagcIT/QBtN5aekYY+Z
	h0uomcTBpk8AjpzOeGdOoz0AuJoSn2RIfl5ulIhZCxsHnqrxs3ChaPpKw+Gp2kXcRdRgtMQ0EqZ
	m9FECBPaWV/JD+XiD/g+bzcxjZxVUMFba36FADZuNKin7xqEdt7bNLtIRfPRzit95h1MuUxWUeo
	I4qU7tk7VwDEIigRverga0s04m4+bsdYa2AlUjYpKYt8xIQeAWwMk7agw0zQENUapMISM4b7f3n
	YEBbkAMr3oVz58lykNrGDlArt8gO+oTgYCp+OwUcG3tEZG7uEYshsidH8KXKve1S6v3trGqvQDo
	FjyuAsDaVdLXKxtWJ+UMycViJckYmUAK62ADuGsuRQQhGE9LVStPKLeckeG6RwBBX9506w/RCCr
	1FgENc62xN5G1r6QzGEYZ1UZUQO6KXtYArnMEyhyPpqTzMIoe7dDPrChAqy3kwgd+9jKQI77Q6j
	QlygjwmBNMc=
X-Received: by 2002:a05:600c:820d:b0:4a1:7a1e:6910 with SMTP id 5b1f17b1804b1-4a1802ea26fmr8467945e9.4.1791337389107;
        Tue, 06 Oct 2026 18:43:09 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:08 -0700 (PDT)
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
Subject: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Date: Wed,  7 Oct 2026 02:42:43 +0100
Message-ID: <cover.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184311_030177_B89A2F05 
X-CRM114-Status: GOOD (  27.43  )
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
git: https://github.com/isilence/linux.git rw-dmabuf-v9
url: https://github.com/isilence/linux/tree/rw-dmabuf-v9

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v9 - resend

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
 block/blk-merge.c              |  50 +++++++
 block/fops.c                   |  24 +++-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 183 ++++++++++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 164 ++++++++++++++++++++++
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
 io_uring/dma-buf.c             |  68 +++++++++
 io_uring/dma-buf.h             |  67 +++++++++
 io_uring/rsrc.c                | 172 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 lib/iov_iter.c                 |  29 +++-
 30 files changed, 1301 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0


