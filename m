Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01297C71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FycgTHINtYVyAsv+Skht1iS2gtng65ftxA5IxcZoiFY=; b=W3buxOQzcrS2Dk
	o+zplZywaqOFN9PI4/q2xDhQUFqsvzZL/J/Vj3jQUBOUzC+vilrr0VA4XMaxvJjXCC9sTX4VVMW8m
	bJe8VQHTTP+PyOc93K6yKcrNrdwj0nF3jCgdWDKCRyPdgMwZHCj7Gv5aqL6ZSDUyOKo/dqnBP2sKc
	7UaofQb1UWGY4E7kKMSues0iVDgCWAHl+T0cuCdcfOVxTnI96+kY60Rx6y42/tIphgRAYfTof6fI1
	IBH/Qw4FweuwB47ulJV2reHEaLcAgOhULgYHemNHNFZ5voO6c0G8FL/Rb+GiXZ8VJFjecOaUu3n4V
	Ikj7n2pyVlHP1MEcNTNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRWvY-00000007TGK-1NHU;
	Tue, 17 Jun 2025 14:04:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRWb5-00000007OeS-1vBA
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 13:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 29C065C675D;
	Tue, 17 Jun 2025 13:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E8C4CEE3;
	Tue, 17 Jun 2025 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750167809;
	bh=Tq5rUOpjXriBkipN8jcjoOeGSv4ICYoTA0fxuVN9H94=;
	h=From:Subject:Date:To:Cc:From;
	b=H2VMXZuyU6kbuxsnxDZ0TmEkSbKr3URfhjt3ZDdyNXdL6ivkgmgNDPNrOX9KpE8un
	 67xPRwP+Ax/wzJc2Ag4PN0uQU0cP705b5qy8C4qngTFaBEQa1rH+Kzsv8IM6Vn+LEz
	 8CSQ9N0XBnKfvE5wmCJA7G0B8JA8f1RlR0EFVTmL5PUsJkpbPJXpnRcihFHL4WjTOf
	 sh6EN8lf7ZZku7gd9SslC/G2sikDNq5IMhqoNJJBKGmx43LT1noz6/VO4ojstrL4Vc
	 y/uoWybaf86e/LHNiEjgDrNXwLqD6NK2POmZIlEW+001ads1kk7oiwhiuB9jH9oZFZ
	 SdYtNHiRhxS/Q==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/5] blk: introduce block layer helpers to calculate num of
 queues
Date: Tue, 17 Jun 2025 15:43:22 +0200
Message-Id: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpwUWgC/x3MQQrCMBBG4auUWTuQxGpor1Jc1PirA5KkmUaE0
 rs3uPwW722kKAKlsduo4CsqKTbYU0fhPccXWB7N5Iy7mKv1LJo+IVflpaKCQ6pxRVHu3X02gPf
 nwVCrc8FTfv/zdNv3A/LaqlZpAAAA
X-Change-ID: 20250617-isolcpus-queue-counters-42ba0ee77390
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_064331_583368_3CE6E22D 
X-CRM114-Status: GOOD (  13.39  )
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

I am still working on the change request for the "blk: honor isolcpus
configuration" series [1]. Teaching group_cpus_evenly to use the
housekeeping mask depending on the context is not a trivial change.

The first part of the series has already been reviewed and doesn't
contain any controversial changes, so let's get them processed
independely.

[1] https://patch.msgid.link/20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in from https://patch.msgid.link/20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org
- limit number of allocated masks to the max allocated number of masks
- commit message improvements
- typo fixes
- formatting fixed
- collected tags

---
Daniel Wagner (5):
      lib/group_cpus: Let group_cpu_evenly() return the number of initialized masks
      blk-mq: add number of queue calc helper
      nvme-pci: use block layer helpers to calculate num of queues
      scsi: use block layer helpers to calculate num of queues
      virtio: blk/scsi: use block layer helpers to calculate num of queues

 block/blk-mq-cpumap.c                     | 46 +++++++++++++++++++++++++++++--
 drivers/block/virtio_blk.c                |  5 ++--
 drivers/nvme/host/pci.c                   |  5 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 ++++++----
 drivers/scsi/qla2xxx/qla_isr.c            | 10 +++----
 drivers/scsi/smartpqi/smartpqi_init.c     |  5 ++--
 drivers/scsi/virtio_scsi.c                |  1 +
 drivers/virtio/virtio_vdpa.c              |  9 +++---
 fs/fuse/virtio_fs.c                       |  6 ++--
 include/linux/blk-mq.h                    |  2 ++
 include/linux/group_cpus.h                |  2 +-
 kernel/irq/affinity.c                     | 11 ++++----
 lib/group_cpus.c                          | 16 +++++------
 13 files changed, 89 insertions(+), 44 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250617-isolcpus-queue-counters-42ba0ee77390

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


