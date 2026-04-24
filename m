Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B28FF885A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ofDG2O/7VRYYZzf2TzBJwYLBfHV3BZtdxqHuqXtXmkc=; b=HGN1oqPVFX7I+jfrgEf2OIvjhd
	iFQMojSZokaW9SIvDeaOqUI644nnlDS5DR9B3HKxlBFdcfhj/A8awBINFmO/L1eqHBo+Xief6ZZMw
	Jd0AOqTGwZByIBia7sTeXBPKgIrvXFusjJj3XpwT4hu/wPbniQ+JPOzg70rnqO3I+gsgrfGqQs6cV
	o4BxsWvJMI5QtyFyULf01/L3TFmBpQRfwnm/1zlI9L/KCZUD9iTMetJM6teaF1D3/eb84hct5vOT+
	C1hy7JtwG5aplMw+JDNmVOAHHsIuvISF6F7wyrqA0jZvMAUhU0nuEsUjKeWE4MLNXlBlV4pIUcbwl
	XHtojjsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPE6-0000000Dpf8-01i7;
	Fri, 24 Apr 2026 22:42:22 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPE2-0000000Dpen-3aXT
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2SdP3cn0z1XLHZJ;
	Fri, 24 Apr 2026 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070532; x=1779662533; bh=ofDG2
	O/7VRYYZzf2TzBJwYLBfHV3BZtdxqHuqXtXmkc=; b=E2PQlhJ/9u9wesfcL3B/7
	HVCzJBIko5AAI64JfJPeSl3qMbGj+5dlXyTCeLWsgU+8WQtiWdutdmGxnjJK85ZN
	5Wmz3xJuqqQGdDwILWEe7IYuk6txetbEmutrqNL8EP4+OvJWXpbHysYGF9G7KIQY
	JKz5XiE3Fq/xnGPuIuEefIgj2IWodhgQREL40HiLV0VOtvJ/axf1TZYJ6IPEkxMZ
	uJijLjvbiVeYpIbHX9NXAjCE3RpXXIkazSf95YIsR0ZTtzLX/KblL4K2kDmtQUrL
	mZvi97EshpoIKOyrwqz9n9hfM5HaUqGdiaW4n7ZdpmqUZsf57K9taj0B5wML0gYF
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YicA8r0OLa3d; Fri, 24 Apr 2026 22:42:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2SdG5GdCz1XLF2r;
	Fri, 24 Apr 2026 22:42:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/12] Block storage copy offloading
Date: Fri, 24 Apr 2026 15:41:49 -0700
Message-ID: <20260424224201.1949243-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154218_951142_7C6BF8E2 
X-CRM114-Status: GOOD (  15.47  )
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

Hi Jens,

This patch series implements a new approach for copy offloading. Compared=
 to
Nitesh' approach, the differences are as follows:
 - Two new limits have been introduced representing the maximum number of=
 source
   and destination ranges. Support for multiple source ranges for the NVM=
e Copy
   command has been added.
 - The blkdev_copy_offload() function can now submit multiple copy offloa=
d
   commands instead of only one.
 - The implementation no longer depends on block layer plugging.

This patch series includes copy offloading support for the Linux kernel b=
lock
layer core, the device mapper core, the null_blk and the NVMe and nvmet d=
rivers.
Support for the scsi_debug and SCSI core will follow later.

Test scripts are available here:
https://github.com/bvanassche/blktests/tree/copy-offloading

See also Bart Van Assche, [LSF/MM/BPF TOPIC] Block storage copy offloadin=
g,
January 2026
(https://lore.kernel.org/all/0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org=
/).

See also Nitesh Shetty, Implement copy offload support, May 2024
(https://lore.kernel.org/linux-block/20240520102033.9361-1-nj.shetty@sams=
ung.com/).

Anuj Gupta (1):
  fs/read_write: Generalize generic_copy_file_checks()

Bart Van Assche (4):
  block: Introduce blkdev_copy_offload()
  block: Introduce accessor functions for copy offload bios
  dm: Add support for copy offloading
  dm-linear: Enable copy offloading

Nitesh Shetty (7):
  block: Introduce queue limits for copy offloading
  block: Add the REQ_OP_COPY_{SRC,DST} operations
  block: Add an onloaded copy implementation
  fs, block: Add copy_file_range() support for block devices
  nvme: Add copy offloading support
  nvmet: Support the Copy command
  null_blk: Add support for REQ_OP_COPY_*

 Documentation/ABI/stable/sysfs-block |  24 +
 Documentation/block/null_blk.rst     |   4 +
 block/Makefile                       |   2 +-
 block/bio.c                          |   1 +
 block/blk-copy.c                     | 631 +++++++++++++++++++++++++++
 block/blk-core.c                     |  38 ++
 block/blk-merge.c                    |  13 +
 block/blk-settings.c                 |  36 ++
 block/blk-sysfs.c                    |  35 ++
 block/blk.h                          |   5 +
 block/fops.c                         |  54 +++
 drivers/block/null_blk/main.c        | 113 +++++
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/md/dm-linear.c               |   6 +
 drivers/md/dm-table.c                |   8 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             | 106 +++++
 drivers/nvme/host/trace.c            |  21 +-
 drivers/nvme/target/admin-cmd.c      |  26 +-
 drivers/nvme/target/io-cmd-bdev.c    |  80 ++++
 drivers/nvme/target/io-cmd-file.c    |  59 ++-
 drivers/nvme/target/trace.c          |  19 +
 fs/read_write.c                      |   8 +-
 include/linux/blk-copy.h             |  50 +++
 include/linux/blk_types.h            |  57 +++
 include/linux/blkdev.h               |  20 +-
 include/linux/nvme.h                 |  47 +-
 27 files changed, 1449 insertions(+), 16 deletions(-)
 create mode 100644 block/blk-copy.c
 create mode 100644 include/linux/blk-copy.h


