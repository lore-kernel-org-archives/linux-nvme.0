Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D12BC2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E35F600D1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E35F600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8VhMTCwBsFAe5UtEJRlrOKKFjPK8zqewvBc04jQ8SkU=; b=dN5WYvod1yuWkV
	0xJ+GK0dJPhnaFH+WNVjRBIJp0t1VS7fL98T7Ev5YRXsaGpYNU5yCKKR2RsvIbqOEy7m8g5PBOkjh
	qRLS31wHo7jswzAtvjh3g1r6OzOIgZlbMRLTJVZL/tofsjq/ghQFPhcXAlU+QVoX/aQ6wxDWw4aL/
	dCBaVbKA/kWjEOTW21v1ts+r3OskBZD0XBL/aSaiPqXQhZoLHv/Yj23lpdZylZSu40iDWVRLKMzzC
	uRxjn3gWA+Uu7j9KTBT58BH03TNwRQ/Nl843/W8Ebpr6iK5fVPqAcXQWtCV7oWNhbjsRYomGb1wqk
	vGRVZl4ckJ+SrlVGmTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvaVf-005wYL-JB; Tue, 22 Jun 2021 07:07:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvaVd-005wXW-4s
 for linux-nvme@bombadil.infradead.org; Tue, 22 Jun 2021 07:07:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=cPwsZUdKMdeYStCh+AYG64czcvnOgEFwbVdG8qC+jaQ=; b=AmBRRZCgUWeZYvRZpvJ9sUOF71
 LzEzBwK0OrhaAlMJi3XXK1VjnYsSRjdDDLBWUdL4r70lnRCmBPKdZyL6GfB25eCHxTIZQqLnZbIAP
 /T4T+/X1KKpn2jguwfH20IqMfk2/iNerAW22zGyCmqRqXnW3mgCO4Nd7EHmVD9dup2+FN9eNl2WoA
 iBkjEyxVFHgnNJOer6P4dslTuHiCix2IR1jtNwiGdv1sgpxUYNcuHClW7nECXHAgtmkOhUjUqgnwI
 0/N2HmUZwwmpGsLEgof4tdofxOpPdCeSXxml0PSU2Ebv3+cCpeAzpZPdrhW0eX3etYBa8GQaAb5iN
 TDfojqVg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvaV8-00DzYk-LC; Tue, 22 Jun 2021 07:07:22 +0000
Date: Tue, 22 Jun 2021 09:05:03 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.14
Message-ID: <YNGLn2MsJDwwbZbv@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit e0d245e2230998e66dfda10fb8c413f29196eb1c:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.14/drivers (2021-06-15 15:42:56 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-22

for you to fetch changes up to 3c3ee16532c1be92350a2a88bd19283b7bdf32e9:

  nvmet: use NVMET_MAX_NAMESPACES to set nn value (2021-06-21 08:34:10 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.14:

 - move the ACPI StorageD3 code to drivers/acpi/ and add quirks for
   certain AMD CPUs (Mario Limonciello)
 - zoned device support for nvmet (Chaitanya Kulkarni)
 - fix the rules for changing the serial number in nvmet (Noam Gottlieb)
 - various small fixes and cleanups (Dan Carpenter, JK Kim,
   Chaitanya Kulkarni, Hannes Reinecke, Wesley Sheng, Geert Uytterhoeven,
   Daniel Wagner)

----------------------------------------------------------------
Chaitanya Kulkarni (25):
      nvme: factor out a nvme_validate_passthru_nsid helper
      nvme-pci: remove trailing lines for helpers
      nvme: add a helper to check ctrl sgl support
      nvme-fc: use ctrl sgl check helper
      nvme-pci: use ctrl sgl check helper
      nvme-tcp: use ctrl sgl check helper
      nvme-fabrics: remove memset in nvmf_reg_read64()
      nvme-fabrics: remove memset in nvmf_reg_write32()
      nvme-fabrics: remove memset in connect admin q
      nvme-fabrics: remove memset in connect io q
      nvmet: use req->cmd directly in bdev-ns fast path
      nvmet: use req->cmd directly in file-ns fast path
      nvmet: use u32 for nvmet_subsys max_nsid
      nvmet: use u32 type for the local variable nsid
      nvmet: use nvme status value directly
      nvmet: remove local variable
      block: export blk_next_bio()
      nvmet: add req cns error complete helper
      nvmet: add nvmet_req_bio put helper for backends
      nvmet: add Command Set Identifier support
      nvmet: add ZBD over ZNS backend support
      nvmet: remove zeroout memset call for struct
      nvme-pci: remove zeroout memset call for struct
      nvme: remove zeroout memset call for struct
      nvmet: use NVMET_MAX_NAMESPACES to set nn value

Dan Carpenter (1):
      nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()

Daniel Wagner (2):
      nvme: verify MNAN value if ANA is enabled
      nvme: remove superfluous bio_set_dev in nvme_requeue_work

Geert Uytterhoeven (1):
      nvme: fix grammar in the CONFIG_NVME_MULTIPATH kconfig help text

Hannes Reinecke (1):
      nvmet-fc: do not check for invalid target port in nvmet_fc_handle_fcp_rqst()

JK Kim (1):
      nvme-pci: fix var. type for increasing cq_head

Mario Limonciello (2):
      ACPI: Check StorageD3Enable _DSD property in ACPI code
      ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint

Noam Gottlieb (4):
      nvmet: change sn size and check validity
      nvmet: make sn stable once connection was established
      nvmet: allow mn change if subsys not discovered
      nvmet: make ver stable once connection established

Wesley Sheng (1):
      nvme.h: add missing nvme_lba_range_type endianness annotations

 block/blk-lib.c                   |   1 +
 drivers/acpi/device_pm.c          |  32 ++
 drivers/acpi/internal.h           |   9 +
 drivers/acpi/x86/utils.c          |  25 ++
 drivers/nvme/host/Kconfig         |   2 +-
 drivers/nvme/host/core.c          |  19 +-
 drivers/nvme/host/fabrics.c       |  12 +-
 drivers/nvme/host/fc.c            |   2 +-
 drivers/nvme/host/ioctl.c         |  26 +-
 drivers/nvme/host/multipath.c     |  12 +-
 drivers/nvme/host/nvme.h          |   5 +
 drivers/nvme/host/pci.c           |  60 +---
 drivers/nvme/host/tcp.c           |   4 +-
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   | 155 +++++++---
 drivers/nvme/target/configfs.c    | 102 +++++--
 drivers/nvme/target/core.c        |  98 ++++--
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fc.c          |  10 +-
 drivers/nvme/target/io-cmd-bdev.c |  33 +-
 drivers/nvme/target/io-cmd-file.c |   4 +-
 drivers/nvme/target/nvmet.h       |  41 ++-
 drivers/nvme/target/passthru.c    |   3 +-
 drivers/nvme/target/rdma.c        |   3 +-
 drivers/nvme/target/zns.c         | 615 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h              |   5 +
 include/linux/bio.h               |   2 +
 include/linux/nvme.h              |  12 +-
 28 files changed, 1073 insertions(+), 228 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
