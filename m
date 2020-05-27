Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 05:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD98520776
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 05:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUdlVIDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD98520776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l5Q4JXcnRGicFKeGp4uR2+yJpcMTA3gU9BA30QYMMw4=; b=LUdlVIDghzNEOu
	3jR5/NjHrTVT/d/D/ATEYtZ1FQx20gMPxi7yk3wFjpReyHxWLLnip6CD85QrMFkFzkBC7tsZWVAb3
	HJPpbl8RSxZ1eLRvmZd6pqirW7y/RE27UJTELbjQPIRSqJzGXhu30nTnKkwH4kdqkCtPQb3r8657G
	AiqqNUUK0Ge6UoJD9eyfe0VHmj2YV8Y8D4oqUz0Z9P/z5irLKv/eHyqMFP4A6NpgkCy5WqVqvuFNH
	VHScPCFK6aDpYyWMMLVOdizLl1lgeJkXYUGJ+x5TsrrPMX4zt2EUXYNPT1SextpJqgYjdOFEqjvgI
	Ncgf1D0DDyjI/SmlxQ2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoUd-0000EZ-Qr; Wed, 27 May 2020 05:20:43 +0000
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdoUb-0000EN-OY; Wed, 27 May 2020 05:20:42 +0000
Date: Wed, 27 May 2020 07:20:38 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] nvme updates for 5.8
Message-ID: <20200527052038.GA403423@infradead.org>
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
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The second large batch of nvme updates:

 - t10 protection information support for nvme-rdma and nvmet-rdma
   (Israel Rukshin and Max Gurtovoy)
 - target side AEN improvements (Chaitanya Kulkarni)
 - various fixes and minor improvements all over, icluding the nvme part
   of the lpfc driver

The following changes since commit 263c61581a38d0a5ad1f5f4a9143b27d68caeffd:

  block/floppy: fix contended case in floppy_queue_rq() (2020-05-26 15:23:54 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 6b6e89636f51581895922780c3c4fd51bb9e1483:

  lpfc: Fix return value in __lpfc_nvme_ls_abort (2020-05-27 07:12:41 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (4):
      nvmet: add async event tracing support
      nvmet: add helper to revalidate bdev and file ns
      nvmet: generate AEN for ns revalidate size change
      nvmet: revalidate-ns & generate AEN from configfs

Chen Zhou (1):
      nvmet: replace kstrndup() with kmemdup_nul()

Christoph Hellwig (1):
      nvmet: mark nvmet_ana_state static

Damien Le Moal (1):
      nvme: fix io_opt limit setting

Dan Carpenter (1):
      nvme: delete an unnecessary declaration

David Milburn (1):
      nvmet: cleanups the loop in nvmet_async_events_process

Gustavo A. R. Silva (1):
      nvme: replace zero-length array with flexible-array

Israel Rukshin (9):
      nvme: introduce NVME_INLINE_METADATA_SG_CNT
      nvme-rdma: introduce nvme_rdma_sgl structure
      nvmet: add metadata characteristics for a namespace
      nvmet: rename nvmet_rw_len to nvmet_rw_data_len
      nvmet: rename nvmet_check_data_len to nvmet_check_transfer_len
      nvme: add Metadata Capabilities enumerations
      nvmet: add metadata/T10-PI support
      nvmet: add metadata support for block devices
      nvmet-rdma: add metadata/T10-PI support

James Smart (4):
      nvme: make nvme_ns_has_pi accessible to transports
      lpfc: Fix pointer checks and comments in LS receive refactoring
      lpfc: fix axchg pointer reference after free and double frees
      lpfc: Fix return value in __lpfc_nvme_ls_abort

Keith Busch (1):
      nvme: set dma alignment to qword

Martin George (1):
      nvme-fc: print proper nvme-fc devloss_tmo value

Max Gurtovoy (6):
      block: always define struct blk_integrity in genhd.h
      nvme: introduce namespace features flag
      nvme: introduce NVME_NS_METADATA_SUPPORTED flag
      nvme: introduce max_integrity_segments ctrl attribute
      nvme: enforce extended LBA format for fabrics metadata
      nvme-rdma: add metadata/T10-PI support

Sagi Grimberg (5):
      nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_EOR if we send last payload in the batch
      nvmet-tcp: move send/recv error handling in the send/recv methods instead of call-sites
      nvmet: fix memory leak when removing namespaces and controllers concurrently

Weiping Zhang (1):
      nvme-pci: make sure write/poll_queues less or equal then cpu count

Wu Bo (1):
      nvme: disable streams when get stream params failed

 drivers/nvme/host/core.c          |  97 ++++++++----
 drivers/nvme/host/fc.c            |   6 +-
 drivers/nvme/host/lightnvm.c      |   7 +-
 drivers/nvme/host/nvme.h          |  18 ++-
 drivers/nvme/host/pci.c           |  28 +++-
 drivers/nvme/host/rdma.c          | 321 ++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/tcp.c           |  11 +-
 drivers/nvme/target/Kconfig       |   1 +
 drivers/nvme/target/admin-cmd.c   |  45 ++++--
 drivers/nvme/target/configfs.c    |  90 ++++++++++-
 drivers/nvme/target/core.c        | 166 ++++++++++++++------
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fabrics-cmd.c |  15 +-
 drivers/nvme/target/io-cmd-bdev.c | 113 +++++++++++++-
 drivers/nvme/target/io-cmd-file.c |   6 +-
 drivers/nvme/target/nvmet.h       |  34 +++-
 drivers/nvme/target/rdma.c        | 238 +++++++++++++++++++++++++---
 drivers/nvme/target/tcp.c         |  53 ++++---
 drivers/nvme/target/trace.h       |  28 ++++
 drivers/scsi/lpfc/lpfc_nvme.c     |   2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c    |  29 ++--
 drivers/scsi/lpfc/lpfc_sli.c      |  10 +-
 include/linux/genhd.h             |   4 -
 include/linux/nvme.h              |   8 +-
 24 files changed, 1116 insertions(+), 222 deletions(-)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
