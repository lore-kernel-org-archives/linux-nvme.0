Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525DC33C8C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727352072E
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r7+lwUr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727352072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LKA2G4oSPXA4wUqH/IJWVfdVDIAmo2FG0KeQKG9nhpA=; b=r7+lwUr6x0GkQx
	oLYbfyTbI96qfeAvJjS8sk0wv89e5/0F5T7CGQnRLFQ3udJ+oXDiBHdEYtOZFDpBWNCHnbYDmvfL0
	OdGUQIMyTBSs9wJduRCM8cnMZeEF6XLlzTABBB7GA94DuO7nk3i6zwu4VvDrS+PLSciZDWur1IMmS
	mz5COxze7Au6I/hGBfWYRTZK/p+N+PySjHV45ftNDGQb3aP81ZbIgs2S19Bhsa6dVjeTiXVyPuYAI
	wwLvMAOAonKfgA+4pCU2lYluytaOQD4PwL5At0UG7aYvSQWsdAv/YIgZzEEnLtvGpQi6uA8ikqeW7
	80QSjXBo+UNrOpqOOAlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioScR-0000bt-70; Mon, 06 Jan 2020 13:40:31 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioSZp-0005aJ-KE
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 13:37:56 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 6 Jan 2020 15:37:36 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 006DbaFA029740;
 Mon, 6 Jan 2020 15:37:36 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 00/15 V3] nvme-rdma/nvmet-rdma: Add metadata/T10-PI support
Date: Mon,  6 Jan 2020 15:37:20 +0200
Message-Id: <20200106133736.123038-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_053750_124553_AC796517 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello Sagi, Christoph, Keith, Martin and Co

This patchset adds metadata (T10-PI) support for NVMeoF/RDMA host side and
target side, using signature verbs API. This set starts with a few preparation
commits to the NVMe host core layer. It continues with NVMeoF/RDMA host
implementation + few preparation commits to the NVMe target core layer.
The patchset ends with NVMeoF/RDMA target implementation.

Configuration:
Host:
 - nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme

Target:
 - echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
 - echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable

The code was tested using Mellanox's ConnectX-4/ConnectX-5 HCAs.
This series applies on top of nvme_5.5 branch cleanly.

Changes from v2:
 - Convert the virtual start sector (which passed to bip_set_seed function)
   to be in integrity interval units (Patch 14/15)
 - Clarify some commit messages

Changes from v1:
 - Added Reviewed-by signatures
 - Added namespace features flag (Patch 01/15)
 - Remove nvme_ns_has_pi function (Patch 01/15)
 - Added has_pi field to struct nvme_request (Patch 01/15)
 - Subject change for patch 02/15
 - Fix comment for PCI metadata (Patch 03/15)
 - Rebase over "nvme: Avoid preallocating big SGL for data" patchset
 - Introduce NVME_INLINE_PROT_SG_CNT flag (Patch 05/15)
 - Introduce nvme_rdma_sgl structure (Patch 06/15)
 - Remove first_sgl pointer from struct nvme_rdma_request (Patch 06/15)
 - Split nvme-rdma patches (Patches 06/15, 07/15)
 - Rename is_protected to use_pi (Patch 07/15)
 - Refactor nvme_rdma_get_max_fr_pages function (Patch 07/15)
 - Added ifdef CONFIG_BLK_DEV_INTEGRITY (Patches 07/15, 09/15, 13/15,
   14/15, 15/15)
 - Added port configfs pi_enable (Patch 14/15)

Israel Rukshin (12):
  nvme: Introduce namespace features flag
  nvme-fabrics: Allow user enabling metadata/T10-PI support
  nvme: Introduce NVME_INLINE_PROT_SG_CNT
  nvme-rdma: Introduce nvme_rdma_sgl structure
  nvmet: Prepare metadata request
  nvmet: Add metadata characteristics for a namespace
  nvmet: Rename nvmet_rw_len to nvmet_rw_data_len
  nvmet: Rename nvmet_check_data_len to nvmet_check_transfer_len
  nvme: Add Metadata Capabilities enumerations
  nvmet: Add metadata/T10-PI support
  nvmet: Add metadata support for block devices
  nvmet-rdma: Add metadata/T10-PI support

Max Gurtovoy (3):
  nvme: Enforce extended LBA format for fabrics metadata
  nvme: Introduce max_integrity_segments ctrl attribute
  nvme-rdma: Add metadata/T10-PI support

 drivers/nvme/host/core.c          |  75 +++++---
 drivers/nvme/host/fabrics.c       |  11 ++
 drivers/nvme/host/fabrics.h       |   3 +
 drivers/nvme/host/nvme.h          |   9 +-
 drivers/nvme/host/pci.c           |   7 +
 drivers/nvme/host/rdma.c          | 368 +++++++++++++++++++++++++++++++++-----
 drivers/nvme/target/admin-cmd.c   |  37 ++--
 drivers/nvme/target/configfs.c    |  61 +++++++
 drivers/nvme/target/core.c        |  54 ++++--
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fabrics-cmd.c |  19 +-
 drivers/nvme/target/io-cmd-bdev.c | 115 +++++++++++-
 drivers/nvme/target/io-cmd-file.c |   8 +-
 drivers/nvme/target/nvmet.h       |  40 ++++-
 drivers/nvme/target/rdma.c        | 235 ++++++++++++++++++++++--
 include/linux/nvme.h              |   2 +
 16 files changed, 925 insertions(+), 127 deletions(-)

-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
