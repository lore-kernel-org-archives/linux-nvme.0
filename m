Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72E6CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=; b=llrVwveaumed8GA8X6FkUTD81q
	38w5oc/Mpk+kkvPKAu0X65T6VctSxmBl6qRgq19Mxotmr+Q6JIuYPagre8/tvvL5sIHB/PbbtZ2P/
	M+YmID0AklsfUh+jr6chjoxmAYXJUmAHciVGJ134ZWheXfPRkvPOdEy53KSZR5H3UxXeJ3fL5PdJl
	78QRGSia7U7K+3GonSGo+uX3wy1WbDoD3m2CdT91fEkORw/34Q+8eJRn8ttbtWEKXB97GFd+88FOl
	cH0gQSdEpWsxJXqFPfww8F8jDWQwCQipT6erZZBsjU8KflBACIdocgPGJ0T2KHtpIyRq9JwpQDHz6
	YIuf9OpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6nu-00000003q2h-21FW;
	Wed, 29 Apr 2026 15:26:22 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6ns-00000003q25-1FSK
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:21 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-488b0046078so114871915e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476378; x=1778081178; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
        b=qYBQr3uDUO/vUx6U3YZKYOX/PddU2LG2ZGzB7buvsDtqyYzxiy+jYvEzEKUInMaCUN
         wkjcNLKvzRat++IHrdeAToYTY90DhpEhiWG9MWplGaPPpHTBfp0xaEj9vqxpGpK99A7o
         tzk3gkPwRGGaYSbpZgklEVgJHUIlvf02FdEfZTix2Dr8NfocHAR655ALYrN2j/4lW9j5
         C6D3suY0vWUu9ydfL1vBJcEU/GrjdtJtcZBw0YC8te22JD1CslB+xK8k3DG3nmdcPjWz
         4BVz05rGs+nq0IIQFidoKbKLdBgCHrZQnZixdhVhjLHo8AOk91a2/m4dJI9nE1HpmY4n
         wjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476378; x=1778081178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
        b=ZTh6DHGlRes8Fj9lnkXK+YlG8lL1PJtJFscoHrF3gN5t+ruDvWzaAtWRlNux5k8Iia
         R7CIzlDqksD2HAmaefTGArwh556AKd0VrO1O5TwkD6fpM2j1exZtsnvj0CpuOuhrAE8I
         D1Job9c9aguOThDO3YHqhoVdjpuRqif9mc7LCEb1AtR50x8BbxGp06Fd6hwwYFp5Rolt
         rcAMm/tZ0t5yCjDqt/pKgyVBM8iY/2Nej6+uS2zw62t5PHAWrkyr970F4azoUu3SdvcB
         q8gjoWCn8bDeaexGcw5XbQrQ5e0uVZRVc6VHMxWnvw44Xm1DWq8TLOPDC5XJ2Q0FtfOc
         Xf5A==
X-Forwarded-Encrypted: i=1; AFNElJ+BCU7QvTivows9TbP252fXmajuq41Ns4b77wD5MPdB1RVaFf+VNpCYuo/g5VFZrwLbUYrpGLnn5qf4@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9KplklOIR3NptNAkAt5VtGetFGCQXgcjLw6yu7Qw8cC2H/2un
	NMop1POcCotJD+YEM51EcbAP8VetBzj3NGtl4JmNqooSD+LLKAA8NIcf
X-Gm-Gg: AeBDievtd27unyi/0RNFIu/KjoOVuDvu177fIGg1HA3JouBnzBY9YSl6rSD/qK+jFTU
	Zj1IN1/k+3XPznZ/r3aZ85nclNfhm8WP59jvvFB/bkvpClZ5rBiJBuFlHcd/amo6aw70ZngeKQy
	zxPkTLSvi9ra4/y5EwcMp4xYYu/RGVfbO41JBhtNNdC/o/2BtuK2TmFXd9yihEwqppnaJY+PHVF
	Xjl2oruYDV1iFcn3FcflsOyon4HyfsWviLHrmPRpbmn06ZQ12ka9YLoBm6d6A/cjCWf/65gpeXC
	n6AAlWz85Y2zCvgB8/n0GNnDziqeZCLuy7JJHwxLoTaMuDKKP1QuSn4Vzruc6LZqVCh3ildzARI
	FBLtVbcVf+szxpDML5wh+TX++hJUM4qNtfe6LzEfRGRTP5a94zWNv6/lntt8K+H3zWnUAQ29JCD
	BZt+aiIS8pZ7prqSjcN2rnc0QEdttkzfq+iyS3gLW37zoI3R9djl+jlY6LB/L7No4z3I8WspY9I
	TN1+ebE5Gwz3SJx58MqTjeXybP+qvzsXW1bQZKNjEKu
X-Received: by 2002:a05:600c:4f92:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48a77ae5430mr125646225e9.1.1777476377153;
        Wed, 29 Apr 2026 08:26:17 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Date: Wed, 29 Apr 2026 16:25:46 +0100
Message-ID: <cover.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082620_381224_87408D74 
X-CRM114-Status: GOOD (  21.48  )
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
from where I borrowed a good number of changes, and later was brough up
by Tushar and Vishal from Intel.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to bind it all, which also counts requests
using a dmabuf map and managing lifetimes, which is used to implement
map invalidation.

It was tested for GPU <-> NVMe transfers. Also, as it maintains a
long-term dma mapping, it helps with the IOMMU cost. The numbers
below are for udmabuf reads previously run by Anuj for different
IOMMU modes:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v3
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v3

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v3: - Rework io_uring registration
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

Pavel Begunkov (10):
  file: add callback for creating long-term dmabuf maps
  iov_iter: add iterator type for dmabuf maps
  block: move bvec init into __bio_clone
  block: introduce dma map backed bio type
  lib: add dmabuf token infrastructure
  block: forward create_dmabuf_token to drivers
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                     |  28 +++-
 block/blk-merge.c               |  14 ++
 block/blk.h                     |   3 +-
 block/fops.c                    |  16 ++
 drivers/nvme/host/pci.c         | 282 ++++++++++++++++++++++++++++++++
 include/linux/bio.h             |  19 ++-
 include/linux/blk-mq.h          |   9 +
 include/linux/blk_types.h       |   8 +-
 include/linux/fs.h              |   2 +
 include/linux/io_dmabuf_token.h |  92 +++++++++++
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 ++
 include/uapi/linux/io_uring.h   |  31 +++-
 io_uring/io_uring.c             |   3 +-
 io_uring/rsrc.c                 | 266 +++++++++++++++++++++++++-----
 io_uring/rsrc.h                 |  30 +++-
 io_uring/rw.c                   |   4 +-
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/io_dmabuf_token.c           | 272 ++++++++++++++++++++++++++++++
 lib/iov_iter.c                  |  29 +++-
 21 files changed, 1071 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/io_dmabuf_token.h
 create mode 100644 lib/io_dmabuf_token.c

-- 
2.53.0


