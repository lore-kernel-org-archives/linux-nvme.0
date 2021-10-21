Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E13C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FA760F25
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71FA760F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+2QEXpAZsUx7TOL11cEn/BgB4monX6Fu2g7j5eJ7+m8=; b=TUR4M3JhCpeNTYWkElYFBzG2nA
	a4AAVnOm9Fxz8fNVfZNrPTfp36Z0FHxuOXf0eA/ctmllBdC8kRbeL3PGhpX/4eMHxEj0yB8IEPxyH
	n1+XpZPxa9yskh76Kq32xNVr6S8rTDdG1apEasFvjKHLvz1YD+9oGnDox2Rx5zfa3W5QyTEKboisV
	mGN9fd2veQBvC69XLg/ZoN7KBl6HMGjaZeTrcdx6kEnlIZ1t12s1XgXvROclXkecGzZFgxc6O+V9+
	dTH7ImYpTPafbYhRzRlHIlllmehp7EltjkxUga8JSZBF3K/5e2M8Mu2YmHRQ8p3iu1qyN6r6SfqFR
	X2gnDW1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdXbf-007ZuR-GJ; Thu, 21 Oct 2021 12:55:39 +0000
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdXbc-007ZuB-HF; Thu, 21 Oct 2021 12:55:36 +0000
Date: Thu, 21 Oct 2021 14:55:34 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.16
Message-ID: <YXFjRq8JzDdVXww/@infradead.org>
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

The following changes since commit a9a7e30fd918588bc312ba782426e3a1282df359:

  nvme: don't memset() the normal read/write command (2021-10-19 12:41:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-21

for you to fetch changes up to 117d5b6d00ee02f73d7065fe906e2ef1af74bb68:

  nvmet: use struct_size over open coded arithmetic (2021-10-20 19:23:30 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.16

 - fix a multipath partition scanning deadlock (Hannes Reinecke)
 - generate uevent once a multipath namespace is operational again
   (Hannes Reinecke)
 - support unique discovery controller NQNs (Hannes Reinecke)
 - fix use-after-free when a port is removed (Israel Rukshin)
 - clear shadow doorbell memory on resets (Keith Busch)
 - use struct_size (Len Baker)
 - add error handling support for add_disk (Luis Chamberlain)
 - limit the maximal queue size for RDMA controllers (Max Gurtovoy)
 - use a few more symbolic names (Max Gurtovoy)
 - fix error code in nvme_rdma_setup_ctrl (Max Gurtovoy)
 - add support for ->map_queues on FC (Saurav Kashyap)

----------------------------------------------------------------
Hannes Reinecke (9):
      nvme: generate uevent once a multipath namespace is operational again
      nvmet: make discovery NQN configurable
      nvme: add CNTRLTYPE definitions for 'identify controller'
      nvmet: add nvmet_is_disc_subsys() helper
      nvmet: set 'CNTRLTYPE' in the identify controller data
      nvme: expose subsystem type in sysfs attribute 'subsystype'
      nvme: Add connect option 'discovery'
      nvme: display correct subsystem NQN
      nvme: drop scan_lock and always kick requeue list when removing namespaces

Israel Rukshin (3):
      nvmet: fix use-after-free when a port is removed
      nvmet-rdma: fix use-after-free when a port is removed
      nvmet-tcp: fix use-after-free when a port is removed

Keith Busch (1):
      nvme-pci: clear shadow doorbell memory on resets

Len Baker (1):
      nvmet: use struct_size over open coded arithmetic

Luis Chamberlain (1):
      nvme-multipath: add error handling support for add_disk()

Max Gurtovoy (6):
      nvme-rdma: limit the maximal queue size for RDMA controllers
      nvmet: add get_max_queue_size op for controllers
      nvmet-rdma: implement get_max_queue_size controller op
      nvmet: use macro definition for setting nmic value
      nvmet: use macro definitions for setting cmic value
      nvme-rdma: fix error code in nvme_rdma_setup_ctrl

Saurav Kashyap (2):
      nvme-fc: add support for ->map_queues
      qla2xxx: add ->map_queues support for nvme

 drivers/nvme/host/core.c          | 36 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c       |  6 +++++-
 drivers/nvme/host/fabrics.h       |  8 ++++++++
 drivers/nvme/host/fc.c            | 26 ++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c     | 30 +++++++++++++++++++---------
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/pci.c           |  9 ++++++++-
 drivers/nvme/host/rdma.c          | 11 ++++++++++-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   | 16 ++++++++++-----
 drivers/nvme/target/configfs.c    | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 17 +++++++++-------
 drivers/nvme/target/discovery.c   |  2 ++
 drivers/nvme/target/fabrics-cmd.c |  3 ++-
 drivers/nvme/target/nvmet.h       |  6 ++++++
 drivers/nvme/target/rdma.c        | 30 ++++++++++++++++++++++++++++
 drivers/nvme/target/tcp.c         | 16 +++++++++++++++
 drivers/scsi/qla2xxx/qla_nvme.c   | 15 ++++++++++++++
 include/linux/nvme-fc-driver.h    |  7 +++++++
 include/linux/nvme-rdma.h         |  2 ++
 include/linux/nvme.h              | 11 ++++++++++-
 21 files changed, 266 insertions(+), 29 deletions(-)

