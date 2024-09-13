Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9571CFA3723
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8al1aKshZXM/ap5AqW/w9WJ//+RM7rrRIU1vsdyXi/o=; b=bjS9YYnaDJx+cy
	yullph3gXrHRXIMuiFoXSAhw6DQzCTmN3yWDVNk056W/d+gO8Xn1k8tRPfCcryCe4zZGhHXXD4sYl
	XO35k69aHUC/gVXYChShB85JZn+295k04QvCCcTYT78WHYVi4IZDWwgsBog8wXwJhF8HcofiI3X/r
	+YLGHh+XncJEFNSJcKw2CiY8ygtNshuZfLqCmQ+i4jXB9sGyTKBsIK6uayOOGYb+VE3UUmgJc2PBw
	xP0/XtxIT4APqSNgbVBi1DDGwJA2n01hGA+QUi9sP6UQJw82mcuPJfjq65fvm3FV545NycHWqmodI
	QzDgUtfi70poWw/qUhNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0ww-0000000FBYk-1Ngs;
	Fri, 13 Sep 2024 07:42:38 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0ws-0000000FBVF-0IKe
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:42:35 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DE5FDACDF;
	Fri, 13 Sep 2024 09:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8al1aKshZXM/ap5AqW/w9WJ//+RM7rrRIU1vsdyXi/o=;
	b=ImwkuKFBRWdjpVxXJShrOW/l2J+O4avGesFuvBBoRUmUggXEHjYcO94uFk8LUQZfvk7ZEK
	fZtXT/1VFOzQcd0gn28Xh1r6EmGDvZIr60i6eclc/s8vLA9WIgMKdgKDqQBXdxmQM85SS8
	LjdrbDnYM+TszCtOKzqKXrmZLxPOGAJkgapJRMu8kgf5oF964xIcHEyB9TZLpiEdBZ/g2X
	wTGChrlIAiwJ5VEmx3h0JEbe79HfHtpNjVoB5e97sVcm7c9Iw3nnXxJ1tBeAmS7YKINfP6
	KrirOua2Yfs042xmKCm48F3OBTf2eElm2nMOu3Y2vp0EW/uvp2sqGmWddfffUg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/6] EDITME: blk: refactor queue affinity helpers
Date: Fri, 13 Sep 2024 09:41:58 +0200
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMbs42YC/z2NQW7DIBBFr2Kx7lRAbROy6j2qLAYYJ6PGQIC4r
 aLcvTSRunxfX+/dRKXCVMV+uIlCG1dOsYN6GYQ/YTwScOgstNSjtEpDoQV9SwXc+RNwWThy+4E
 TnTOVCkburLOTG52Sojtyv/P3w/9xeHKhy7Vn2nMUK9WKj8x++I+EBDE1SBuVr9KvkD3DijlzP
 MKmQMFuMnp0syc/2vd6rfQa6C/osBL4tK7cum8mZY0zi+1eHNG/SRWCxDBp6aWfrfGa0ARxuN9
 /AV2d8PgKAQAA
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
 Daniel Wagner <dwagner@suse.de>, 
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de, 
 Ming Lei <ming.lei@redhat.com>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_004234_413746_BA8607D5 
X-CRM114-Status: GOOD (  11.78  )
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

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

One thing which I am a bit unsure are the CONFIG bits. I've reused the
BLK_MQ_PCI and BLK_MQ_VIRTIO as guard for the new helpers but it looks a
bit off.

changes:
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

[1] https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Daniel Wagner (5):
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      scsi: hisi_sas: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
      blk-mq: remove unused queue mapping helpers

Ming Lei (1):
      blk-mq: introduce blk_mq_hctx_map_queues

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 35 +++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  4 +--
 drivers/pci/pci.c                         | 20 ++++++++++++++
 drivers/scsi/fnic/fnic_main.c             |  4 +--
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 20 +++++++-------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  5 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c |  4 +--
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  4 +--
 drivers/scsi/pm8001/pm8001_init.c         |  3 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  4 +--
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  8 +++---
 drivers/scsi/virtio_scsi.c                |  4 +--
 drivers/virtio/virtio.c                   | 31 +++++++++++++++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  5 ++++
 include/linux/pci.h                       | 11 ++++++++
 include/linux/virtio.h                    | 13 +++++++++
 28 files changed, 152 insertions(+), 154 deletions(-)
---
base-commit: 26e197b7f9240a4ac301dd0ad520c0c697c2ea7d
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
prerequisite-message-id: 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
prerequisite-patch-id: 0d995b19a62289433fe888843af1baa6fd19aec7

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


