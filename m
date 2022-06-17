Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23384C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y2+QLJ80osyk1Xbrx++QKhwCvwxnhlY6aBPNKBtQXZI=; b=OJiBaKEgofxYDdbHOXIqhDxNsZ
	pFUUS/xKfngiL42VALbNWk8shgLeN1Npr/3LIhsZ8YjUdrJJc2I5fvWPjIhSebdSNzdASkY71QMX+
	iohuYMXiw1L/ORoPH0QU3Md+JpykSi12hnP616pIAgxJYmxqgP6lu9AxXIGpNh9YVr1S1NxgHoz4w
	UQfNEB/nMcsWORmZDa7TjX2jv38c2YFONsubECxFy7WyWquMlpOsLwunl4sog7tyqY5FyoJXg3wdx
	sUlyEZU9GkgaLc1EY2iUVLtkVb5krzCAeTEOrvZxzbA58JmNv2LF5Z0twPTDiAms7K0IHwWqmEv0n
	awsiILgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o29n0-007BVk-BL; Fri, 17 Jun 2022 11:05:22 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o29jR-0079YR-8p
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 11:01:44 +0000
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPbfJ20Xgz6H6l9;
	Fri, 17 Jun 2022 18:59:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 13:01:34 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:01:30 +0100
From: John Garry <john.garry@huawei.com>
To: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
	<sebaddel@cisco.com>, <kartilak@cisco.com>
CC: <linux-rdma@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <mpi3mr-linuxdrv.pdl@broadcom.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nbd@other.debian.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] blk-mq: Add a flag for reserved requests series
Date: Fri, 17 Jun 2022 18:55:15 +0800
Message-ID: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_040141_640547_EAA4319A 
X-CRM114-Status: UNSURE (   9.08  )
X-CRM114-Notice: Please train this message.
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

In [0] I included "blk-mq: Add a flag for reserved requests" to identify
if a request is 'reserved' for special handling. Doing this is easier than
passing a 'reserved' arg to the blk_mq_ops callbacks. Indeed, only 1x
timeout implementation or blk-mq iter function actually uses the
'reserved' arg (or 3x if you count SCSI core and FNIC SCSI driver). So
this series drops the 'reserved' arg for these timeout and iter functions.
Christoph suggested that I try to upstream now.

About the SCSI changes, I can leave them in place if people prefer.

Based on following:
c13794dbe936 (block/for-5.20/block) block: Directly use ida_alloc()/free()

[0] https://lore.kernel.org/linux-scsi/1654770559-101375-1-git-send-email-john.garry@huawei.com/T/#m22aa9f89e55835edc2e650d43f7e3219a3a1a324

John Garry (5):
  scsi: core: Remove reserved request time-out handling
  blk-mq: Add a flag for reserved requests
  blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
  scsi: fnic: Drop reserved request handling
  blk-mq: Drop 'reserved' member of busy_tag_iter_fn

 block/blk-mq-debugfs.c              |  2 +-
 block/blk-mq-tag.c                  | 13 +++++--------
 block/blk-mq.c                      | 22 +++++++++++++---------
 block/bsg-lib.c                     |  2 +-
 drivers/block/mtip32xx/mtip32xx.c   | 11 +++++------
 drivers/block/nbd.c                 |  5 ++---
 drivers/block/null_blk/main.c       |  2 +-
 drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
 drivers/mmc/core/queue.c            |  3 +--
 drivers/nvme/host/apple.c           |  3 +--
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/fc.c              |  6 ++----
 drivers/nvme/host/nvme.h            |  2 +-
 drivers/nvme/host/pci.c             |  2 +-
 drivers/nvme/host/rdma.c            |  3 +--
 drivers/nvme/host/tcp.c             |  3 +--
 drivers/s390/block/dasd.c           |  2 +-
 drivers/s390/block/dasd_int.h       |  2 +-
 drivers/scsi/aacraid/comminit.c     |  2 +-
 drivers/scsi/aacraid/linit.c        |  2 +-
 drivers/scsi/fnic/fnic_scsi.c       | 14 ++++----------
 drivers/scsi/hosts.c                | 14 ++++++--------
 drivers/scsi/mpi3mr/mpi3mr_os.c     | 16 ++++------------
 drivers/scsi/scsi_lib.c             | 12 ++----------
 include/linux/blk-mq.h              | 10 ++++++++--
 include/scsi/scsi_host.h            |  2 +-
 26 files changed, 67 insertions(+), 93 deletions(-)

-- 
2.35.3


