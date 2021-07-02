Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC8C11F68
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCADF61420
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCADF61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iuU2zbaRV9CEN156T5t+4HxIGfbQ26V9crHEuFcj9G0=; b=kFfHwbeCTV8ibV
	80OvaWkdsIsa7hjxYsHfv3iJqKYzag0/Tg084hVUL6H4RnlWB3hwrXZDV2XJLwFrqCa5+z599jIYV
	/7X2vYN9+wlMnSdUHdtWWFaPa+IBmgV4JZeWHJ6ZmEeIRDwav1rGwjIvr66UyQrpqEspTqsj83mYf
	3nzZXhU8pjGd20ALSz0snl/n4aHVMKf5FVGZCpfEaEciVPBJ6bdyTHn+VQdEJevvSuincH4UHd2Um
	LrW+wSp8gT3wM05vRFAiBAbf2CUBBhWSi/XvJsx1upRMpgD50VQDOAnO7tvS5dizSDeN3ByIo2lMR
	Otwxslix26d1kht8HmEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzKky-003MJI-GN; Fri, 02 Jul 2021 15:07:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzKkv-003MIH-QE
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 15:07:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625238418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PdwfPK8O2p53Sdh/U+k8MCs9zMdJjwSRegEiKK8wxr4=;
 b=CRz4IJyFjMQ5QxOaU2CNy163A91V+4A6czzk4TQA7ErhKoq8Gk4hMuEFVHMWn5cvdMYnKU
 0jjADKthP6KU45hU6wjrVPlac6Q0M2rSjG2HF7AY3xIh8fJTlaX/0GusCgxO94vAVjV9hL
 u5plyPlHgFsJHZcRWBfOoedD2INi1qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-ocqMkxnINPK5_UGFYX5n_A-1; Fri, 02 Jul 2021 11:06:55 -0400
X-MC-Unique: ocqMkxnINPK5_UGFYX5n_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5510100C610;
 Fri,  2 Jul 2021 15:06:52 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 015095D6D3;
 Fri,  2 Jul 2021 15:06:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/6] blk-mq: fix blk_mq_alloc_request_hctx
Date: Fri,  2 Jul 2021 23:05:49 +0800
Message-Id: <20210702150555.2401722-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_080701_964390_C6D19452 
X-CRM114-Status: GOOD (  16.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
However, all cpus in hctx->cpumask may be offline.

This usage model isn't well supported by blk-mq which supposes allocator is
always done on one online CPU in hctx->cpumask. This assumption is
related with managed irq, which also requires blk-mq to drain inflight
request in this hctx when the last cpu in hctx->cpumask is going to
offline.

However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
them to ask for request allocation when the specified hctx is inactive
(all cpus in hctx->cpumask are offline).

Fix blk_mq_alloc_request_hctx() by adding/passing flag of BLK_MQ_F_MANAGED_IRQ. 

Meantime optimize blk-mq cpu hotplug handling for non-managed irq.

V2:
	- use flag of BLK_MQ_F_MANAGED_IRQ
	- pass BLK_MQ_F_MANAGED_IRQ from driver explicitly
	- kill BLK_MQ_F_STACKING

Ming Lei (6):
  blk-mq: prepare for not deactivating hctx if managed irq isn't used
  nvme: pci: pass BLK_MQ_F_MANAGED_IRQ to blk-mq
  scsi: add flag of .use_managed_irq to 'struct Scsi_Host'
  scsi: set shost->use_managed_irq if driver uses managed irq
  virtio: add one field into virtio_device for recording if device uses
    managed irq
  blk-mq: don't deactivate hctx if managed irq isn't used

 block/blk-mq-debugfs.c                    |  2 +-
 block/blk-mq.c                            | 27 +++++++++++++----------
 drivers/block/loop.c                      |  2 +-
 drivers/block/virtio_blk.c                |  2 ++
 drivers/md/dm-rq.c                        |  2 +-
 drivers/nvme/host/pci.c                   |  3 ++-
 drivers/scsi/aacraid/linit.c              |  3 +++
 drivers/scsi/be2iscsi/be_main.c           |  3 +++
 drivers/scsi/csiostor/csio_init.c         |  3 +++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  1 +
 drivers/scsi/hpsa.c                       |  3 +++
 drivers/scsi/lpfc/lpfc.h                  |  1 +
 drivers/scsi/lpfc/lpfc_init.c             |  4 ++++
 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  3 +++
 drivers/scsi/qla2xxx/qla_isr.c            |  5 ++++-
 drivers/scsi/scsi_lib.c                   | 12 +++++-----
 drivers/scsi/smartpqi/smartpqi_init.c     |  3 +++
 drivers/scsi/virtio_scsi.c                |  1 +
 drivers/virtio/virtio_pci_common.c        |  1 +
 include/linux/blk-mq.h                    |  6 +----
 include/linux/virtio.h                    |  1 +
 include/scsi/scsi_host.h                  |  3 +++
 23 files changed, 67 insertions(+), 27 deletions(-)

-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
