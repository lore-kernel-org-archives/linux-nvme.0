Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D0C4727D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDDE22208
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5vfYuOW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG1XLivi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDDE22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zvRkdbBqe9fc3n7EDVBh73/iPPjRd2b6lKVjwA//vso=; b=c5vfYuOW9JYWvsg8vtqv8dhm0
	uq06t9kAvBDMVFUiPh2GVEgOoYI5JFgNGAGnYjxyeZGDAgn7m8eQeJCVUNzFesOwz7Zbx1XGX+oAP
	lNp+ba8n7cDjNC5foDl5N+6O+YimFoku3rrB2+KsRIZR+XV1ZxdtYBQWerSHvIMcNCf/ODFwyOX9C
	zuiPBX4BJrum0Eguf3UGckqLq4egWpNn9YkufwxjRhvnp+olt/awWkwed0mfT74F9bXj4y53lGaqf
	FqI0i55dTEWScue8g2MbjcyxKAWJTmfGc8IWpfBMoLQFBVTkHZ5KBkYMQ9iKJkWIJHOpOgWqInXFc
	Dy4gJAJuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLYFJ-0002sx-Rr; Thu, 24 Sep 2020 20:53:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLYFE-0002qR-UP
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 20:53:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A574422208;
 Thu, 24 Sep 2020 20:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600980816;
 bh=RTSrivTd6OMf4V1bDzbMTqfScOTrO/ODyL9xIDVOP5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aG1XLividHHwLSM3cHx7fT3BCC7812DwzHOca3Z0IINQ8f2C4c7PVVDmAc8K7aVfC
 +be6uzYzzyh4srlXCWWTPLbV8ZzLb9EmNtdlp5mj1BQp6qOgX/64qL60iklNfxM8Rv
 NLDAnC9FlhVGa3L13PxCSTcRUDocSwsIBEtl3FPE=
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [PATCHv4 1/3] block: add zone specific block statuses
Date: Thu, 24 Sep 2020 13:53:28 -0700
Message-Id: <20200924205330.4043232-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924205330.4043232-1-kbusch@kernel.org>
References: <20200924205330.4043232-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_165337_103534_FB36BFDC 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 linux-api@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Keith Busch <kbusch@kernel.org>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A zoned device with limited resources to open or activate zones may
return an error when the host exceeds those limits. The same command may
be successful if retried later, but the host needs to wait for specific
zone states before it should expect a retry to succeed. Have the block
layer provide an appropriate status for these conditions so applications
can distinuguish this error for special handling.

Cc: linux-api@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-core.c                    |  4 ++++
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index f261a5c84170..2638d3446b79 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -124,6 +124,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
 EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
 If this value is 0, there is no limit.
 
+If the host attempts to exceed this limit, the driver should report this error
+with BLK_STS_ZONE_ACTIVE_RESOURCE, which user space may see as the EOVERFLOW
+errno.
+
 max_open_zones (RO)
 -------------------
 For zoned block devices (zoned attribute indicating "host-managed" or
@@ -131,6 +135,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
 EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
 If this value is 0, there is no limit.
 
+If the host attempts to exceed this limit, the driver should report this error
+with BLK_STS_ZONE_OPEN_RESOURCE, which user space may see as the ETOOMANYREFS
+errno.
+
 max_sectors_kb (RW)
 -------------------
 This is the maximum number of kilobytes that the block layer will allow
diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..8bffc7732e37 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -186,6 +186,10 @@ static const struct {
 	/* device mapper special case, should not leak out: */
 	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
 
+	/* zone device specific errors */
+	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
+	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
+
 	/* everything else not covered above: */
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f..8603fc5f86a3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -103,6 +103,24 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
 
+/*
+ * BLK_STS_ZONE_OPEN_RESOURCE is returned from the driver in the completion
+ * path if the device returns a status indicating that too many zone resources
+ * are currently open. The same command should be successful if resubmitted
+ * after the number of open zones decreases below the device's limits, which is
+ * reported in the request_queue's max_open_zones.
+ */
+#define BLK_STS_ZONE_OPEN_RESOURCE	((__force blk_status_t)15)
+
+/*
+ * BLK_STS_ZONE_ACTIVE_RESOURCE is returned from the driver in the completion
+ * path if the device returns a status indicating that too many zone resources
+ * are currently active. The same command should be successful if resubmitted
+ * after the number of active zones decreases below the device's limits, which
+ * is reported in the request_queue's max_active_zones.
+ */
+#define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
