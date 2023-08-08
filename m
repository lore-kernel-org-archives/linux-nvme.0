Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8871AC001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C17OARe57EL9o7KdFcMFd+ePVCSI04MI+oyFBoL2yZ8=; b=o98wFnaCSWTtkAY7cavo63mP8a
	irbEyWX7IvN6gR9Xc0r7daw3O2Rm+cJXO7Ocy6mWRQnYUjh0IXvgeJWvlmPZbUEE1woZ5Pzx6GTd8
	XzbBmp25gI78oNuRXazc28XhMMxJIK/cFKWoA/bSCiwUqNFbvLpUdgfTY9qHNJhOJRhmTAZO1iXYw
	n+9aAD1BsudKYA8CgRyhNNW31JJJkpdJ2xVBuh4OYcxlI6IhkFvltA8PyhuamGcj3kYmEn87AIIrL
	veTyXC/N29bbvTkwGtkhcR4dwV62ws79Pa4uN8xMj82WdyrtFD7dwo4rJAEeHY/AFtnKzn069smXE
	1DeFD79w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKB0-002JEk-22;
	Tue, 08 Aug 2023 10:42:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKAx-002JAt-1G
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C17OARe57EL9o7KdFcMFd+ePVCSI04MI+oyFBoL2yZ8=;
	b=KCcb9HxpQBPd9oM3e2+7Hr9UZ73xPNqIQAA+y9O2BUtPas/GzyNYMzmzPBwgFBE4aS2dQG
	ioCkHgi3OZOx1BBsMrIqLo3DT6OIm9ghbERvt25uj/DjZCT4fWZuNee3eLWqx4316Mhus4
	jtNHwWwFt1gmXknkTadz2Y3NftPiOeU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-u3rrZKuKNmyLrBZpCjaFeg-1; Tue, 08 Aug 2023 06:42:48 -0400
X-MC-Unique: u3rrZKuKNmyLrBZpCjaFeg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 596E9101A52E;
	Tue,  8 Aug 2023 10:42:48 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7880F492C13;
	Tue,  8 Aug 2023 10:42:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/14] blk-mq: fix wrong queue mapping for kdump kernel
Date: Tue,  8 Aug 2023 18:42:25 +0800
Message-Id: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034255_522149_AE657DA8 
X-CRM114-Status: GOOD (  13.41  )
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

Hi,

Fix wrong queue mapping for kdump kernel since blk-mq updates
nr_hw_queues to 1, so driver and blk-mq may have different queue topo.


V3:
	- cover more drivers
	- clean up blk-mq a bit, as suggested by Christoph

V2:
	- add helper of scsi_max_nr_hw_queues() for avoiding potential build
	failure because scsi driver often doesn't deal with blk-mq directly
	- apply scsi_max_nr_hw_queues() for all scsi changes
	- move lpfc's change into managed irq code path


Ming Lei (14):
  blk-mq: add blk_mq_max_nr_hw_queues()
  nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues
  ublk: limit max allowed nr_hw_queues
  virtio-blk: limit max allowed submit queues
  scsi: core: add helper of scsi_max_nr_hw_queues()
  scsi: lpfc: use blk_mq_max_nr_hw_queues() to calculate io vectors
  scsi: mpi3mr: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: megaraid: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: mpt3sas: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: pm8001: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: hisi: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: ufs: limit max allowed nr_hw_queues
  scsi: storvsc: limit max allowed nr_hw_queues
  blk-mq: add helpers for treating kdump kernel

 block/blk-mq.c                            | 55 ++++++++++++++++++-----
 drivers/block/ublk_drv.c                  |  2 +-
 drivers/block/virtio_blk.c                |  3 +-
 drivers/nvme/host/pci.c                   |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  3 ++
 drivers/scsi/lpfc/lpfc_init.c             |  2 +
 drivers/scsi/megaraid/megaraid_sas_base.c |  6 ++-
 drivers/scsi/mpi3mr/mpi3mr_fw.c           |  3 ++
 drivers/scsi/mpt3sas/mpt3sas_base.c       |  4 +-
 drivers/scsi/pm8001/pm8001_init.c         |  4 +-
 drivers/scsi/storvsc_drv.c                |  3 ++
 drivers/ufs/core/ufs-mcq.c                |  2 +-
 include/linux/blk-mq.h                    |  1 +
 include/scsi/scsi_host.h                  |  5 +++
 14 files changed, 75 insertions(+), 20 deletions(-)

-- 
2.40.1


