Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55628CA5FAE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rDgWSkzXb9T2f2eSv4f8loR9LBdnnTqRZoSNaSt6PRU=; b=Zl9aOTBuv9b3xYKTxwiA/Zqb4u
	9I8u0WXCTJmc0gpzQ0QhA8nsdHUY0Afihl/jOG0s+ynAZKGXcZFddw0Q6YnOWP0Irk1XTWnJvwvCx
	InhnuwsOwQkVBUpeaznqqsyx+xemEBRJZnrPpA5y6ay5dObStJZlc7MWnIInzTB2NfKSJ8suGOuVm
	fadNNa8KrX65N4UPelfJx9l1MQp1ZXQLRstUptF94doErWG7/OvcxfrT3Wd1IP+nj5a9RCk5XJiMf
	M/m+f9fMBTH1s56LIQYi7kk7dnu0uMiV6J4tavmqyOrzJvZMNFhwVYC3HSfFNU1U4JZC6awbIbIK2
	OoGPT97w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7b-00000002jJg-1V8d;
	Tue, 29 Sep 2026 08:23:31 +0000
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTK-00000000fB5-3g2Q
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:32:48 +0000
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-4888129c46eso1629444f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602364; x=1791207164; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDgWSkzXb9T2f2eSv4f8loR9LBdnnTqRZoSNaSt6PRU=;
        b=cm1QhqMZj0npIY+t+N1iKkOX38avCeIhh/tjmMfB+ZvA5PAQZV/GSxMpKaGoHSmlyS
         55dUrfoXrbSpPfpU76rRqQx5+MEgWWN5NTwtVduXEGy7PMMoudWChjV5AYptFCcnusvS
         D6ioVhldG59ak4E0WEg/v2MicmPwi5IFIzK4JAAUnhqWEkir30GNn24jv0AlCf3a9Qlz
         X7osb2TAIjdE+0JiCrHZ+XUamwol45ms2GcUNo1LjpsGGh41rZw8G5khrlzLyuhaW7Jf
         s+3xY3IHarqH3o9rUp6DthWVekcZ4jnw51qIEGbHL/v/fs3s3+veLl55oKux0BedjnhU
         LaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602364; x=1791207164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDgWSkzXb9T2f2eSv4f8loR9LBdnnTqRZoSNaSt6PRU=;
        b=2ZbMzDS0Y4I3gT7fKOkzlIjwh12FncEwR9F3ng86AOPjLdgk9C61RDbh+vDbpZoRSu
         JkOmls9alJr4uCzzwEaIN57xCoxCRrcvqb+H0sa93W+AIc7v0QmegslGgusU71fjfauz
         elLS6Sy7NIGfifrGR88RFXZcAalpQfewRjABX+6Ng+4SK8kkU1kX8coitca8pd0RZF/6
         +D8gSqBd6rjwRxYBGgAip0/LehNh010FhAsykEkuKfNF+4sa4c+gGiiVTWQCftFuWfL/
         qeqyRNiNOrMr5zACx0PM8suaVVJgLfJlRFRXF5Z5W7I1uDxvMB4dXqPKwgc4AvSTG7n7
         Lp+g==
X-Forwarded-Encrypted: i=1; AKwUvBygrDKbANOGdNJTs/mkAu64E/8hle0Nvo/FfCuuiaulS5D+yMx6Vv1NR6/akIgZUL406/+3A6Ydns0h@lists.infradead.org
X-Gm-Message-State: AFq9FYKLVeuC2uduo13BuPb5wGvwCMQfh4DAFR0iculQ6wfHNeXlkuPC
	5wLqOcpOh4wLyRm1FR8qLQ18oSKoBtDvbyGi/F5urKH/zJpS0TQubrv3
X-Gm-Gg: AYBFou1qDhxr4/PFEt8nWuDhPfHSD00QALtvfgjywTWE+eQs29P71H6IKZ27b/5WkLJ
	Z2DKYeHCwqsnpsImrJT+t/lChqrgj0QxI1Rr5xQ3UfcJEw1jiHF2eGtBvFYTq++cBHow5QtGkES
	hQCnwMaiHiFQ17nOqyO3UF+jIiFrJXHwn6FocJpsdlCABH9tJHVmGtR45/8Ro4569qjMqtQcGV9
	cXhO+CD7lVikJcgFTJpp1bg9ItYGt5NiPYBvw7ccX3mV3B+KRz3VtuQMKgtJ2jvhgEZfcBjpE8Q
	zHy9hhKZku2sUTiRVDGTooYd2nd/zk1RteU4y+4J8l8cR639xH2h9F1fl4djfInNk4TcHYT5Yh3
	SeOEMYM8RkYJlaxvPSAhbv+Uz81fJBsCNBtzUW/iNmRQaGid73ggLT402iuML3tRh4gr/G2l98E
	6Lzn+OS+dRP+OAAvau0Ltl86R+jYavU0QIiDEml6n2OT9qAyWqDWatYr0FBWLW4NCOgonji/wHi
	HfDOz1c74y35/ERbxY+PYTNDUFFrvFUOOvGeBKz8KrmMudR9hFizDOPQvvdYCUeGRqGZ0UbDuLr
	oWtbiW49k7ww
X-Received: by 2002:a05:6000:4693:b0:487:342:d141 with SMTP id ffacd0b85a97d-488774f4f02mr13825713f8f.23.1790602364016;
        Mon, 28 Sep 2026 06:32:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:43 -0700 (PDT)
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
Subject: [PATCH v7 00/13] Add dmabuf read/write via io_uring
Date: Mon, 28 Sep 2026 14:32:16 +0100
Message-ID: <cover.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063246_951928_A34BBE2E 
X-CRM114-Status: GOOD (  26.39  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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
git: https://github.com/isilence/linux.git rw-dmabuf-v7
url: https://github.com/isilence/linux/tree/rw-dmabuf-v7

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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
 block/blk-merge.c              |  50 ++++
 block/fops.c                   |  27 +-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 230 ++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/core.c       |  12 +
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci.c        | 467 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +-
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 117 +++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 +
 include/uapi/linux/io_uring.h  |  31 ++-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 275 ++++++++++++++++---
 io_uring/rsrc.h                |  45 +++-
 io_uring/rw.c                  |   6 +-
 lib/iov_iter.c                 |  29 +-
 25 files changed, 1304 insertions(+), 80 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0


