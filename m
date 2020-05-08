Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B8C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159F92173E
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkkM7RIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159F92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Sx4bAFv7ABMICqJCbtjKi5xin3GIEDm3WhaFrj601Cw=; b=kkkM7RIVhOmfpq
	gRuSbWVfB4GTV4rXWOuZ7Hd0JKf7fXcKqIuaqk65TZI+V7pystwvRXrWSc7oZqj7W7Cje1y1Rtb8M
	9qsSzzxd3m5//u/0tuRkUXa8ZJKRs3A1bWB89x+0WFTXX8qEzioDj5Gwtsm5tQfzmdJGUIIhISXYp
	vw2SEQFV4tTxYdFZARtNEsHGF0bxj1ndw9YYYZvS+ZlgYlpj6oPPdOJmFwLEQ/oM+iSsIghNiXWTx
	eTmuZ/jKDx5vidBhPk8R6goKdmLCMrzxkIXmMBIxep57oBlq83v9X2/J5rAmcVVpwm5Afw4pO1HQW
	wH9nsZj6YNG7obdF8GnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX5BD-0008QB-8g; Fri, 08 May 2020 15:44:51 +0000
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX5BC-0008Pu-7g; Fri, 08 May 2020 15:44:50 +0000
Date: Fri, 8 May 2020 17:44:48 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] first batch of nvme updates for 5.8
Message-ID: <20200508154448.GA250683@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

here are the first 60+ nvme patches for Linux 5.8:

 - NVMe over Fibre Channel protocol updates, which also reach over to
   drivers/scsi/lpfc (James Smart)
 - namespace revalidation support on the target (Anthony Iliopoulos)
 - gcc zero length array fix (Arnd Bergmann)
 - nvmet cleanups (Chaitanya Kulkarni)
 - misc cleanups and fixes (me, Keith Busch, Sagi Grimberg)
 - use a SRQ per completion vector (Max Gurtovoy)
 - fix handling of runtime changes to the queue count (Weiping Zhang)


