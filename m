Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1982FCA9EC0
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hvzB42gUMiV/KR6lqPvi8GnnActkQyAM+I4+Sj3I6TM=; b=kwg47ULRP/E9XpiKoGDDhLJZTm
	Znnxn+rdfBFeGVCIvvHW2QmHIt7dOHlppvcYKENRwuIeiDQ4ey9k9klcjzxvQdPVOeyPUTKT/SKO8
	81U09Ac7yVMY+NLN4SZ70Mr3urG5bTeFJMlU29pS3C4cNR2zg+XtZoMWl0D4SokQ74F4FmHuotmco
	y58uM3YxqaTdO77CpP2uW/nD1jvNt1S92wyav9YHLzeLqA//YXfGu58eTc2CqLOrnlXT0fXUDZFco
	C697SJNb4NM4Vourztd2E8qUsTrMecPGz8HFsJ9yGD0b7UMNe3DhBWHm6SaGhVJz2fif3y08od+d/
	qUPVjNWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtc-00000006hUz-10yz;
	Fri, 09 Oct 2026 16:56:36 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGVy-00000001arM-32OI
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:16 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso31546235e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336733; x=1791941533; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvzB42gUMiV/KR6lqPvi8GnnActkQyAM+I4+Sj3I6TM=;
        b=NN/gahiTzzdR00sBFV+zAZGlIpPpeDmK+2Yo0xvZ+BOxmc91xxM1uUHBjkeQdir85m
         XE4lXS5AdX7FjmRLvrIs6vQKoMc0Jlc8YNwmghY5NXycT0uXuhBJD+j2iWFx9pV6ReX4
         i+hlgchcVBPJ24TB18fCrdf3uOaVGdC91yHvC2WNsHGoY6w7lxsIAnIkjCY3qwLr7ofE
         Ik0DttII+gfWjCQ8GpI7juR5Sf6L/oMVx8b7by7thmXmkpM+kCgiZsfbVhp+TJQDtotq
         Z38HyBYZSHNUwCAyZP4TNjPj+CFRn5YMGBmUrO8Qij87UFIkOkeRYFGeuwhOFmKk8Kv8
         T03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336733; x=1791941533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvzB42gUMiV/KR6lqPvi8GnnActkQyAM+I4+Sj3I6TM=;
        b=Y2DiAYpFlfnYmfK7VDt61djd+svld857mcRtOSpGA1xMZ59oQTH8r292g3+Rnc2EMs
         rQZsrNB8FrUhiE93WcvU8nOaEU3oXZnmRtK69BgQwt4uhqaoaTuGiPBr9EaAMU163b6P
         KsniLcwvX1blI8lcaqssLuc6ZPWM7VAElya4zW6Rd52s6jMNbBdkZSRZQQlGfDTo8cNA
         kg006xVEf3Bu0A6YnlCETlx0sSZ2lFnDWOcDk8BbhihxbxTdi4pNymcceysKq5uzZLA4
         4AfatYbw4Jzx6eRnBttVJW8JUW/eVm0wcBJinC8dkrRR8omtoxHhA79vF/c6d1ViMemY
         a3lw==
X-Forwarded-Encrypted: i=1; AKwUvBzWd9WS6R+hSj/P3TUGhRavNVgD71grRzF8c52TAti9eGl7Brjy5e6niNVWT+EWJSmpJ/oNqcckaG3L@lists.infradead.org
X-Gm-Message-State: AFuF++l2rWbCNOuGznuh7sOKI4g4bs16qA03lAOhruHS91c2QKfOhxWH
	woHdZZTcAo8Pt7chNT1PzBL2iEZW5DiBMj2mj8HDVsFDkpX3v8mlU+PN
X-Gm-Gg: AYBFou2SDDlPSQ8L1uuZ77TLVlr3uzZ3aJE8fLfDCFQOdkDcTfeq3PfyOVEiAu6IPvf
	zBlsW3rsMQAaFpvvx9rdE1/ugL7NV1lAzUrXvPVeYIF3ix9923cCqb3PurvNPiQuzAAH/cWgsRG
	nRSA5fAiNklORp2DNut/+2w8KzrWjKXwgy6yGmgn8OIN93S0dNWvk0/jZv/HLU3PuzkHK82wcXE
	XlcYhxmslz9vQ1wQoZxwalA7eGT6kY7CguPU3Wtct4pp+ZldkEWuZx5i7Z1c0LeH1wo942wW8qO
	AvDoCeoncDEbRew5Zc2s+V9LAkkLUKiVbL4b7w0LRRMyWn6um3z9MdWYqxxbzovKwTqG9XAdShE
	PPw0rIhhRopmlorKvZ0PSOhCDkakwcb48182GbCu3C8KqesjZSlcsDN+wFTqvZQ6gSQIMCk3M7L
	Z6IcnKsPpfdRJ+kRV3GenAHdGV2TPrhMLgkvN+ZUxdRBrLFtHH+D2+Gk6EgETRSDa9bnVOVwdKU
	fz/NE7s0kwSrh8ClMGMfM9UiLEkDCzzGSlDSw8czEyMmL1wXADHKmRCXw0dve0HwL/jr6rM6BW9
X-Received: by 2002:a05:600c:3f16:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1800d3f2emr7099925e9.2.1791336732453;
        Tue, 06 Oct 2026 18:32:12 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:11 -0700 (PDT)
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
Subject: [PATCH v8 00/13] Add dmabuf read/write via io_uring
Date: Wed,  7 Oct 2026 02:31:43 +0100
Message-ID: <cover.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183214_802625_EAE45F56 
X-CRM114-Status: GOOD (  26.96  )
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
git: https://github.com/isilence/linux.git rw-dmabuf-v8
url: https://github.com/isilence/linux/tree/rw-dmabuf-v8

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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
  block: always adjust bi_offset on bio_advance_iter
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  nvme seaparate file
  nvme sgl fixup
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  50 +++++++
 block/fops.c                   |  24 +++-
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
 include/linux/io_uring_types.h |   5 +
 include/uapi/linux/io_uring.h  |  31 +++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  68 +++++++++
 io_uring/dma-buf.h             |  67 +++++++++
 io_uring/rsrc.c                | 172 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 23 files changed, 974 insertions(+), 78 deletions(-)
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0


