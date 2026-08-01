Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F2BC55171
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YTrKNi3+MrECxNlqKVpRT5BFV68pBJo2ri08VcWIuD4=; b=tqBBatlTABMSyT4wbngqGOKZ2E
	fhgTQL4jLRgp2Av585FsyUnP8meRbbqw6pkcIlVUeAbsvVE+jlun0rx88kcSWj5D0vi99Gl//Doj7
	v8kGUhfyM+IhvbJmGYmU9h3mWU4cFopCpDD9XJ9wWPqbw97cdsQhmR1OmhcTj5lfU7EF8GkpcnPpN
	AE0H0DVMBJptssH36TRfc6RtEhI008F2UVRHoNPRLS0wCyCVJkwuXHHvDlwkyIkrKsNycqYri7Bh1
	jJgQ5laFCeaShotLmyUFGODEqlvc32UB90EAv6DugkeCocVJ2Tq17wz7VMV3iokIZqBO+i5OFEryX
	YvI/daEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX6-0000000FOLg-0NHN;
	Sun, 02 Aug 2026 06:18:48 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqBvK-0000000EorB-0n4P
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:46:55 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so23277945ad.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599213; x=1786204013; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTrKNi3+MrECxNlqKVpRT5BFV68pBJo2ri08VcWIuD4=;
        b=ZSfe1GhzuwEXXGj3d5gefKf8/n//JJrHmI7NatthxPmGRUF79rMMzw0HhhQMOS87zC
         Uu8vj+efYMyl+MEq1oexETO/eQol5qwHImaJCmZyXPH65oQWiDP5Y/eWLcglCmnIbqq1
         OSY44D2jxM0d0eqLM9lBsYjeYtO3JJkfI/wTJNLIlGVXI2kPKc3GPKciGQv0/B5+vT0W
         QN2OHJDbanqEU9QamlY0F4y2NlN9rAXyN0ybtPxJCCAqOcXXlYHs3GruGTB6viHY2mX5
         GCcJ1mKndIuhC86/uUtoop7U5NEMZyhGQ6Xxfwq+Pp7LfTUWRD0qZEjORjJQxla4Ny2w
         Yo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599213; x=1786204013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTrKNi3+MrECxNlqKVpRT5BFV68pBJo2ri08VcWIuD4=;
        b=Q75AkYc7lTn5D1pf3G52Or9uq4WL0lT8yppY6P5M3ZCguUPCPPn8SpapJyvVY9sd+e
         AP0foz+sNiB64766GpCUT4RzZFExJeIywQ3cPCcVg80CWfXE+rzzZYBwLmLrK4OzFOz2
         o3ffaiC8iYR+UAzipHk8QfqdQbh0CyRTuGjqbIxbVZ63tB3KuAPe+VutjQudhuHIlJzR
         mIS0KBBxjysaM/Ve9PLrNl+bZITUYudABK7fqzMKOhW1q8dMu2mIWrlhLW6h/gi32Q2Z
         p2Ouepunsgs0+O9oGS+0voy8iFJvtW0WGeuAC7Xn9HMkltGUI5eenMtHacKT3RU4kKPb
         j78A==
X-Forwarded-Encrypted: i=1; AHgh+RrmMSim4C7tKdJ+nY7pGglpjbO5rnRnzyw49wRLZ1QpsZmMeh+VY81c+kbQ4Wze2Z4GfB6vIK+ds833@lists.infradead.org
X-Gm-Message-State: AOJu0Yy60McZrNDX9lAEDEAjba5KBWYlnCFQE4A3epPmFCgUuZfwjy1H
	mzCCdgr+dXvgs4hpxHTmbQo/rzN16atgajRXZXVkodf/nRqYRrZ9p9BE
