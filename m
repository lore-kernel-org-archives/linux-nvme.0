Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D50FD3ABDA
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vwn/1JQN37BK4g94WAU/zYR0I8/0m6k+5EpWg8/xihk=; b=F9Oo67Boc0cjQY
	RTvQjAN7d9fqvLW8sJx/qEkcaNqGLcQw1OkvEfZlwSig2rNJ1xGYUpypaBTChK1nMR9OhlZpIJhwk
	v6Y3lLAhKDog/xNnB2Vu1bjr3u3xzkVAfzD6ykpFN+RaU4RoqOfLTA6UtsRceSVBENpOfIO0BYkNn
	W6JQAQaQS2zrch2GByg6LehBu8iZv8R+eQGDB1aXFiesibolf5il47Y9P1iyXNxydHAz1yEENyqF2
	KdG2qC+pV0XzOROhSLpN3jEPE0LkrKxTvsOi/uVGJaQHfKnM3FMgdNL0GZtp2V3rSv/Ag/zWS/HZB
	PDaHSkFhHCjkvMMxXJPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYoX-00000000pmL-2yXD;
	Mon, 11 Nov 2024 18:07:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkI-00000000oe4-1c9G
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 18:02:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 64904A417F9;
	Mon, 11 Nov 2024 18:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1683EC4CED4;
	Mon, 11 Nov 2024 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348156;
	bh=xxm6F3WGpyk3HJ+Nw0RIX0xxEpe7bahxx6eBcWwy7FY=;
	h=From:Subject:Date:To:Cc:From;
	b=E8ml36PsPE+X1uPSnm0CcJubv3HROgtHQKJsm+nFeo4G08Qba2KOJXkGROkodttBC
	 gnwAU51XQuRpsozwBOaHoIyKOAsPJyEtTXVas0pUgeB9in5g8t0qEJy7C+RSkAjcvT
	 ExOM1HefKsb7EUdd1XiOZ+jLjpN/R2OBzBVlkgICFxSt/WBmZU/xiXWJmbSGF2beqY
	 rcmy6gY//9F9/HJCys70CuOTRbL1/3M/y5XZSOdx3CgJaZGSNc10FGGtbTVlBnLYIw
	 GIgttWp5WBshPr7SGGwj5Z56iWgL1paohNwm79225I8cz6wp2dmPYNt2JvxUFNRF8K
	 cViRi2t4JrjPg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/6] blk: refactor queue affinity helpers
Date: Mon, 11 Nov 2024 19:02:08 +0100
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBGMmcC/4WOQQ6CMBBFr0Jm7Zi2QgBX3sOwaGEqEwlgW4iEc
 Hcrxrh0+X4m780KnhyTh3OygqOZPQ99BHVIoG51fyPkJjIooVJRSoWOrK7D4NB0d9TWcs9hwZa
 6kZzHXBSlKTOTGikgOsZ4zs/df60+7OgxxUz4jS37KFz2H2b5Xr+505/cLFFgQSIrbJ5rK9XFT
 56ODUG1bdsLceXxJt0AAAA=
X-Change-ID: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_100238_596085_F39ECEED 
X-CRM114-Status: GOOD (  13.51  )
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

As Christoph suggested, I introduced a new callback to struct bus_type
and hooked up the callbacks directly in virtio and pci subsystem. This
looks pretty neat!

I've decided to provide only one version of blk_mq_hctx_map_queues but
with an additional argument to pass in a driver specific callback.

Currently, there is only one user of this additional callback. Maybe it
would be better to provide an variant of blk_mq_hctx_map_queues for the
additional argument. Not sure though. Thoughts?

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
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
  https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

---
Daniel Wagner (6):
      blk-mq: introduce blk_mq_hctx_map_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      scsi: hisi_sas: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
      blk-mq: remove unused queue mapping helpers

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 40 +++++++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  3 +-
 drivers/pci/pci-driver.c                  | 16 +++++++++++
 drivers/scsi/fnic/fnic_main.c             |  3 +-
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 22 +++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +-
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  4 +--
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  4 +--
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  7 ++---
 drivers/scsi/virtio_scsi.c                |  3 +-
 drivers/virtio/virtio.c                   | 12 ++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  5 ++++
 include/linux/device/bus.h                |  3 ++
 27 files changed, 107 insertions(+), 155 deletions(-)
---
base-commit: c9af98a7e8af266bae73e9d662b8341da1ec5824
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


