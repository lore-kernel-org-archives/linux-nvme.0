Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D7D462AF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uwT6nkZjwIpGshBhUaKNehYWx8TBOAogouAUNOMchJM=; b=whfvikM7XFWF5m
	LDVGdo6K3e9IHhtTmsK8+T6l+Op9vubSsieLwIKXp5IG9tYZnCKp39KWXzPOLKcU2+3iVyp283JMr
	KqiMN09FchpDgptPFQ1NiSUOfgp9r1y8fM6Zrn/aVGraP503uE3bahHXsvI+dAI0xJKEc5VBqIxD1
	geyxIIViD0lcftLVIQtCJ9wkMUtPFvDc9TYos8wAkScrqIkDA5tfnyZOiJwQXYrNujLSPNwyGRBLD
	47NEq4AK7ntFbn5/pVWAjrfz9Q0IMwqVoXr7yKx21SCzm5mhd8ymv9c0sidCdm7da2Jw9NB/p3FaI
	1f4/YimDw17E9yocC2Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKH-000000077mK-2eSW;
	Wed, 13 Nov 2024 14:26:33 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKE-000000077kI-1lFU
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 993E8A40CDE;
	Wed, 13 Nov 2024 14:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D79C4CEC3;
	Wed, 13 Nov 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507988;
	bh=RFhf0AIU0UyV1N0p1944L0iQyMfKegxpNmUNuOgkCKM=;
	h=From:Subject:Date:To:Cc:From;
	b=kBcNMhmF7ksOEXsMmUn7bkRMEd9j4n6SCxjSiOdWYkMKMrKglx3FILQ5MdLgAA74z
	 J2ia7trKJ2gRipRy4CT1he+z3EyIYdCpq4/6K3NWcqycfNAiGJ+td7L3MvF26beN9L
	 jq+P1GTq7idkarlTHF8v9w/Dk4f3UZ3mullsDqvigObweUBmn/pqwrQCgw1mhz0kpB
	 0jhO/oCY/IVLhKq4BNYHD19Rqs5lWvSDvfY+HRit1fB7RnnT4moMY7k1iYSaJ6bO/P
	 GFjYWaKgrdOW6cjN5EaPFDHQCGjkzSHbc5vBXfvuIT86120oODTeSa+gXiE+n9WWqJ
	 BF1fXQZH/lgnQ==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v4 00/10] blk: refactor queue affinity helpers
Date: Wed, 13 Nov 2024 15:26:14 +0100
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAa3NGcC/4XQyw6CMBAF0F8hXVvTBwi44j+Mi5ZOoZEAttBoD
 P/uqPG1YnZ30pw76Y0E8A4C2Sc34iG64IYeQ7pJSN2qvgHqDGYimEhZyQX1YFU9DZ7q7kSVta5
 305W20I3gA81ZUeoy06nmjKAx4nN3efqH4yt7OM9YM32XrQsIXp83RP7YvuvkSl3klNECWFbYP
 FeWiyrMAbYGyMON4mNxnDVLoGXljhmjjJBcVSfwPXTbwTcvTv5yaz8RJXJZLrWtFau1Kf64ZVn
 uTovUp3sBAAA=
X-Change-ID: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062630_623291_397ADF2F 
X-CRM114-Status: GOOD (  13.00  )
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

Baes on Johns' idea, I added another irq_get_affinity callback to struct
device_driver and made blk_mq_hctx_map_queues to try that one first. With
this I could also replace the open coded queue mapping in hisi_sas v2.

Besides this change I fixed couple of typos and also addressed John
feedback in hisi_sas v3.

Original cover letter:

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v4:
- added irq_get_affinity callback to struct device_driver
- hisi_sas use dev pointer directly from hisi_hba.
- blk_mq_hctx_map_queues: ty irq_get_affinity callback
  from device_driver first then from bus_type
- collected tags
- fixed typos
- Link to v3: https://lore.kernel.org/r/20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org

Changes in v3:
- dropped the additinal argument in blk_mq_hctx_map_queues.
  leave open coded version in hisi_sas_v2.
- splitted "blk-mp: introduce blk_mq_hctx_map_queues" patch into
  three patches.
- dropped local variable in pci_device_irq_get_affinity
- Link to v2: https://lore.kernel.org/r/20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org

Changes in v2:
- added new callback to struct bus_type and call directly the affinity
  helpers from there.
- Link to v1: https://lore.kernel.org/r/20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de

Changes in v1:
- renamed blk_mq_dev_map_queues to blk_mq_hctx_map_queues
- squased 'virito: add APIs for retrieving vq affinity' into
  'blk-mq: introduce blk_mq_hctx_map_queues'
- moved hisi_sas changed into a new patch
- hisi_sas use define instead of hard coded value
- moved helpers into their matching subsystem, removed
  blk-mq-pci and blk-mq-virtio files
- fix spelling/typos
- fixed long lines in docu (yep new lines in brief descriptions are
  supported, tested ti)
- based on the first part of
  [1] https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

---
Daniel Wagner (10):
      driver core: bus: add irq_get_affinity callback to bus_type
      driver core: add irq_get_affinity callback device_driver
      PCI: hookup irq_get_affinity callback
      virtio: hookup irq_get_affinity callback
      blk-mq: introduce blk_mq_hctx_map_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      scsi: hisi_sas: use blk_mq_hctx_map_queues to map queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
      blk-mq: remove unused queue mapping helpers

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 43 +++++++++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  3 +-
 drivers/pci/pci-driver.c                  | 14 ++++++++++
 drivers/scsi/fnic/fnic_main.c             |  3 +-
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 22 +++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +-
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  3 +-
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  3 +-
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  7 ++---
 drivers/scsi/virtio_scsi.c                |  3 +-
 drivers/virtio/virtio.c                   | 19 +++++++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  2 ++
 include/linux/device/bus.h                |  3 ++
 include/linux/device/driver.h             |  3 ++
 28 files changed, 112 insertions(+), 155 deletions(-)
---
base-commit: c9af98a7e8af266bae73e9d662b8341da1ec5824
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


