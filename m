Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D1C433E9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81943230FC
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81943230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uf23qlfo5BOQNvRxDMAldIbL6aE8BjNcLuPWaxm2Gs4=; b=jkrUT9h/olwfs+7yuPZ3nyfSLL
	w63VPjcBK8X+0ILXPfY+t0SqQ7uhuin5afsjMN5E5O5VGwe9EL23QDdmC4yERBqhxduHqn7f0m0Un
	cgEHJ8euOgti4kJj96fR/2gpXfAVqxwKulBbf/RXWqpgh/FOdFkmZhLHYxWV2S7h2oRPEOhyHstsS
	DQShXiee9QTO2zqN47Fe9qA4+SbxjNU3d5pIl+ycKUPzNMSlQDirzixZIvK8TSnibofke1ZjaTuoi
	NBMxzi8A/PqjZ5MsARdsdTeQWl/3YZS3bfAwhWOHGBfZCBRuNkM0W21e7kNmuF9p+kt+zbqbP24YS
	c342+P2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2rMm-0003RQ-Lx; Fri, 22 Jan 2021 08:00:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2rMj-0003Ps-RB
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611302421; x=1642838421;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PmVFNnNLJHQcXQX+aWcelrjVOu18j6MRMWuoMHf07yY=;
 b=TGNsx/AH/vFRXYdyIbXcbVCD5nc0NS0ZcKwzXGGMbF+hExJr9DtSIzrU
 4okWgcGCdCGu8d4tqXRQz/ebTAWw00NwubgsXtN6Pj1aclZzFXj3PY79S
 HdTfk/+Ref9vVHraMsN2WPJ4MVWsfm93qTKuHSJBKeHqb8qHKEeaaAPtE
 H9FwXvNOPx4OEoTHInvU2E6rdYa4YFeSanskhpo7ew+6lzbgg/t0TKusR
 I3YBZzw21DEWhZ9xZAbDgoHjRcphVMsPbJBrcDlXQSkqx4IlbZHDm3kQ7
 tVtIo4oPD0EkGnY06OQBz38NYHvE5JZpsQySNJMK+f6PsixExtoLpUROT Q==;
IronPort-SDR: 3rkOqyM6oR4JUaM7A03XwLtomDjNP1g4StkIZbFI0Q6w/m5zvf18wJWl7ViBJhqD8a6rPpUcey
 aW+e3BPk17bm0D4yUAdTdVUGYeHNPVBuHgGw7gRCEnnqt2zOsgiRsOLZfHPaCFjUGp7L3ruMd9
 5lWdPZroHiK2cDyu5irJTJCvbG9hqvqL76lD6J48jB3Bi4WjeCh9y9+sqiqxMIsNkXp6KrU8Cb
 tDDzlPH447jrcU3Yl3LP1VZ2XaPhU6Ao077NKMoJYLac+5lwfW85alPBhbv//puHsBsbOLteUZ
 5wQ=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; d="scan'208";a="158062031"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 16:00:16 +0800
IronPort-SDR: NnHNvAMI/hJZdTuE0Jhk8YScrYkXwYaznr3IAI3Six31PlrT445r3PBRsVwWG8A82+0GzuN8Mt
 Ib9KEGiAo4W5V30Ago8uSR7yHmlXcGcYsX8GiD1/JTAMj2U9c+uOfrcVDSdEGWVyYXFJtr7Mbb
 FjQo0jQ17fVq363fb+p7FA1E+i009ECkHsppu2QO3kyucJRCNjaLZKBuUcvs9NuTqcKv8Zx4za
 1pmv2eeckZIRSjFbfSolQxmCt7pP9p66R7K9Duxdb+/beLDllmaoVB+Hd0Vngv+/tznqWv8JLQ
 tbGI7RCQQ/qKMC72pQ6z0PcX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:42:48 -0800
IronPort-SDR: OP5cUK2NUW3b77Blf3/vL6Fa+7tkZzRXFXJ8NxCdQe/t5TA6TtLdbibkiWl1C84OTKM1PuxciQ
 FD/sjaOzroCgxqSSGbjBczMvYdhizP4XhkQWAIPT5ZddfRqBcWPOavSjZUWmWt3EdyV2C+U+/Z
 vdx4lg4k2FYV35AcFD7jhYP80TyrFJKSFIj6vCt0E91SaWoGiPZ7+8Uk4kBooBe8XBjZ5KFrHI
 5BmDITzvZ4NGLOkTwPWzuSKaZ6CcR7unwxs5lYMpcDfbhmn1mP3ZWvBEzVbIX82+wuCUdAW7KF
 BM4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 22 Jan 2021 00:00:15 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/3] block: add zone write granularity limit
Date: Fri, 22 Jan 2021 17:00:11 +0900
Message-Id: <20210122080014.174391-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_030022_016846_99C6E185 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: linux-scsi@vger.kernel.org, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The first patch in this series introduces the zone write granularity
queue limit to indicate the alignment constraint for write operations
into sequential zones of zoned block devices.

The second patch fixes adds the missing documentation for
zone_append_max_bytes to the sysfs block documentation.

The third patch switch zonefs to use this new limit as the file block
size instead of using the physical block size.

Changes from v2:
* Added patch 3 for zonefs
* Addressed Christoph's comments on patch 1 and added the limit
  initialization for zoned nullblk

Changes from v1:
* Fixed typo in patch 2

Damien Le Moal (3):
  block: introduce zone_write_granularity limit
  block: document zone_append_max_bytes attribute
  zonefs: use zone write granularity as block size

 Documentation/block/queue-sysfs.rst | 13 ++++++++++
 block/blk-settings.c                | 39 +++++++++++++++++++++++++----
 block/blk-sysfs.c                   |  8 ++++++
 drivers/block/null_blk/zoned.c      |  1 +
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++
 fs/zonefs/super.c                   |  9 +++----
 include/linux/blkdev.h              | 15 +++++++++++
 8 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