X-Gm-Gg: AR+sD12hodWzESFywHYfaEn0ap+MieeUQaJBcMRgUEH9W16ra2/qRu2x7MUZTAVL/QW
	GurPl71RS78lsz3+zyUI3Kj/oQAWyaIM1YwYeqeN9bYd+fG4GtGNn4hW15AwOvm9z0OrYcwT7XM
	7vpA3oTEdt+/Wc5LSp6Is8fANvzuNlyc8LymxExth5FNyyM1EIdNriO87c3Kll67Szu0BcsLS7+
	bLdVbbhJqlFMKYm4j3p8qhL9BhFk2BA05JonG+kRsoSIMffVVV58xyAxdD5uxueWYUUgk3dQCMU
	CmL6dwQt6dU1YjokEDE3so89L2Be8KUo2+BrbEPt8n40ox4+9EKUkuEM9x6MN9GXHdnlLXQLnYY
	0+sIIXHTcrKg6+B19Bo5cHoq8xgX0dXmSKEvnEfgOH7bVi7cMqB+cj3WfH0QlQRWiva0UodPW8i
	iT8017ba2bFJ9XhWpM9tMt5DScwhROBzLf+AI8bSsiO0YTOyOyoswGI+yBAZDpvKgPWt/ygJGF7
	zEo3GVzKBkETgh8WB1Y6QxsgKNF66nuWHyGojjQ6QX8DMo=
X-Received: by 2002:a17:902:e943:b0:2cf:ba0c:aa5a with SMTP id d9443c01a7336-2d05241650emr38409935ad.47.1785599212500;
        Sat, 01 Aug 2026 08:46:52 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:46:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 00/16] Add dmabuf read/write via io_uring
Date: Sat,  1 Aug 2026 16:46:12 +0100
Message-ID: <cover.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_084654_243701_21AD1F13 
X-CRM114-Status: GOOD (  23.79  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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
in the future. A similar idea was attempted some years ago by Keith [1]
(from where I borrowed a good number of changes). Later it was brough
back up to life by Tushar and Vishal.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to glue it together, count requests, manage
lifetime and implement invalidation.

Tushar, William, Phil as well as Kanchan, Anuj and Nitesh did a lot of
testing and experimentation on various devices with previous versions of
the patch set (separate thanks for trying it out and investigating
problems). Earlier benchmarks by Anuj for IOMMU optimisations with
udmabuf showed:

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-8: block layer support + prep patches
- Patches 9-11 implement NVMe support
- Patches 12-16 add io_uring support and uapi. Patch 14 specifically
  enables dma-buf support, the rest are preparation patches.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v5
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v5

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v5
url: https://github.com/isilence/linux/tree/rw-dmabuf-v5

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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

Pavel Begunkov (14):
  dma-buf: introduce initial file I/O infrastructure
  iov_iter: add iterator type for dmabuf maps
  block: rename bi_bvec_done
  block: always adjust bi_offset on bio_advance_iter
  block: move bvec init into __bio_clone
  block: introduce bio_iov_iter_set()
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 Documentation/block/biovecs.rst |   8 +-
 block/bio.c                     |  33 ++-
 block/blk-map.c                 |   2 +-
 block/blk-merge.c               |  45 +++-
 block/blk-mq-dma.c              |   2 +-
 block/blk.h                     |   2 +-
 block/fops.c                    |  35 ++-
 drivers/block/loop.c            |   2 +-
 drivers/block/zloop.c           |   2 +-
 drivers/dma-buf/Makefile        |   2 +-
 drivers/dma-buf/dma-buf-io.c    | 278 +++++++++++++++++++++
 drivers/md/dm-io-rewind.c       |  16 +-
 drivers/md/dm-pcache/segment.c  |   4 +-
 drivers/nvdimm/btt.c            |   2 +-
 drivers/nvme/host/core.c        |  12 +
 drivers/nvme/host/nvme.h        |   2 +
 drivers/nvme/host/pci.c         | 424 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c         |   2 +-
 fs/btrfs/misc.h                 |   2 +-
 include/linux/bio.h             |  23 +-
 include/linux/blk-mq.h          |   7 +
 include/linux/blk_types.h       |  14 +-
 include/linux/blkdev.h          |   2 +
 include/linux/bvec.h            |  17 +-
 include/linux/dma-buf-io.h      |  92 +++++++
 include/linux/fs.h              |   2 +
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 +
 include/uapi/linux/io_uring.h   |  31 ++-
 io_uring/io_uring.c             |   3 +-
 io_uring/net.c                  |   4 +-
 io_uring/rsrc.c                 | 280 ++++++++++++++++++---
 io_uring/rsrc.h                 |  45 +++-
 io_uring/rw.c                   |   6 +-
 lib/iov_iter.c                  |  31 ++-
 net/ceph/messenger.c            |   4 +-
 36 files changed, 1321 insertions(+), 131 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0


