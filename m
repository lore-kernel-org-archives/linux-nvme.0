Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94245C28E83
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639B1206EB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GsCXrK9l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fo1o7u6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639B1206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6OzcwopfzqDxlXyfSDYF9sCs3QW7GSI7/1yuouUaxd0=; b=GsCXrK9ljIp50z0sLPxWiDYAwH
	1CPvBCgI4BZ2pXtu3OUsRG3NBlImBxekFUfImoBq0Vr8/Gy9wV7lyaqPLChCQUqxI9Wp3MTMQyt9G
	ej1oqeMqiSyjpja1NJeQKig4CcPdh4veJq4thRpXmlC0B9fzNKNF5Ib9X87OggVbyQyT/yVUpl6Cc
	pcDPO752sdtCUZMaMbUp+3Y5Q2rSUSPNigP0N1xbprSlDjyrnG3JYO39oGj8vWUOCQzricLJJZ/9Q
	BLK222T+b07gzH8KU317u8M+eNGc7YCyETQC6s7AmkpcKZH7jxwPQLZPTk/AXq4LkktY5hUl32pMj
	0mGwHEww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fY-0002Mj-CI; Tue, 01 Sep 2020 15:58:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fT-0002Kb-0a
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=M79so1AwUwPIRouROFaNCg3KdKArTwMSMNd8wl3xC9I=; b=Fo1o7u6IVr6vurOMarEGQIw99y
 WHqyrdok/75XjmzAvs98wm2mZXYI8eGfVJCJLikO8fuOJu/9j6XvoFdlr1RTa038r8DDcHMqAU7lY
 mmSZLC/smn0SnolNwwxdyrpDJlJoZhG0K7MVmnl8ewTBrEYNYAPRaMnE4rjqCK7VlkM7JqAlUWyDU
 YkH9TJZ6yJEEibyeqV37+FBh0RkQQ6BwwzwRxyMvkU7/sD29/P1lImVmElLT8cbRAFklBxMxACP/P
 9Ptq9IU2Xfcl9fIpw/yp4N3MdH0FKE600v4IAuPUo366M4kD36FMV0WaYWth1qfPOYnF35tgpEEiP
 sE6GqZdg==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fN-0004OS-MU; Tue, 01 Sep 2020 15:57:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: remove revalidate_disk()
Date: Tue,  1 Sep 2020 17:57:39 +0200
Message-Id: <20200901155748.2884-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

this series removes the revalidate_disk() function, which has been a
really odd duck in the last years.  The prime reason why most people
use it is because it propagates a size change from the gendisk to
the block_device structure.  But it also calls into the rather ill
defined ->revalidate_disk method which is rather useless for the
callers.  So this adds a new helper to just propagate the size, and
cleans up all kinds of mess around this area.  Follow on patches
will eventuall kill of ->revalidate_disk entirely, but ther are a lot
more patches needed for that.

Diffstat:
 Documentation/filesystems/locking.rst |    3 --
 block/genhd.c                         |    9 ++----
 drivers/block/nbd.c                   |    8 ++---
 drivers/block/rbd.c                   |    2 -
 drivers/block/rnbd/rnbd-clt.c         |   10 +------
 drivers/block/virtio_blk.c            |    2 -
 drivers/block/zram/zram_drv.c         |    4 +-
 drivers/md/dm-raid.c                  |    2 -
 drivers/md/md-cluster.c               |    6 ++--
 drivers/md/md-linear.c                |    2 -
 drivers/md/md.c                       |   10 +++----
 drivers/md/md.h                       |    2 -
 drivers/nvdimm/blk.c                  |    3 --
 drivers/nvdimm/btt.c                  |    3 --
 drivers/nvdimm/bus.c                  |    9 ++----
 drivers/nvdimm/nd.h                   |    2 -
 drivers/nvdimm/pmem.c                 |    3 --
 drivers/nvme/host/core.c              |   16 +++++++----
 drivers/scsi/sd.c                     |    6 ++--
 fs/block_dev.c                        |   46 ++++++++++++++++------------------
 include/linux/blk_types.h             |    4 ++
 include/linux/genhd.h                 |    6 ++--
 22 files changed, 74 insertions(+), 84 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
