Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C1C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD5364DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD5364DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/AGXzp4AB4mYSDB9ejfvKVJFc8u3LER9tN7mK3YeVko=; b=Ne8zdKKM0Q85qbi0pT1h5k4Q0o
	6Vc89kq4jxOdyxpl81PnDoRNS+ZRP9uqUCTfaOnfe7hyzcFByPAx7PPUooZu37q3ukLK5KzUxWL5f
	eKmriGD5IohdJ1lBTrwpZnBy6fLd831pvcYEnRiwHX3iTWFalj1cnUry62LPzR5+hAtXTlR4tytZh
	+8w+o+KzkXDEwYFqHZNE7n2A69G0ozrEatUzSDKB5XsMzAZwPRZGEEZmyt8NK21PSfH96E+E2qS+4
	GH2RTEtU0RVgBbY4M+VTtZc54JPTVJ3sh/o0qQkxiDDWi+MzZ2tIWz6ia0qa712Kzj2qXiD2jTmMk
	k9MWYvzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDc-000262-Gm; Thu, 28 Jan 2021 04:47:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDX-00023r-BB
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809259; x=1643345259;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e5BRWH3ndZ4m7lh7jlC59rxB91+FzmyxAYGz5VrGiO0=;
 b=q6j5hCi/9lqec3d2GBJjwJah2wW9X+tke4gpoHNqnkbx5NPC6tpxsgHX
 xmQnkun4YeeIxTqwEV6WfouCZ/RhBui/TLbWWbyKYBHL+WQVRappVlBY1
 5UxByBCt4E6MhKtsuocfessilniGTkbUoDCiqnbzKl6XIuDgtPRGzzmFa
 f9+AUw0OqH5NM14sFM1mBXjNQ7QnmQqBIWaJK5yZ+f9Cx3w3vcWlDOhVj
 8RCkuWPhxeVYJq/MpkLXOEE7fY4iilr1StEAwx4qG2Mlf2zAzMyw8/CDp
 GtPYAVfmRpoVqo204a6a/QaAi7l70jewCIug6In8yVYwJjADKJUxk7vqN w==;
IronPort-SDR: pFfpYxht1G9NqZbWrdv0G+ECgtlGxnVG880kaFb0xR0Q5FYmWuVZX8Ts2DDdEXKEKbQrJgFSn2
 swHzdWpJ47IhzlKrsVMbri4KVEqBTqEQXt/LewIuyKzJnn4l4C+nDhazdBAQIa7pkyyt56HBcP
 PhHqciN7yr6UBLnuRIqyw0SytOhRVwDEr2QOe2RaoHCvUtjrG4u7TTywO25/63YuAqWKqyfw8Y
 tlMCOHHQKMGHypu4Prfb9Fk5i107fyGWGaGvWAyz2xI8wWo7n9kqNr3B7heRemwHGZccrbsIJ1
 bxE=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509613"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:36 +0800
IronPort-SDR: FLe0THpvOPDh1P8tICWPzGj9XVNC6k9CWNysMEp3NktxUJbd7QbH+ghDld0gXNfMK216UzPVai
 AJl2BBAOAtuRMQyWtK5FTPKyChLLsi3Kxi07JVuJNBcWMiYOVKe+zQQRdyzx00pD1xBxBoZf20
 e1zSmnb75Sgh0RQsMWCEbFrNv0vU+YFBnURQR+t9gree1U/wABOEYkmCkhnoTR7sTSvvQa2YKU
 rHXFCBBg0Py6KZ34sx+5AZeGc31YLnOkRbN8tktCn4KR5aCzL3g4FplsqnwNw16k1AsoITLJ2j
 iJ+hXYWHK6wrwsR2D1IolI8k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:31:56 -0800
IronPort-SDR: ZdHmQTx/rm7fgx7E8n7fVNa6Sxm51qOl0qUltYbh/FT1cmd4L8nHShfBziClAs7ExJMvQqrAOp
 d9pGCnce6U4YY5zqq+gO+nCmvEzSEF6ylUsvXNS1kj8leKt4TRkUXIT1jRbwz6iRddh3brI+6Y
 tu6kEmzuWooccB6nF94ImYRnHoppa01XRD9JSPJ9af3Zr+v4hKIT1vPteGLCUNTE0dln6o3kO2
 5ywlDhufk75DPMZR9D+oOLi7yw/T9PLZ50WPkjvKbsJ18lBUt0YvMnkGyvPx+cpYWoS1kHN0OV
 1BE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:34 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 0/8] block: add zone write granularity limit
Date: Thu, 28 Jan 2021 13:47:25 +0900
Message-Id: <20210128044733.503606-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234739_611259_D240A69C 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The first patch of this series adds missing documentation of the
zone_append_max_bytes sysfs attribute.

The following 3 patches are cleanup and preparatory patches for the
introduction of the zone write granularity limit. The goal of these
patches is to have all code setting a device queue zoned model to use
the helper function blk_queue_set_zoned(). The nvme driver, null_blk
driver and the partition code are modified to do so.

The fourth patch in this series introduces the zone write granularity
queue limit to indicate the alignment constraint for write operations
into sequential zones of zoned block devices. This limit is always set
by default to the device logical block size. The following patch
documents this new limit.

The last 2 patches introduce the blk_queue_clear_zone_settings()
function and modify the SCSI sd driver to clear the zone related queue
limits and resources of a host-aware zoned disk that is changed to a
regular disk due to the presence of partitions.

Changes from v3:
* Added pathces 2, 3, 4, 7 and 8
* Addressed Christoph's comments on patch 5

Changes from v2:
* Added patch 3 for zonefs
* Addressed Christoph's comments on patch 1 and added the limit
  initialization for zoned nullblk

Changes from v1:
* Fixed typo in patch 2

Damien Le Moal (8):
  block: document zone_append_max_bytes attribute
  nvme: cleanup zone information initialization
  nullb: use blk_queue_set_zoned() to setup zoned devices
  block: use blk_queue_set_zoned in add_partition()
  block: introduce zone_write_granularity limit
  zonefs: use zone write granularity as block size
  block: introduce blk_queue_clear_zone_settings()
  sd_zbc: clear zone resources for non-zoned case

Damien Le Moal (8):
  block: document zone_append_max_bytes attribute
  nvme: cleanup zone information initialization
  nullb: use blk_queue_set_zoned() to setup zoned devices
  block: use blk_queue_set_zoned in add_partition()
  block: introduce zone_write_granularity limit
  zonefs: use zone write granularity as block size
  block: introduce blk_queue_clear_zone_settings()
  sd_zbc: clear zone resources for non-zoned case

 Documentation/block/queue-sysfs.rst | 13 +++++++++
 block/blk-settings.c                | 39 +++++++++++++++++++++++++-
 block/blk-sysfs.c                   |  8 ++++++
 block/blk-zoned.c                   | 17 ++++++++++++
 block/blk.h                         |  2 ++
 block/partitions/core.c             |  2 +-
 drivers/block/null_blk/zoned.c      |  8 +++---
 drivers/nvme/host/core.c            | 11 ++++----
 drivers/nvme/host/zns.c             | 11 ++------
 drivers/scsi/sd_zbc.c               | 43 ++++++++++++++++++++++++++---
 fs/zonefs/super.c                   |  9 +++---
 include/linux/blkdev.h              | 15 ++++++++++
 12 files changed, 150 insertions(+), 28 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
