Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BEBCCF2D4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9VJgNqGtSYTUgAl8FqB/CWbIZP3Ig20ib1t5wkL/EqE=; b=qOzrKah++G8M4MD9fvU4TBN+1q
	hRy1B7hpP/jWduCCE+rF888pCp7PMRUDiut1gxodIv7V+vQU3+G9IaPazI/y3jcpRduvra/W5X8Um
	8AsfcWIBKISM9Aqv6BTCc/L+BrJsD8k7mypPSakhNUVrLO8lTlrknMC4njNPDJYqWrMEz0urr70SF
	r7JwUK3VWgLGjP7PL4F3/GHiNgtPpmQ7bhQlceCdfUqN58WkZWMytDULGPGXqc6KUL4QqhaM5nAoe
	D5hkuSZIMpLYp2XampmR0+kaGQOp0sEjVNyKzpPfghXyZ+iAWf18Mpxytfj2dxvLxpl3q+NH3eISL
	dgJZOplw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB3-00000006XjE-2gAR;
	Mon, 19 Oct 2026 03:36:45 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAt-00000006Xcc-1oru
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380991; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9VJgNqGtSYTUgAl8FqB/CWbIZP3Ig20ib1t5wkL/EqE=;
	b=eTWuLm72uXGFLiKy5zzjYFSK2Nef0ef5uteSRhtt8AoGLq2sMu2N+301QGlYDuoVrOAN60EsfgjVscYmF4APgjhIiRZHkNZb8Tpf3wtTAK2IPk1u5zuX215aOZuwu53Z795AjTfEKCtMmdQicYRNHHFFOv0OYxMkdyzAdg4PARQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-YS9z_1792380989;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-YS9z_1792380989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:29 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND 0/11] nvmet: FDP bridge for NVMe-oF targets
Date: Mon, 19 Oct 2026 11:36:13 +0800
Message-ID: <20261019033624.402337-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203636_701319_BC7A551C 
X-CRM114-Status: GOOD (  17.31  )
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

Flexible Data Placement (FDP) is defined in the NVMe base specification
and therefore applies to fabrics as well.  An Ethernet Bunch Of
Flash (EBOF) style
storage system that exposes its local FDP-capable NVMe drives to remote
hosts over NVMe-oF currently has no way to pass the capability through:
nvmet neither advertises FDP nor translates or forwards any FDP command,
so a host connected through the target loses the write amplification
benefits that the local drives provide.

This series adds an FDP bridge to the NVMe target.  A namespace backed
by an NVMe namespace opts in through the fdp_enable configfs attribute;
the bridge then advertises the FDPS capability, reports the backing FDP
configuration through the feature and log pages, translates the
placement identifiers of write commands to the backing write streams,
and forwards the FDP management commands and log pages to the backing
controller.  The backing geometry is verified at namespace enable time,
so the bridge only comes up when the backing placement identifiers are
identity mapped, which the translation relies on.

The FDP commands are served by the bridge directly instead of relying
on the existing passthru support, for several reasons:

  - Passthru subsystems do not support reservations; the reservation
    commands are rejected and the controller is not advertised as
    reservation capable, because the underlying device cannot
    differentiate the hosts that connect over fabrics.  A regular
    namespace goes through the target's own reservation implementation,
    which is not available to a passthru subsystem.

  - A passthru subsystem is bound to a single backend controller: the
    whole drive, with all of its namespaces, is passed through as one
    unit, and no regular namespaces can be added to the subsystem.  An
    EBOF system needs to compose a storage pool out of individual
    namespaces from multiple backend drives, which only the regular
    namespace path provides.

  - The regular namespace path already handles the target side of
    reservations, ANA reporting and per-namespace configuration; the
    bridge extends that path rather than replacing it.

  - With passthru, the namespace identity of the backend drive is
    exposed to the host as is, and the host would talk to the backend
    controller's FDP state through the passthrough of every command.
    The bridge instead owns the FDP presentation of the exported
    namespace, while the state that the backing controller owns is
    forwarded to it: the reclaim unit handle status hosts read and the
    reclaim unit handle updates they issue are carried out by the
    controller that actually manages the media.

The Linux host side needs no changes: the existing FDP discovery path
(FDPS bit, endurance group identifier, FDP feature, FDP configurations
log page and reclaim unit handle status) works against the bridge
unmodified.

The series is structured as follows:

  1-2   wire structures and block layer helper
  3     nvme_bdev_ops export, used to recognize an NVMe backing device
  4     per-namespace bridge state and configuration
  5     endurance group identifier in the CS-INDEP identify data
  6     FDPS advertisement
  7     FDP feature (FID 1Dh)
  8     I/O management command forwarding
  9     FDP log pages (LID 20h-23h)
  10    placement identifier translation on the write path
  11    tracepoint for the translation

This was tested with a QEMU FDP backing device through an nvmet-tcp
loopback setup: the host discovers and registers the backing write
streams over the bridge, writes with placement identifiers land in the
reclaim units of the backend device they select (verified through the
reclaim unit handle status of the backend), and the forwarded log pages
match the backend byte for byte.

Guixin Liu (11):
  nvme: add the FDP wire structures for the I/O management send command
  block: add bdev_write_stream_granularity()
  nvme: export nvme_bdev_ops
  nvmet: add per-namespace FDP bridge state and configuration
  nvmet: report the Endurance Group Identifier in the CS-INDEP identify
    data
  nvmet: advertise the FDP capability
  nvmet: implement the FDP feature
  nvmet: forward the FDP I/O management commands to the backing device
  nvmet: serve the FDP log pages
  nvmet: translate placement identifiers of writes to write streams
  nvmet: add an FDP write translation tracepoint

 drivers/nvme/host/core.c          |   1 +
 drivers/nvme/target/Kconfig       |  14 +
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  33 +++
 drivers/nvme/target/configfs.c    |  31 +++
 drivers/nvme/target/core.c        |  38 +++-
 drivers/nvme/target/fdp.c         | 431 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |   8 +
 drivers/nvme/target/nvmet.h       |  93 ++++++++
 drivers/nvme/target/trace.h       |  23 ++
 include/linux/blkdev.h            |   8 +
 include/linux/nvme.h                          |  24 +
 12 files changed, 703 insertions(+), 2 deletions(-)

-- 
2.50.0


