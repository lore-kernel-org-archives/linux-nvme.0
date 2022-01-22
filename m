Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE44C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I3fIAsh23COYRzIAM+F+V2r54E6dpD4KEWjdqwp1PRo=; b=xKfQ668g1lLOxOpe5N0rBF+4IY
	eO0cUIwiGz/bzHq5MbxPwy3t9cFpmPBvQZFYxrXyWCsV2F4IMyL2yN8XKcJGZ0QU7g/U4k6ZpzyUQ
	KQUFE84cp/uFu723CaZzu/066ZwSwcYEveouFaMT5nbbdEFXUl9Hz/LXzKA3xRf9ybTNm/5rNu0Be
	d9MZbNuJi54KcNt/toTaN0IjLXeymrwyDo44aWLSvVfy1fIH7TkiUoxgg9xWehGqT8uqZP14VpX0o
	7Rc66UL7eM0zc84NP+4hCPrA9bINp3WkRAcmGJhishhkzzr+3zQ/ozPqMx/5L3/VPD0umnADN7ik9
	i1i5j80Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEIs-00H9uu-As; Sat, 22 Jan 2022 11:11:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEIp-00H9uN-Vz
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I3fIAsh23COYRzIAM+F+V2r54E6dpD4KEWjdqwp1PRo=;
 b=GAwLzuC5QPRmwOSZKneh2SMIgMYgtpQRGx7cxmu2ZmgTgHaW9J19N12p8p3H5yy3+0I58Y
 5Q/F9Y8G38suOOsEqfGO5etGCw7E+3E4YNv37SpC8ImFDl7SDzN2i+5TxaPnrU8oNg3Ifh
 2LmcKjMnoczN+K9/AQyyg2/SvlXeDJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-zLwqckbUNIeaNMQHoMkZdw-1; Sat, 22 Jan 2022 06:11:21 -0500
X-MC-Unique: zLwqckbUNIeaNMQHoMkZdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E12141083F62;
 Sat, 22 Jan 2022 11:11:19 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E74F6D03F;
 Sat, 22 Jan 2022 11:11:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/13] block: don't drain file system I/O on del_gendisk
Date: Sat, 22 Jan 2022 19:10:41 +0800
Message-Id: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031128_149715_2B182DDB 
X-CRM114-Status: GOOD (  12.47  )
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

Hello,

Draining FS I/O on del_gendisk() is added for just avoiding to refer to
recently added q->disk in IO path, and it isn't actually reliable:

1) queue freezing can't drain FS I/O for bio based driver, so blk-cgroup
shutdown can't be moved into del_gendisk()

2) freezing queue can't drain in-progress IO issue/dispatch activities,
so elevator shutdown can't be moved into del_gendisk()

3) the added flag of GD_DEAD may not be observed reliably in
__bio_queue_enter() because queue freezing might not imply rcu grace
period.

4) passthrough IO accounting code can refer to q->disk after disk is
released

When releasing disk, all FS IOs are guaranteed to be done, so this
patchset tries to shutdown elevator/blk-cgroup/rq qos there, then
referring to q->disk can be avoided after disk is released.

Also add flag of BLK_MQ_REQ_USER_IO for accounting passthrough IO
only if the IO is from userspace, since disk is live for user
passthrough IO.

V2:
	- take new approach to make current referring to q->disk reliable


Laibin Qiu (1):
  block/wbt: fix negative inflight counter when remove scsi device

Ming Lei (12):
  block: declare blkcg_[init|exit]_queue in private header
  block: move initialization of q->blkg_list into blkcg_init_queue
  block: move blkcg initialization/destroy into disk allocation/release
    handler
  block: only account passthrough IO from userspace
  block: don't remove hctx debugfs dir from blk_mq_exit_queue
  block: move q_usage_counter release into blk_queue_release
  block: export __blk_mq_unfreeze_queue
  scsi: force unfreezing queue into atomic mode
  block: add helper of disk_release_queue for release queue data for
    disk
  block: move blk_exit_queue into disk_release
  block: move rq_qos_exit() into disk_release()
  block: don't drain file system I/O on del_gendisk

 block/bfq-iosched.c        |  2 +
 block/blk-cgroup.c         |  2 +
 block/blk-core.c           | 31 ++++----------
 block/blk-mq.c             | 27 ++++++++++--
 block/blk-sysfs.c          | 25 +-----------
 block/blk.h                | 10 ++++-
 block/elevator.c           |  2 -
 block/genhd.c              | 84 +++++++++++++++++++++++++++-----------
 drivers/nvme/host/ioctl.c  |  2 +-
 drivers/scsi/scsi_ioctl.c  |  3 +-
 drivers/scsi/sd.c          |  2 +-
 include/linux/blk-cgroup.h |  4 --
 include/linux/blk-mq.h     |  3 ++
 include/linux/genhd.h      |  1 -
 14 files changed, 114 insertions(+), 84 deletions(-)

-- 
2.31.1


