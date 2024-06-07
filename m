Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B14C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 05:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hJg1IHT6ctz5VzmbhBIsMLqfKq0fiJuOtJ2q4VPULPg=; b=XIUABpw//Pmpy2yLaqtw9+9e0F
	A90T/xUw4hMOMA49+IFCIwn2qKS0zT5X9tPOHpBl+wiC2y4z+haoliqF1Rl7s7koppq6Tn/dxmP12
	kS+cw8IHetuw456e9/UKW+MFXyFeU/Y/2jBwWpcK8zidL/CqQOHSwMhaiwhY/q/u1hZuD1h7OOjy2
	su22hH2sNvuRU7V8+IJF/nxgJmPOu94sVtJcFRE0iQdGZOLr4p5GJHx56CcoAexN5CKOzhj6bCNX7
	P2FzYsxWQzzsommtKGIG2Ebjat4FSEPK1sINnNa2RXFamLFpoWnu2j7+aQDF+4CUVqEHXmAF0RS/U
	kfOWBNbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdK-0000000CZys-4AAQ;
	Fri, 07 Jun 2024 05:59:26 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSd9-0000000CZy7-13zQ;
	Fri, 07 Jun 2024 05:59:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: move integrity settings to queue_limits v2
Date: Fri,  7 Jun 2024 07:58:54 +0200
Message-ID: <20240607055912.3586772-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
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

Hi Jens, hi Martin,

this series converts the blk-integrity settings to sit in the queue
limits and be updated through the atomic queue limits API.

I've mostly tested this with nvme, scsi is only covered by simple
scsi_debug based tests.

For MD I found an pre-existing error handling bug when combining PI
capable devices with not PI capable devices.  The fix was posted here
(and is included in the git branch below):

   https://lore.kernel.org/linux-raid/20240604172607.3185916-1-hch@lst.de/

For dm-integrity my testing showed that even the baseline fails to create
the luks-based dm-crypto with dm-integrity backing for the authentication
data.  As the failure is non-fatal I've not addressed it here.

Note that the support for native metadata in dm-crypt by Mikulas will
need a rebase on top of this, but as it already requires another
block layer patch and the changes in this series will simplify it a bit
I hope that is ok.

The series is based on top of my previously sent "convert the SCSI ULDs
to the atomic queue limits API v2" API.

A git tree is available here:

   git://git.infradead.org/users/hch/block.git block-integrity-limits

Gitweb:

   http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/block-integrity-limits

Changes since v1:
 - keep generating (empty) non-PI metadata
 - use a packed enum for the csum type
 - remove an unused flag left in the code

Diffstat:
 Documentation/block/data-integrity.rst |   49 ------
 block/Kconfig                          |    8 -
 block/Makefile                         |    3 
 block/bio-integrity.c                  |   33 +---
 block/blk-integrity.c                  |  229 ++++++++----------------------
 block/blk-mq.c                         |   13 -
 block/blk-settings.c                   |  118 ++++++++++++++-
 block/blk.h                            |    8 +
 block/t10-pi.c                         |  249 +++++++++++----------------------
 drivers/md/dm-core.h                   |    1 
 drivers/md/dm-crypt.c                  |    4 
 drivers/md/dm-integrity.c              |   47 +-----
 drivers/md/dm-table.c                  |  161 +++------------------
 drivers/md/md.c                        |   72 ++-------
 drivers/md/md.h                        |    5 
 drivers/md/raid0.c                     |    7 
 drivers/md/raid1.c                     |   10 -
 drivers/md/raid10.c                    |   10 -
 drivers/md/raid5.c                     |    2 
 drivers/nvdimm/btt.c                   |   13 -
 drivers/nvme/host/Kconfig              |    1 
 drivers/nvme/host/core.c               |   71 ++++-----
 drivers/nvme/host/multipath.c          |    3 
 drivers/nvme/target/Kconfig            |    1 
 drivers/nvme/target/io-cmd-bdev.c      |   16 +-
 drivers/scsi/Kconfig                   |    1 
 drivers/scsi/sd.c                      |   28 +--
 drivers/scsi/sd.h                      |   12 -
 drivers/scsi/sd_dif.c                  |   45 ++---
 drivers/target/target_core_iblock.c    |   49 +++---
 include/linux/bio.h                    |    7 
 include/linux/blk-integrity.h          |   62 ++------
 include/linux/blkdev.h                 |   26 ++-
 include/linux/t10-pi.h                 |   20 --
 34 files changed, 523 insertions(+), 861 deletions(-)

