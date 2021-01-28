Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84154C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E784064DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E784064DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4DhcOs2Ky3h3yd4LrhVS9onAAUxlmwOLNpT3I8lKM0E=; b=B/IftxOuhX2XIKEP2ypgudXFt
	xJC44+wYf/wiUg3ebYD5rwQdoifM21RtKIDHKUf+ehoopabz/F8hi4R5j0AQZJECmSblyhmGwgD4/
	AGZJd1zkUiGqXBij+gi8SK7iggx58NPya7iqhnKVSwzYhjQgSUlr9f+vMiIRgXJDwdj/SSieAo0vu
	Qvko0JpmFUPIfFs8LxJ3TKt6Q/MZdojHQP+vNivbxToWWJ4iX2246yL0VniLJweSZr4DNTiiVb54o
	quslYFHOUHYUn3myqBTUplltEHDRu6SNoBS9Lx/7/21gcy0JLj2Zpmj2OACM6TWyqe+1sujKKDCvt
	WD+MQmx7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDb-00025P-AW; Thu, 28 Jan 2021 04:47:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDX-00023u-A6
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809259; x=1643345259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nlVDSYPsDiNDIn4MgX4E8oTX+gmER/SxjozWNm4/+I0=;
 b=hogUzWWH09SokjSM5CPwA1/MhvqlID1UucUFcTfOL9CzyYi6gW6lH17J
 ewThY3bLMmJyhd40ihm+O3oNI218M7S/YnCWMhoptYs0oZw3u0dDrn+zE
 kHylY6ELKWDjxhDLZDbJXEyveehssbbvfNF+WzlsCxKtzswVciaDgC+Pu
 gL8xBlS5FHBMIedLzqF+TasF+BuHnbYzq1LM6EqPM4ZhmJ5WXhVnnRW24
 txV4ygjSwC+kgpM48cuxETlABgzYXAxmDdSZYQv6d2QOdRK5lELeTkym6
 prHBux84GM6kdtElBCCBB2gnNj/Ezm3+Ggdpm1xyYm3oNGXCTWWv1ZUwZ Q==;
IronPort-SDR: qNSeDQi4kc7/7oymtbSp7A2t0eENBYupCdUEr3niuF7LcnSDjVraOiTDk46o6NAawxY6e49pUO
 VdGeWlZn3ykII0W+4hJZ6tvstYrcI3pyuCF5mQs6m/3ea77JnYIOpkfP7whWl7IXvbMxw9pmLr
 Y2l5BZuMv+StZXgi8a6uuioFLykHbzoxq4yX72vWINquxrlq8W80vx6oGFw34/niXEZu5wr/UB
 c7idJUdglvE7uk5lk6lQhnHW/ktbwNjXNEAt4nEBah6cspLIB58uk0UvPovdGNYL6UOFikU/q6
 gMg=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:37 +0800
IronPort-SDR: mnpXFHmFZNatbO4f81RcSwhCzulJBlXPtIZmmaJElkhxjDE6E+6fLNTacLZNk0yIZJBKC4Ft8r
 +6tH+nyalNu2fPy1PmNdqzMieGstd9KHtw84X2TgiqlFf9xJJvPIp/xuERZYaCXB/5C4L3Urda
 L22A9CjtdTaeQPYXRLS0vdxY/N+jY17aE5F5uoenALscKILx9pYnWcB9Lp7xC5Ae4O15Ygh7MY
 0HRsbMCtRmqUFE1HMkzFkydGvsrg3+Z8PN8y58tJxtJJxdQr4GqBgYuTGO5f3SyxZ87XffssWl
 +EJQ+VQ7x6Ub1Cy80lrI+aFh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:31:58 -0800
IronPort-SDR: Rw4bUzOvN4mJwZLFxFUm6LpJsGwe5YcjBXIX2Ymv9mt+5XHcopn8O27sy142fveBFZy18GIqep
 dvyoGjJpSCtn0JKO6dGlnahV4dhyjT/iii6yhL5o/XGgczi5bC4+HJYI97zt156LnEvC9UlYVk
 OWD50plCdjYBxhJSEehpZDV18NEpG1mFbF301ZIQVHxOfwa450BEWZvJlo/Sadvlt4IBLUHmdk
 /zz5jCgU8+44Juwu2kXXwWCyftM6fkjACRZQfke/V/+xM0bxwwgoMgC2ZAsHUtKWQYOGvuSUoL
 usU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:36 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 1/8] block: document zone_append_max_bytes attribute
Date: Thu, 28 Jan 2021 13:47:26 +0900
Message-Id: <20210128044733.503606-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234739_611098_940945A0 
X-CRM114-Status: GOOD (  11.79  )
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

The description of the zone_append_max_bytes sysfs queue attribute is
missing from Documentation/block/queue-sysfs.rst. Add it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/block/queue-sysfs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 2638d3446b79..edc6e6960b96 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -261,6 +261,12 @@ For block drivers that support REQ_OP_WRITE_ZEROES, the maximum number of
 bytes that can be zeroed at once. The value 0 means that REQ_OP_WRITE_ZEROES
 is not supported.
 
+zone_append_max_bytes (RO)
+--------------------------
+This is the maximum number of bytes that can be written to a sequential
+zone of a zoned block device using a zone append write operation
+(REQ_OP_ZONE_APPEND). This value is always 0 for regular block devices.
+
 zoned (RO)
 ----------
 This indicates if the device is a zoned block device and the zone model of the
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
