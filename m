Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E44C0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qw3JY1fSFkCDbqzWrwPQL1ow2KshJKSV3fmVfeQPZXE=; b=3JlDR3Sl+5tVrYYmn1nYc/G0AB
	ZbqX2p9eKVkWBScD/X+NReTyX/Z8QfzKTCuXUUaZPIK9LmsGt2yF4+OkkSt0JztdVo+p6rPGEY15N
	YOx/nMXrJ85bFmZv0mbvEv79M6Yule3LsTrvX+PW1kDdj6q4aBgmnU+fzRSJHyrRBxuAMeulC5sZR
	QvC/zq+faZFqy12hvHt7hBqfcHZ5ZAMFY3X+R5hbekDNSGcxoWOJKCZnxjUsBfFRgR9aPZUO+P51D
	JChk0Jz4/6fDXWpxAxdgno3LGmYSRSFv+Qi/v8hhl403KVNEb0y3mU3yVNvkZF2JKlh3kTM+5WlOA
	nwUEEA6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0k-009lfm-2t;
	Wed, 26 Jul 2023 09:40:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0g-009lee-3A
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 09:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690364444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qw3JY1fSFkCDbqzWrwPQL1ow2KshJKSV3fmVfeQPZXE=;
	b=Pva29bVdOrlZnEJwPdUDAt+7IlDnUPowitB8svqIJ/XuIBzVs+9YWdhebFKkFj9t9e0wcZ
	vfbC3d/JTpi3ucM4Cq2QwZT+NJnID+4FdurbE1WV8uV1/M3m78rioI6R84uuE91RKo5MTa
	UhY2JgVJ2lVf17EiEoNTIYFM/1U5tho=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-nPty-3TXN5CPhkgu8OlO_A-1; Wed, 26 Jul 2023 05:40:36 -0400
X-MC-Unique: nPty-3TXN5CPhkgu8OlO_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AB713C01BA1;
	Wed, 26 Jul 2023 09:40:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C90C0492C13;
	Wed, 26 Jul 2023 09:40:34 +0000 (UTC)
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
Subject: [PATCH V2 0/9] blk-mq: fix wrong queue mapping for kdump kernel
Date: Wed, 26 Jul 2023 17:40:18 +0800
Message-Id: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_024047_112655_33D52E54 
X-CRM114-Status: GOOD (  15.31  )
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

On arm and ppc64, 'maxcpus=1' is required for kdump kernel,
see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

This issue is only triggered on managed irq in case of multiple hw
queues. Some drivers takes online cpus into account for nr_hw_queues,
and don't have such issue, such as nvme rdma/tcp.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

V2:
	- add helper of scsi_max_nr_hw_queues() for avoiding potential build
	failure because scsi driver often doesn't deal with blk-mq directly
	- apply scsi_max_nr_hw_queues() for all scsi changes
	- move lpfc's change into managed irq code path


Thanks,
Ming

Ming Lei (9):
  blk-mq: add blk_mq_max_nr_hw_queues()
  nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues
  scsi: core: add helper of scsi_max_nr_hw_queues()
  scsi: lpfc: use blk_mq_max_nr_hw_queues() to calculate io vectors
  scsi: hisi: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: mpi3mr: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: megaraid: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: mpt3sas: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors
  scsi: pm8001: take blk_mq_max_nr_hw_queues() into account for
    calculating io vectors

 block/blk-mq.c                            | 16 ++++++++++++++++
 drivers/nvme/host/pci.c                   |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  3 +++
 drivers/scsi/lpfc/lpfc_init.c             |  2 ++
 drivers/scsi/megaraid/megaraid_sas_base.c |  6 +++++-
 drivers/scsi/mpi3mr/mpi3mr_fw.c           |  3 +++
 drivers/scsi/mpt3sas/mpt3sas_base.c       |  4 ++--
 drivers/scsi/pm8001/pm8001_init.c         |  4 +++-
 include/linux/blk-mq.h                    |  1 +
 include/scsi/scsi_host.h                  |  5 +++++
 10 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.40.1


