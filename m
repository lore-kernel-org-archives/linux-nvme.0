Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC5C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yjUpLu0+0UVRSuM7qoEkvVCRCkHDyvMSS8FiZ0/18pM=; b=H5Ertuz8BHJ74B7CI1A13/FtBc
	nSAZlK4GHpTlwxg/+z75HQPYSv5iFmUrMxttQ2khQMxGYRS7eFbppUMd/WTAsjYMQPm6R2lGjPSPy
	gq7QZTI+lBKRaNXOVWg5MdfrJlVqO3qj/SQjIFiVv3SiLRVu0jYPYPJv8B+k+qpx2iMeUhHyXTZ3B
	R1Q43B2Oa3J4hKTP461GxXqzt2Oc5Uh+ne9DgC/lubADgkMz/Aj+H8si4wkMaxs5HWrDNfM+vK50d
	6COi36EoEg51s8iO140psJ+WAygIuTG4E78jfdz10CZ9nU6prOuW8AMHsqh5i9D4B7DNKpr9JXMG1
	56iRqOAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olRNF-00CZwq-Ty; Thu, 20 Oct 2022 08:57:57 +0000
Received: from [88.128.92.117] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olRNB-00CZwN-K5; Thu, 20 Oct 2022 08:57:53 +0000
Date: Thu, 20 Oct 2022 10:57:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y1ENi1X5gi7yU9VS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit e0539ae012ba5d618eb19665ff990b87b960c643:

  Documentation: document ublk user recovery feature (2022-10-18 05:12:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-22

for you to fetch changes up to 94f5a06884074dcd99606d7b329e133ee65ea6ad:

  nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show (2022-10-19 12:43:13 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix nvme-hwmon for DMA non-cohehrent architectures (Serge Semin)
 - add a nvme-hwmong maintainer (Christoph Hellwig)
 - fix error pointer dereference in error handling (Dan Carpenter)
 - fix invalid memory reference in nvmet_subsys_attr_qid_max_show
   (Daniel Wagner)
 - don't limit the DMA segment size in nvme-apple (Russell King)
 - fix workqueue MEM_RECLAIM flushing dependency (Sagi Grimberg)
 - disable write zeroes on various Kingston SSDs (Xander Li)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: add Guenther as nvme-hwmon maintainer
      nvme-hwmon: consistently ignore errors from nvme_hwmon_init

Dan Carpenter (1):
      nvme: fix error pointer dereference in error handling

Daniel Wagner (1):
      nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

Russell King (Oracle) (1):
      nvme-apple: don't limit DMA segement size

Sagi Grimberg (1):
      nvmet: fix workqueue MEM_RECLAIM flushing dependency

Serge Semin (1):
      nvme-hwmon: kmalloc the NVME SMART log buffer

Xander Li (1):
      nvme-pci: disable write zeroes on various Kingston SSD

 MAINTAINERS                    |  6 ++++++
 drivers/nvme/host/apple.c      |  2 ++
 drivers/nvme/host/core.c       |  8 ++++++--
 drivers/nvme/host/hwmon.c      | 32 ++++++++++++++++++++++----------
 drivers/nvme/host/pci.c        | 10 ++++++++++
 drivers/nvme/target/configfs.c |  4 ----
 drivers/nvme/target/core.c     |  2 +-
 7 files changed, 47 insertions(+), 17 deletions(-)

