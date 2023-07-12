Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6674AEB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5CYqK3Y+IQKFaUkutdkJlO3sotphYax9MRe0AccKI2w=; b=se2pqEYr/wD2mgtvR4Pn4AAlBZ
	MXVfmJgNqLgov1iKG2YH2YUcHHKwToJ1ooxBgu7QjJCcn0B6y4b4n+60pTYEu2UPMIsTJEjqYpwKL
	/K48Ifc7n4bELrI5GI24reVTdsPB3ghkBwDHGmwrqqOhnsjs4HIVYIOPzf8BhjoAgyydeHksZF+Ld
	hXeWWwHc0+ijx27xQSN39GfPnI1mMySomnKdMvkouEp+LsnwzF85I8ziLEzUqo/zapusfIIPjRZOf
	Kx3MgC3BnCRSNN+Kc/ycXltNj7emfURtYviFv7kK9e9sL0vMw/+aF3bsJjiGUXdpLCN4vgn4v/tQq
	9Ja01O5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZNC-00HaDz-1f;
	Wed, 12 Jul 2023 12:55:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZN9-00HaD5-1g
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 12:55:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689166507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5CYqK3Y+IQKFaUkutdkJlO3sotphYax9MRe0AccKI2w=;
	b=XGjBUH4/BRve4xHVKgFE5Bp+aIwvATVnAocdwlmxQpZUGtRjQXDjwqiH0p4rGYIRff84y/
	a7kYCWqZXguqDjU6VzaF1CjuXPINZYLUWiG/fb326WMB0jz+U2Yi5vCGv53XPSUQSKQr3F
	62oJanQ4sxgr3JpQwvximI37xH3JI9k=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-PESh_r3nPIO4H1zgny0CSw-1; Wed, 12 Jul 2023 08:55:03 -0400
X-MC-Unique: PESh_r3nPIO4H1zgny0CSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 151EB3C0FC99;
	Wed, 12 Jul 2023 12:55:03 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E15D3C1ED96;
	Wed, 12 Jul 2023 12:55:01 +0000 (UTC)
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
Subject: [PATCH 0/8] blk-mq: fix wrong queue mapping for kdump kernel
Date: Wed, 12 Jul 2023 20:54:47 +0800
Message-Id: <20230712125455.1986455-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_055511_653874_239DF249 
X-CRM114-Status: GOOD (  15.07  )
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


Thanks,
Ming

Ming Lei (8):
  blk-mq: add blk_mq_max_nr_hw_queues()
  nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues
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

 block/blk-mq.c                            | 9 +++++++++
 drivers/nvme/host/pci.c                   | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 3 +++
 drivers/scsi/lpfc/lpfc_init.c             | 1 +
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++++-
 drivers/scsi/mpi3mr/mpi3mr_fw.c           | 3 +++
 drivers/scsi/mpt3sas/mpt3sas_base.c       | 4 ++--
 drivers/scsi/pm8001/pm8001_init.c         | 4 +++-
 include/linux/blk-mq.h                    | 1 +
 9 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.40.1


