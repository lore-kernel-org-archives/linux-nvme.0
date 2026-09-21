Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283E8C982FA
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=; b=TO888y2vi4oTGyRoHlFXL0E1kz
	64Jh5Xmx9ZnAyxSaf959Z3XDN+nNgagkNMTFIPuDr8m0nacaEGrn5cEWh5CkTwprSGXJ9IVlILPWP
	z0UK2gwBIovQTkKeScXmSem2ION3h0q4WnfRQbNVqb3jDpA84mvqKQQ50sPTP0ROh6kqynOfNAemo
	fQ2puKXRhz72HXZA5EwflTGA0OdCWWyCb7musqXAvDtYev1c2iH5Mx4P2ZNDVWpmbx98vmq1XqcID
	b2ids+x14RJCKLID6GpjhdutLO+XlOu1Vyi0VDa5P2PEX1ZDyutmGagFVQuK0KWV5j0T8P/GCmYZi
	+SdxDOHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWF-00000002VgI-1o4l;
	Mon, 21 Sep 2026 15:01:23 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eEq-00000002GNm-1UQZ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:21 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e721b5503so29854555e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997958; x=1790602758; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
        b=c1HYddA2qOzalnqAupfeHLWs//zm5DXG0BNeeGvJI8PKPvFe78Be8jK2HX9LCWz9lw
         CE18D/bZe8P2u0lrTGvl0QbysdPz5b8f3XZ383rEr3CUNVVJw3djDMPeB7b/7L40WFHj
         C+//Mls0lKhErnEWV0XAYYFZ2T6uLgwX+UqZ+/f/geY7s1FHxh1CUIZEryd1A0zqDN2+
         7fCA5VawxwZTItZK93GaxbR06rPH/Vn8qn4tZKdGRZ/Kzy4aM22plzccrOk3lngyty5c
         YNqsEkeT0yrE/acSJHMJMmjNmJMFzIxt74X22a+xjvaSXORY4v7/vnxYdjmTX80a93Ke
         DLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997958; x=1790602758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
        b=LZOa7ipv0b+5JVzoe9HBTR/48drroJ6qvkjfxA2XYs5FowBlHqb3uu5keQ4AFn2aCk
         QTL1iu3QnJvWhRigBmz04KOL7JFpdFKkY/57ZWcgQxAmBfGgx+YINJdJ1SXDROJZ3K7Y
         TEvAjRSmj40aR7VthZWWSod8LNBBzz2qGSZ29bCl9Yt50LixGqB+0l7J34aEVFeAVmhu
         K+NDIzafehab660RzwNqbLJTTp0zs6fS47bXoPQBIvNxvdg9oiW8p6xRcezlI63knoHx
         ekl54WHxpZ3iWYOXqn3CLYKfF83xHwpMDndJ6jucLdEYTz7EHeQ+Qdup2xPrN5aZRP0X
         RlGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzV19VauDc5ZEqKIhZYx0ETRVUlk5GwrYhwdKfCHyZLK5M0QW+nKbt4vCyiTSibb8OR2mWLyV+q6K5I@lists.infradead.org
X-Gm-Message-State: AFuF++k+zu1/1mONqS3d/Lselxw9Urgkyf5T931jwVfPwUAwgxwZpScj
	vA0mbRk3LazQeTS1xiBk4JSqMO0XHC9Vui74rV39Ng9zNMocAaxA2VqU
X-Gm-Gg: AYBFou0ckfxmyQ6QMJMsmTDtY07hjp7SG/Uar2Cw2lZH4BWHRla+GzJap2dMc/QvggT
	0srvaPBBRyPt75IMSc4fzxOHZWxY7pAwly63cwlDlLP6QNg1gJXhbkpSgpEAn3REsnE6OTUvG1P
	pQ+8ZQ4nV8+gJMPh11MC2PGO1RZGHfNhO3nxyjchF0AHOOwNZg3UczfINz35apvZVjjW1hSdps+
	WxdmQUVZXXuJ2q9UwbFqdLav7lVP+TkL/qS0D8yePzqLp7KQ0NORuFrdZPj8SpxE7jA16nTX3v+
	WIpuzKVNmV7GQpuRArPuWOD+m5iA3ds3h2OmT3M9f3USOubk7Zl9NIBz6JtRqRWHqI3p2NsTvfA
	XR7UtNr9Fm5DK5RtcoaBjpNIGNXrsVoFo1kePpbrZeCjJX+DlIhH4Vix2DEKUOKE82SF/rFtvSw
	y0KIg8tAkWDjZhBJ0/Tn967TcHg2i4xZrJW4/oY+VTNguKENBNTCOTv5HbU7VXi4ns9VuNe8BnQ
	v4xvn7NsuuFG/cQM6AqBOY031NXblMup/oCr2u5G0iJ865i/OxSortVDYaEsP6ldR8U8EesEqJw
	uRf39rqayEeXH8iJKVwgKHGSCCdGOA==
X-Received: by 2002:a05:600c:1989:b0:49e:8184:f617 with SMTP id 5b1f17b1804b1-49fc573610cmr163288645e9.22.1789997957649;
        Mon, 21 Sep 2026 06:39:17 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:16 -0700 (PDT)
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
Subject: [PATCH v6 00/13] Add dmabuf read/write via io_uring
Date: Mon, 21 Sep 2026 14:38:44 +0100
Message-ID: <cover.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063920_433143_51698171 
X-CRM114-Status: GOOD (  24.93  )
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
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v5
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v5

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v6
url: https://github.com/isilence/linux/tree/rw-dmabuf-v6

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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
 block/blk-merge.c              |  45 +++
 block/fops.c                   |  24 +-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 219 +++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/core.c       |  12 +
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci.c        | 484 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +-
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 113 ++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/uio.h            |  11 +
 include/uapi/linux/io_uring.h  |  31 ++-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 274 ++++++++++++++++---
 io_uring/rsrc.h                |  45 ++-
 io_uring/rw.c                  |   6 +-
 lib/iov_iter.c                 |  29 +-
 24 files changed, 1295 insertions(+), 80 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0


