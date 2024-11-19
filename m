Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA40D44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i3Xl2HhaNwGkbKVGt0Kc10inPZf4kOM60z2ZPtXlPtk=; b=DdTQCn/DNsazHjqZ90eflHWf1q
	4KArijuCh5PLCZbx2JsVQf+VFPYX7IwbFs+aSMMkUt8SyLVtHHlgUA8yxby4Sw6ET7EF3LOhq3G+t
	FccnE1ybNGsHRlWQqIEGW5ur8i8S9QP4PC+R0LleEoMYZXZAVnshKRFFm184t+DZKjNrRrud4xoIF
	Up69s1ZYr2ofHz8Wtuy3n10tDJByZIuc6F/D3WXqEMmHx2YXiV80Nu6zQHf6h5ctluNPXIMBIiJ8d
	wGJaS79Q2cC4mw5ksFMYxXJR2Mijo7n7PFZylSlSXIwp0m4LprkFvPyZAsQhyUHUPD6Joy3B18CSd
	7u/k7fTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDN9r-0000000CIsE-1lYP;
	Tue, 19 Nov 2024 12:16:39 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDN9n-0000000CIro-1RHM;
	Tue, 19 Nov 2024 12:16:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: support block layer write streams and FDP
Date: Tue, 19 Nov 2024 13:16:14 +0100
Message-ID: <20241119121632.1225556-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

as a small interruptions to regularly scheduled culture wars this series
implements a properly layered approach to block layer write streams.

This is based on Keith "Subject: [PATCHv11 0/9] write hints with nvme fdp
and scsi streams", but doesn't bypass the file systems.

The rough idea is that block devices can expose a number of distinct
write streams, and bio submitter can pick on them.  All bios that do
not pick an explicit write stream get the default one.  On the driver
layer this is wird up to NVMe FDP, but it should also work for SCSI
and NVMe streams if someone cares enough.  On the upper layer the only
consuder right now are the block device node file operations, which
either support an explicit stream selection through io_uring, or
by mapping the old per-inode life time hints to streams.

The stream API is designed to also implementable by other files,
so a statx extension to expose the number of handles, and their
granularity is added as well.

This currently does not do the write hint mapping for file systems,
which needs to be done in the file system and under careful consideration
about how many of these streams the file system wants to grant to
the application - if any.  It also doesn't support querying how much
has been written to a "granularity unit" aka reclaim unit in NVMe,
which is essential if you want a WAF=1 but apparently not needed for
the current urgent users.

The last patch to support write streams on partitions works, but feels
like a not very nice interface to me, and might allow only to restricted
mappings for some.  It would be great if users that absolutely require
partition support to speak up and help improve it, otherwise I'd suggest
to skip it for the initial submission.

The series is based on Jens' for-next branch as of today, and also
available as git tree:

    git://git.infradead.org/users/hch/misc.git block-write-streams

Gitweb:

    http://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/block-write-streams

Diffstat:
 Documentation/ABI/stable/sysfs-block |   15 +++
 block/bdev.c                         |   15 +++
 block/bio.c                          |    2 
 block/blk-core.c                     |    2 
 block/blk-crypto-fallback.c          |    1 
 block/blk-merge.c                    |   39 ++-------
 block/blk-sysfs.c                    |    6 +
 block/bounce.c                       |    1 
 block/fops.c                         |   23 +++++
 block/genhd.c                        |   52 ++++++++++++
 block/partitions/core.c              |    6 -
 drivers/nvme/host/core.c             |  151 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   10 +-
 fs/stat.c                            |    2 
 include/linux/blk_types.h            |    8 +
 include/linux/blkdev.h               |   16 +++
 include/linux/fs.h                   |    1 
 include/linux/nvme.h                 |   77 +++++++++++++++++
 include/linux/stat.h                 |    2 
 include/uapi/linux/io_uring.h        |    4 
 include/uapi/linux/stat.h            |    7 +
 io_uring/io_uring.c                  |    2 
 io_uring/rw.c                        |    2 
 23 files changed, 405 insertions(+), 39 deletions(-)