The following changes since commit 8b075e5ba459c7afdd7b2fde14cbc01c51e25eac:

  udf: stop using ioctl_by_bdev (2020-05-04 10:13:42 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 8f17cfe04d1a0e8e9a5433bfa27b2db4856df9be:

  nvme: define constants for identification values (2020-05-06 08:54:46 +0200)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvmet: add ns revalidation support

Arnd Bergmann (1):
      nvme-fc: avoid gcc-10 zero-length-bounds warning

Chaitanya Kulkarni (6):
      nvmet: add generic type-name mapping
      nvmet: use type-name map for address family
      nvmet: use type-name map for ana states
      nvmet: use type-name map for address treq
      nvmet: centralize port enable access for configfs
      nvmet: align addrfam list to spec

Christoph Hellwig (7):
      nvme: refine the Qemu Identify CNS quirk
      nvme: clean up nvme_scan_work
      nvme: factor out a nvme_ns_remove_by_nsid helper
      nvme: avoid an Identify Controller command for each namespace scan
      nvme: remove the magic 1024 constant in nvme_scan_ns_list
      nvme: clean up error handling in nvme_init_ns_head
      nvme-multipath: stop using ->queuedata

James Smart (27):
      nvme-fc: Sync header to FC-NVME-2 rev 1.08
      nvme-fc and nvmet-fc: revise LLDD api for LS reception and LS request
      nvme-fc nvmet-fc: refactor for common LS definitions
      nvmet-fc: Better size LS buffers
      nvme-fc: Ensure private pointers are NULL if no data
      nvme-fc: convert assoc_active flag to bit op
      nvme-fc: Update header and host for common definitions for LS handling
      nvmet-fc: Update target for common definitions for LS handling
      nvme-fc: Add Disconnect Association Rcv support
      nvmet-fc: add LS failure messages
      nvmet-fc: perform small cleanups on unneeded checks
      nvmet-fc: track hostport handle for associations
      nvmet-fc: rename ls_list to ls_rcv_list
      nvmet-fc: Add Disconnect Association Xmt support
      nvme-fcloop: refactor to enable target to host LS
      nvme-fcloop: add target to host LS request support
      lpfc: Refactor lpfc nvme headers
      lpfc: Refactor nvmet_rcv_ctx to create lpfc_async_xchg_ctx
      lpfc: Commonize lpfc_async_xchg_ctx state and flag definitions
      lpfc: Refactor NVME LS receive handling
      lpfc: Refactor Send LS Request support
      lpfc: Refactor Send LS Abort support
      lpfc: Refactor Send LS Response support
      lpfc: nvme: Add Receive LS Request and Send LS Response support to nvme
      lpfc: nvmet: Add support for NVME LS request hosthandle
      lpfc: nvmet: Add Send LS Request and Abort LS Request support
      nvmet-fc: slight cleanup for kbuild test warnings

Keith Busch (15):
      nvme: provide num dword helper
      nvme: remove unused parameter
      nvme: unlink head after removing last namespace
      nvme: release namespace head reference on error
      nvme: always search for namespace head
      nvme: check namespace head shared property
      nvme-multipath: set bdi capabilities once
      nvme: revalidate after verifying identifiers
      nvme: consolidate chunk_sectors settings
      nvme: revalidate namespace stream parameters
      nvme: consolodate io settings
      nvme: flush scan work on passthrough commands
      nvme-pci: remove volatile cqes
      nvme-pci: remove last_sq_tail
      nvme: define constants for identification values

Max Gurtovoy (1):
      nvmet-rdma: use SRQ per completion vector

Sagi Grimberg (3):
      nvme-tcp: use bh_lock in data_ready
      nvme-tcp: avoid scheduling io_work if we are already polling
      nvme-tcp: try to send request in queue_rq context

Weiping Zhang (1):
      nvme-pci: align io queue count with allocted nvme_queue in nvme_probe

 drivers/nvme/host/core.c           | 235 ++++++-----
 drivers/nvme/host/fc.c             | 571 ++++++++++++++++++++------
 drivers/nvme/host/fc.h             | 227 +++++++++++
 drivers/nvme/host/multipath.c      |  16 +-
 drivers/nvme/host/nvme.h           |  10 +-
 drivers/nvme/host/pci.c            |  89 ++--
 drivers/nvme/host/tcp.c            |  53 ++-
 drivers/nvme/target/admin-cmd.c    |   5 +
 drivers/nvme/target/configfs.c     | 184 ++++-----
 drivers/nvme/target/fc.c           | 805 +++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c       | 155 ++++++-
 drivers/nvme/target/io-cmd-bdev.c  |   5 +
 drivers/nvme/target/io-cmd-file.c  |  17 +-
 drivers/nvme/target/nvmet.h        |   2 +
 drivers/nvme/target/rdma.c         | 178 ++++++--
 drivers/scsi/lpfc/lpfc.h           |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   3 -
 drivers/scsi/lpfc/lpfc_crtn.h      |   9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c   |   5 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   8 +-
 drivers/scsi/lpfc/lpfc_init.c      |   7 +-
 drivers/scsi/lpfc/lpfc_mem.c       |   4 -
 drivers/scsi/lpfc/lpfc_nportdisc.c |  13 +-
 drivers/scsi/lpfc/lpfc_nvme.c      | 491 ++++++++++++++--------
 drivers/scsi/lpfc/lpfc_nvme.h      | 180 +++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 804 +++++++++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_nvmet.h     | 158 --------
 drivers/scsi/lpfc/lpfc_sli.c       | 126 +++++-
 include/linux/nvme-fc-driver.h     | 368 ++++++++++++-----
 include/linux/nvme-fc.h            |  11 +-
 include/linux/nvme.h               |   8 +
 32 files changed, 3297 insertions(+), 1453 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h
 delete mode 100644 drivers/scsi/lpfc/lpfc_nvmet.h

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
